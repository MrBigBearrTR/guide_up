import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/mentor/mentee_model.dart';
import 'package:guide_up/core/models/mentor/mentor_commend_model.dart';
import 'package:guide_up/core/models/mentor/mentee_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';

import '../../core/constant/firestore_collectioon_constant.dart';

class MenteeRepository {
  late final CollectionReference<Map<String, dynamic>> menteeCollections;
  List<int> educationHours = [];
  List<Mentee> favoriteMentors = [];

  // Ekranda geçirilen süre için veri deposu
  //List<int> educationHours = [40, 60, 30, 45, 55];
  //List<Mentee> educationHours = [40, 60, 30, 45, 55];

  // Favori mentorlar için veri deposu
  //List<String> favoriteMentors = ['Helin', 'Kerem'];

  MenteeRepository() {
    menteeCollections = FirebaseFirestore.instance
        .collection(FirestoreCollectionConstant.category);
  }

  Future getTotalCount() async {
    // Veri deposundaki tüm eğitim saatlerini toplayan fonksiyon
    int totalCount = 0;

    for (int hours in educationHours) {
      totalCount += hours;
    }

    return totalCount;
  }

  List<Mentee> getFavoriteMentors() {
    // Veri deposundaki favori mentorları gösteren fonskiyon
    return favoriteMentors;
  }

  // Yorum fonksiyonu gelecek.
  // List<Mentee> getCommend() {
  //   // Veri deposundaki favori mentorları gösteren fonskiyon
  //   return getCommendList();
  // }

  // Future<List<Mentee>> getPrice() async {
    
  //   return
  // }
}
