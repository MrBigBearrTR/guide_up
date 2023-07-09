import 'package:guide_up/core/dto/conversation/conversation_card_view.dart';
import 'package:guide_up/core/models/conversation/messages/messages.dart';
import 'package:guide_up/core/utils/user_messages_helper.dart';
import 'package:guide_up/repository/conversation/messages/messages_repository.dart';

class MessagesService {
  late MessagesRepository _messagesRepository;

  MessagesService() {
    _messagesRepository = MessagesRepository();
  }

  Future<Messages> add(
      Messages messages, ConversationCardView conversationCardView) async {
    Messages rtnMessages = await _messagesRepository.add(messages);

    ConversationCardView newCardView=ConversationCardView();
    newCardView.id=conversationCardView.id;

    newCardView.myUserId=conversationCardView.otherParticipantUserId;
    newCardView.myName=conversationCardView.otherParticipantName;
    newCardView.myFullName=conversationCardView.otherParticipantFullName;
    newCardView.myPhoto=conversationCardView.otherParticipantPhoto;

    newCardView.otherParticipantUserId=conversationCardView.myUserId;
    newCardView.otherParticipantName=conversationCardView.myName;
    newCardView.otherParticipantFullName=conversationCardView.myFullName;
    newCardView.otherParticipantPhoto=conversationCardView.myPhoto;

    newCardView.lastMessage=messages.getContent()!;
    newCardView.lastMessageSenderName=conversationCardView.myName;

    newCardView.isHiddenFromFirst=conversationCardView.isHiddenFromSecond;
    newCardView.isHiddenFromSecond=conversationCardView.isHiddenFromFirst;

    UserMessagesHelper().sendPushMessage(messages.getReceiverUserId()!,
        conversationCardView.myName, messages.getContent()!,clickContent: newCardView.toJson());
    return rtnMessages;
  }

  Future<Messages?> getLastMessages(String conversationId) async {
    return _messagesRepository.getLastMessages(conversationId);
  }
}
