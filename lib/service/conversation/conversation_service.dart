import 'package:guide_up/core/dto/conversation/conversation_card_view.dart';
import 'package:guide_up/core/models/conversation/conversation.dart';
import 'package:guide_up/repository/conversation/conversation_repository.dart';
import 'package:guide_up/service/conversation/messages/messages_service.dart';
import 'package:guide_up/service/user/user_detail/user_detail_service.dart';

import '../../core/models/conversation/messages/messages.dart';
import '../../core/models/users/user_detail/user_detail_model.dart';

class ConversationService {
  late ConversationRepository _conversationRepository;
  late MessagesService _messagesService;
  late UserDetailService _userDetailService;

  ConversationService() {
    _conversationRepository = ConversationRepository();
    _userDetailService = UserDetailService();
    _messagesService = MessagesService();
  }

  createNewConversation(UserDetail userDetail, String secondParticipantUserId,
      String content) async {
    Conversation conversation = Conversation();
    conversation.setFirstParticipantUserId(userDetail.getUserId()!);
    conversation.setSecondParticipantUserId(secondParticipantUserId);
    conversation = await _conversationRepository.add(conversation);

    Messages messages = Messages();
    messages.setConversationId(conversation.getId()!);
    messages.setSenderUserId(userDetail.getUserId()!);
    messages.setReceiverUserId(secondParticipantUserId);
    messages.setContent(content);
    _messagesService.add(
        messages,
        await convertToConversationCardView(userDetail, conversation,
            messages: messages));
  }

  Future<List<Conversation>> getConversationsByUserId(
      String userId, int limit) async {
    return _conversationRepository.getList(userId, limit);
  }

  Future<List<ConversationCardView>> getConversationCardViewByUserId(
      UserDetail? userDetail, int limit) async {
    List<ConversationCardView> conversationCardViewList = [];
    if (userDetail != null) {
      String myUserId = userDetail.getUserId()!;
      List<Conversation> conversationList =
          await _conversationRepository.getList(myUserId, limit);

      for (var conversation in conversationList) {
        conversationCardViewList
            .add(await convertToConversationCardView(userDetail, conversation));
      }
    }
    return conversationCardViewList;
  }

  Future<ConversationCardView> convertToConversationCardView(
      UserDetail userDetail, Conversation conversation,
      {Messages? messages}) async {
    String myUserId = userDetail.getUserId()!;
    var otherUserId = "";
    UserDetail? otherUserDetail;
    ConversationCardView conversationCardView = ConversationCardView();

    if (conversation.getFirstParticipantUserId()!.compareTo(myUserId) != 0) {
      otherUserId = conversation.getFirstParticipantUserId()!;
    } else {
      otherUserId = conversation.getSecondParticipantUserId()!;
    }

    otherUserDetail = await _userDetailService.getUserByUserId(otherUserId);

    if (otherUserDetail != null) {
      conversationCardView.id = conversation.getId()!;

      conversationCardView.otherParticipantUserId = otherUserId;
      conversationCardView.otherParticipantName = otherUserDetail.getName()!;
      conversationCardView.otherParticipantFullName =
          "${otherUserDetail.getName()!} ${otherUserDetail.getSurname()!}";
      conversationCardView.otherParticipantPhoto = otherUserDetail.getPhoto();

      conversationCardView.myUserId = myUserId;
      conversationCardView.myName = userDetail.getName()!;
      conversationCardView.myFullName =
          "${userDetail.getName()!} ${userDetail.getSurname()!}";
      conversationCardView.myPhoto = userDetail.getPhoto();

      if (messages != null) {
        conversationCardView.lastMessage = messages.getContent()!;

        if (messages.getSenderUserId()!.compareTo(myUserId) == 0) {
          conversationCardView.lastMessageSenderName = "Sen";
        } else {
          conversationCardView.lastMessageSenderName =
              otherUserDetail.getName()!;
        }
      } else {
        Messages? lastMessages =
            await _messagesService.getLastMessages(conversation.getId()!);
        if (lastMessages != null) {
          conversationCardView.lastMessage = lastMessages.getContent()!;
          if (lastMessages.getSenderUserId()!.compareTo(myUserId) == 0) {
            conversationCardView.lastMessageSenderName = "Sen";
          } else {
            conversationCardView.lastMessageSenderName =
                otherUserDetail.getName()!;
          }
        }
      }
    }
    return conversationCardView;
  }
}
