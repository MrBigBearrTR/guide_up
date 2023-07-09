import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/users/user_abilities/user_abilities_model.dart';
import '../../../core/constant/firestore_collectioon_constant.dart';

class UserAbilitiesRepository {

  late final CollectionReference<Map<String, dynamic>>
      _userAbilitiesCollections;

  UserAbilitiesRepository() {
    _userAbilitiesCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.userAbilities);
  }

  Future<UserAbilities> add(UserAbilities userAbilities) async {
    userAbilities.dbCheck(userAbilities.getUserId()!);

    var process = await _userAbilitiesCollections.add(userAbilities.toMap());
    userAbilities.setId(process.id);

    await _userAbilitiesCollections.doc(process.id).set(userAbilities.toMap());

    return userAbilities;
  }

  Future<List<UserAbilities>> getUserAbilitiesListByUserId(
      String userId) async {
    List<UserAbilities> abilitiesList = [];
    var query = await _userAbilitiesCollections
        .where("userId", isEqualTo: userId)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      abilitiesList = convertResponseObjectToList(query.docs.iterator);
    }
    return abilitiesList;
  }

  Future<void> update(UserAbilities userAbilities) async {
    await _userAbilitiesCollections
        .doc(userAbilities.getId()!)
        .update(userAbilities.toMap());
  }

  Future<void> delete(UserAbilities abilities) async {
    abilities.setActive(false);
    await _userAbilitiesCollections
        .doc(abilities.getId()!)
        .update(abilities.toMap());
  }

  List<UserAbilities> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<UserAbilities> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      UserAbilities temp = UserAbilities();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }

}
