import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constant/firestore_collectioon_constant.dart';
import '../../core/models/conversation/conversation.dart';
import '../../core/models/general/general_repository.dart';

class ConversationRepository extends GeneralRepository<Conversation> {
  late final CollectionReference<Map<String, dynamic>> _conversationCollections;

  ConversationRepository() {
    _conversationCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.conversation);
  }

  @override
  Future<Conversation> add(Conversation model) async {
    model.dbCheck(model.getFirstParticipantUserId()!);

    var process = await _conversationCollections.add(model.toMap());

    model.setId(process.id);
    await _conversationCollections.doc(process.id).update(model.toMap());

    return model;
  }

  @override
  Future<Conversation?> get(String id) async {
    var query = await _conversationCollections.doc(id).get();

    if (query.data() != null) {
      return Conversation().toClass(query.data()!);
    }
    return null;
  }

  Future<Conversation?> getConversation(
      String firstUserId, String secondUserId) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];

    var query = await _conversationCollections
        .where("firstParticipantUserId", isEqualTo: firstUserId)
        .where("secondParticipantUserId", isEqualTo: secondUserId)
        .get();
    list.addAll(query.docs);

    var query2 = await _conversationCollections
        .where("firstParticipantUserId", isEqualTo: secondUserId)
        .where("secondParticipantUserId", isEqualTo: firstUserId)
        .get();
    list.addAll(query2.docs);


    if (list.isNotEmpty) {
      return Conversation().toClass(list.first.data());
    }

    return null;
  }

  @override
  Future<List<Conversation>> getList(String userId, int limit) async {
    List<Conversation> conversationList = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];

    if (limit > 0) {
      var query = await _conversationCollections
          .where("firstParticipantUserId", isEqualTo: userId)
          .limit(limit)
          .get();
      list.addAll(query.docs);

      var query2 = await _conversationCollections
          .where("secondParticipantUserId", isEqualTo: userId)
          .limit(limit)
          .get();
      list.addAll(query2.docs);
    } else {
      var query = await _conversationCollections
          .where("firstParticipantUserId", isEqualTo: userId)
          .get();
      list.addAll(query.docs);

      var query2 = await _conversationCollections
          .where("secondParticipantUserId", isEqualTo: userId)
          .get();
      list.addAll(query2.docs);
    }

    conversationList = convertResponseObjectToList(list.iterator);

    return conversationList;
  }

  @override
  Future update(Conversation model) async {
    await _conversationCollections.doc(model.getId()!).update(model.toMap());
  }

  @override
  Future<void> delete(Conversation model) async {
    model.setActive(false);
    _conversationCollections.doc(model.getId()!).update(model.toMap());
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
