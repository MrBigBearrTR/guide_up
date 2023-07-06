import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/conversation/messages/messages.dart';
import 'package:guide_up/core/models/general/general_repository.dart';

import '../../../core/constant/firestore_collectioon_constant.dart';

class MessagesRepository extends GeneralRepository<Messages> {
  late final CollectionReference<Map<String, dynamic>> _messagesCollections;
  late final CollectionReference<Map<String, dynamic>> _conversationCollections;

  MessagesRepository() {
    _messagesCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.messages);
    _conversationCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.conversation);
  }

  @override
  Future<Messages> add(Messages model) async {
    model.dbCheck(model.getSenderUserId()!);

    var process = await _messagesCollections.add(model.toMap());

    model.setId(process.id);
    await _messagesCollections.doc(process.id).update(model.toMap());

    return model;
  }

  @override
  Future<Messages?> get(String id) async {
    var query = await _messagesCollections.doc(id).get();

    if (query.data() != null) {
      return Messages().toClass(query.data()!);
    }
    return null;
  }

  Future<List<Messages>> getUserMessagesListByUserId(String userId) async {
    List<Messages> messagesList = [];
    var query =
        await _messagesCollections.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      messagesList = convertResponseObjectToList(query.docs.iterator);
    }
    return messagesList;
  }

  Stream<List<Messages>> getLastMessages(String conversationId, String userId) {
    var snapShot = _conversationCollections
        .doc(conversationId)
        .collection(FirestoreCollectionConstant.conversation)
        .orderBy("createDate", descending: true)
        .limit(1)
        .snapshots();
    return snapShot.map((messagesList) => messagesList.docs
        .map((e) => Messages().toClass(e.data()))
        .toList() as List<Messages>);
  }

  Future<int> getUserMessagesListCountByUserId(String userId) async {
    int listCount = 0;
    var query =
        await _messagesCollections.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  @override
  Future<List<Messages>> getList(String userId, int limit) async {
    List<Messages> messagesList = [];

    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await _messagesCollections.limit(limit).get();
    } else {
      query = await _messagesCollections.get();
    }

    if (query.docs.isNotEmpty) {
      messagesList = convertResponseObjectToList(query.docs.iterator);
    }

    return messagesList;
  }

  @override
  Future update(Messages model) async {
    await _messagesCollections.doc(model.getId()!).update(model.toMap());
  }

  @override
  Future<void> delete(Messages model) async {
    model.setActive(false);
    _messagesCollections.doc(model.getId()!).update(model.toMap());
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
