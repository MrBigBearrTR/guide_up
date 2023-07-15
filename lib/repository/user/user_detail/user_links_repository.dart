import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constant/firestore_collectioon_constant.dart';
import '../../../core/models/users/user_detail/user_links_model.dart';

class UserLinksRepository {
  late final CollectionReference<Map<String, dynamic>> userlinksCollections;

  UserLinksRepository() {
    userlinksCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.userLinks);
  }

  Future<List<UserLinks>> getUserLinksByUserId(String userId) async {
    List<UserLinks> userLinksList = [];

    var query = await userlinksCollections
        .where("userId", isEqualTo: userId)
        .where("isActive", isEqualTo: true)
        .get();

    Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it =
        query.docs.iterator;

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      UserLinks links = UserLinks();
      links.toClass(snap.data());
      userLinksList.add(links);
    }

    return userLinksList;
  }

  Future<UserLinks> add(UserLinks links) async {
    links.dbCheck(links.getUserId()!);

    var process = await userlinksCollections.add(links.toMap());

    links.setId(process.id);
    await userlinksCollections.doc(process.id).update(links.toMap());

    return links;
  }

  Future delete(UserLinks links) async {
    links.setActive(false);
    await userlinksCollections.doc(links.getId()!).update(links.toMap());
  }
}
