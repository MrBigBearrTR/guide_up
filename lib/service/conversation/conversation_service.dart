
import 'package:guide_up/core/dto/conversation/conversation_card_view.dart';
import 'package:guide_up/core/models/conversation/conversation.dart';
import 'package:guide_up/repository/conversation/conversation_repository.dart';
import 'package:guide_up/service/user/user_detail/user_detail_service.dart';

import '../../core/models/users/user_detail/user_detail_model.dart';

class ConversationService{

  late ConversationRepository _conversationRepository;
  late UserDetailService _userDetailService;

  ConversationService(){
    _conversationRepository=ConversationRepository();
    _userDetailService=UserDetailService();
  }

  Future<List<Conversation>> getConversationsByUserId(String userId,int limit)async{
    return _conversationRepository.getConversationsByUserId(userId, limit);
  }

  Future<List<ConversationCardView>> getConversationCardViewByUserId(String userId,int limit)async{
    List<ConversationCardView> conversationCardViewList=[];
    List<Conversation> conversationList= await _conversationRepository.getConversationsByUserId(userId, limit);

    for (var conversation in conversationList) {
      var otherUserId="";
      UserDetail? otherUserDetail;
      ConversationCardView conversationCardView=ConversationCardView();

      if(conversation.getFirstParticipantUserId()!.compareTo(userId)!=0){
        otherUserId=conversation.getFirstParticipantUserId()!;
      }else{
        otherUserId=conversation.getSecondParticipantUserId()!;
      }

      otherUserDetail= await _userDetailService.getUserByUserId(otherUserId);

      if(otherUserDetail!=null){
        conversationCardView.id=conversation.getId()!;

        conversationCardView.otherParticipantName=otherUserDetail.getName()!;
        conversationCardView.otherParticipantFullName="${otherUserDetail.getName()!} ${otherUserDetail.getSurname()!}";
        conversationCardView.otherParticipantPhoto=otherUserDetail.getPhoto();
        conversationCardView.otherParticipantUserId=otherUserId;

        //conversationCardView.

      }

    }

    return conversationCardViewList;
  }




}