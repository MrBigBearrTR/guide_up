import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constant/firestore_collectioon_constant.dart';
import '../../../core/models/users/user_license_and_certificate/user_license_and_certificate_model.dart';

class UserLicenseAndCertificateRepository {
  late final CollectionReference<
      Map<String, dynamic>> _licensesAndCertificatesCollection;

  UserLicenseAndCertificateRepository() {
    _licensesAndCertificatesCollection = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.userLicence);
  }
  Future<UserLicenseAndCertificate> add(UserLicenseAndCertificate userLicenseAndCertificate) async {
    userLicenseAndCertificate.dbCheck(userLicenseAndCertificate.getUserId()!);

    var process = await _licensesAndCertificatesCollection.add(userLicenseAndCertificate.toMap());
    userLicenseAndCertificate.setId(process.id);

    await _licensesAndCertificatesCollection.doc(process.id).set(userLicenseAndCertificate.toMap());

    return userLicenseAndCertificate;
  }

  Future<List<UserLicenseAndCertificate>> getUserLicenseAndCertificateListByUserId(
      String userId) async {
    List<UserLicenseAndCertificate> licenseAndCertificateList = [];
    var query = await _licensesAndCertificatesCollection
        .where("userId", isEqualTo: userId)
        .where("isActive", isEqualTo: true)
        .get();

    if (query.docs.isNotEmpty) {
      licenseAndCertificateList = convertResponseObjectToList(query.docs.iterator);
    }
    return licenseAndCertificateList;
  }

  Future<List<UserLicenseAndCertificate>> getUserLicenseAndCertificateList() async {
    List<UserLicenseAndCertificate> licenseAndCertificateList = [];
    var querySnapshot = await _licensesAndCertificatesCollection.get();

    for (var docSnapshot in querySnapshot.docs) {
      UserLicenseAndCertificate userLicenseAndCertificate = UserLicenseAndCertificate();
      userLicenseAndCertificate.toClass(docSnapshot.data());
      licenseAndCertificateList.add(userLicenseAndCertificate);
    }

    return licenseAndCertificateList;
  }

    Future<void> update(UserLicenseAndCertificate userLicenseAndCertificate) async {
      await _licensesAndCertificatesCollection
          .doc(userLicenseAndCertificate.getId()!)
          .update(userLicenseAndCertificate.toMap());
    }

    Future<void> delete(UserLicenseAndCertificate project) async {
      project.setActive(false);
      await _licensesAndCertificatesCollection
          .doc(project.getId()!)
          .update(project.toMap());
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
