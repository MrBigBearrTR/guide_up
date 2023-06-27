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

    var query = await userlinksCollections.where(
        "userId", isEqualTo: userId).get();

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
}
