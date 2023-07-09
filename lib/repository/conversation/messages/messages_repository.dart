import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/conversation/messages/messages.dart';

import '../../../core/constant/firestore_collectioon_constant.dart';

class MessagesRepository {
  late final CollectionReference<Map<String, dynamic>> _conversationCollections;

  MessagesRepository() {
    _conversationCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.conversation);
  }

  Future<Messages> add(Messages model) async {
    model.dbCheck(model.getSenderUserId()!);

    var process = await _conversationCollections
        .doc(model.getConversationId()!)
        .collection(FirestoreCollectionConstant.messages)
        .add(model.toMap());

    model.setId(process.id);
    await _conversationCollections
        .doc(model.getConversationId()!)
        .collection(FirestoreCollectionConstant.messages)
        .doc(process.id)
        .update(model.toMap());

    return model;
  }

  Future<Messages?> get(String conversationId, String id) async {
    var query = await _conversationCollections
        .doc(conversationId)
        .collection(FirestoreCollectionConstant.messages)
        .doc(id)
        .collection(FirestoreCollectionConstant.messages)
        .doc(id)
        .get();

    if (query.data() != null) {
      return Messages().toClass(query.data()!);
    } else {
      return null;
    }
  }

  Stream<List<Messages>> getLastMessagesStream(
      String conversationId, String userId) {
    var snapShot = _conversationCollections
        .doc(conversationId)
        .collection(FirestoreCollectionConstant.messages)
        .orderBy("createDate", descending: true)
        .limit(1)
        .snapshots();
    return snapShot.map((messagesList) =>
        messagesList.docs.map((e) => Messages().toClass(e.data())).toList());
  }

  Future<Messages?> getLastMessages(String conversationId) async {
    var query = await _conversationCollections
        .doc(conversationId)
        .collection(FirestoreCollectionConstant.messages)
        .orderBy("createDate", descending: true)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return Messages().toClass(query.docs.first.data());
    } else {
      return null;
    }
  }

  Future<List<Messages>> getMessagesList(
      String conversationId, int limit, DateTime? lastDateTime) async {
    List<Messages> messagesList = [];
    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      if (lastDateTime == null) {
        query = await _conversationCollections
            .doc(conversationId)
            .collection(FirestoreCollectionConstant.messages)
            .orderBy("createDate", descending: true)
            .limit(limit)
            .get();
      } else {
        query = await _conversationCollections
            .doc(conversationId)
            .collection(FirestoreCollectionConstant.messages)
            .orderBy("createDate", descending: true)
            .startAfter([lastDateTime.toString()])
            .limit(limit)
            .get();
      }
    } else {
      if (lastDateTime == null) {
        query = await _conversationCollections
            .doc(conversationId)
            .collection(FirestoreCollectionConstant.messages)
            .orderBy("createDate", descending: true)
            .get();
      } else {
        query = await _conversationCollections
            .doc(conversationId)
            .collection(FirestoreCollectionConstant.messages)
            .orderBy("createDate", descending: true)
            .startAfter([lastDateTime.toString()]).get();
      }
    }
    if (query.docs.isNotEmpty) {
      return convertResponseObjectToList(query.docs.iterator);
    }
    return messagesList;
  }

  Future update(Messages model) async {
    await _conversationCollections
        .doc(model.getConversationId()!)
        .collection(FirestoreCollectionConstant.messages)
        .doc(model.getId()!)
        .update(model.toMap());
  }

  Future<void> delete(Messages model) async {
    model.setActive(false);
    _conversationCollections
        .doc(model.getConversationId()!)
        .collection(FirestoreCollectionConstant.messages)
        .doc(model.getId()!)
        .update(model.toMap());
  }

  List<Messages> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<Messages> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      Messages temp = Messages();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }
}
