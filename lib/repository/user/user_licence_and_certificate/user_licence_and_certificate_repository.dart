import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constant/firestore_collectioon_constant.dart';
import '../../../core/models/users/user_license_and_certificate/user_license_and_certificate_model.dart';

class UserLicenseAndCertificateRepository {
  late final CollectionReference<
      Map<String, dynamic>> _licensesAndCertificatesCollection;

  UserLicenseAndCertificateRepository() {
    _licensesAndCertificatesCollection = FirebaseFirestore.instance.collection(
        FirestoreCollectionConstant.userLicence);
  }
  Future<UserLicenseAndCertificate> add(UserLicenseAndCertificate userLicenseAndCertificate) async {
    userLicenseAndCertificate.dbCheck(userLicenseAndCertificate.getUserId()!);

    var process = await _licensesAndCertificatesCollection.add(userLicenseAndCertificate.toMap());

    userLicenseAndCertificate.setId(process.id);
    await _licensesAndCertificatesCollection.doc(process.id).set(userLicenseAndCertificate.toMap());

    return userLicenseAndCertificate;
  }

  Future<UserLicenseAndCertificate?> get(String id) async {
    var query = await _licensesAndCertificatesCollection.doc(id).get();

    if (query.data() != null) {
      return UserLicenseAndCertificate()..toClass(query.data()!);
    }
    return null;
  }

  Future<List<UserLicenseAndCertificate>> getUserLicenseAndCertificateListByUserId(String userId) async {
    List<UserLicenseAndCertificate> licenseAndCertificateList = [];
    var query = await _licensesAndCertificatesCollection.where("userId", isEqualTo: userId).where("isActive", isEqualTo: true).get();

    if (query.docs.isNotEmpty) {
      licenseAndCertificateList = convertResponseObjectToList(query.docs.iterator);
    }
    return licenseAndCertificateList;
  }

  Future<int> getUserProjectListCountByUserId(String userId) async {
    int listCount = 0;
    var query = await _licensesAndCertificatesCollection.where("userId", isEqualTo: userId).get();

    if (query.docs.isNotEmpty) {
      listCount = query.docs.length;
    }
    return listCount;
  }

  Future<List<UserLicenseAndCertificate>> getList(int limit) async {
    List<UserLicenseAndCertificate> projectList = [];

    QuerySnapshot<Map<String, dynamic>> query;

    if (limit > 0) {
      query = await _licensesAndCertificatesCollection.limit(limit).get();
    } else {
      query = await _licensesAndCertificatesCollection.get();
    }

    if (query.docs.isNotEmpty) {
      projectList = convertResponseObjectToList(query.docs.iterator);
    }

    return projectList;
  }

  Future<void> update(UserLicenseAndCertificate userLicenseAndCertificate) async {
    await _licensesAndCertificatesCollection.doc(userLicenseAndCertificate.getId()!).update(userLicenseAndCertificate.toMap());
  }

  Future<void> delete(UserLicenseAndCertificate project) async {
    project.setActive(false);
    await _licensesAndCertificatesCollection.doc(project.getId()!).update(project.toMap());
  }

  List<UserLicenseAndCertificate> convertResponseObjectToList(
      Iterator<QueryDocumentSnapshot<Map<String, dynamic>>> it) {
    List<UserLicenseAndCertificate> returnList = [];

    while (it.moveNext()) {
      QueryDocumentSnapshot<Map<String, dynamic>> snap = it.current;
      UserLicenseAndCertificate temp = UserLicenseAndCertificate();
      temp.toClass(snap.data());
      returnList.add(temp);
    }

    return returnList;
  }

}
