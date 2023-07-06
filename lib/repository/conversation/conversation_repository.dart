import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constant/firestore_collectioon_constant.dart';
import '../../core/models/conversation/conversation.dart';

class ConversationRepository {
  late final CollectionReference<Map<String, dynamic>> _conversationCollections;

  ConversationRepository() {
    _conversationCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.conversation);
  }

  Future<List<Conversation>> getConversationsByUserId(
      String userId, int limit) async {
    List<Conversation> categoryList = [];
    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await _conversationCollections
          .where("firstParticipantUserId", isEqualTo: userId)
          .where("secondParticipantUserId", isEqualTo: userId)
          .limit(limit)
          .get();
    } else {
      query = await _conversationCollections
          .where("firstParticipantUserId", isEqualTo: userId)
          .where("secondParticipantUserId", isEqualTo: userId)
          .get();
    }

    categoryList = convertResponseObjectToList(query.docs.iterator);

    return categoryList;
  }

  List<Conversation> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<Conversation> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      Conversation temp = Conversation();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
