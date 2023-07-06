import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide_up/core/models/mentor/mentee_model.dart';
import 'package:guide_up/core/models/mentor/mentor_commend_model.dart';
import 'package:guide_up/core/models/mentor/mentee_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';

import '../../core/constant/firestore_collectioon_constant.dart';

class MenteeRepository {
  late final CollectionReference<Map<String, dynamic>> menteeCollections;
  // Ekranda geçirilen süre için veri deposu
  List<int> educationHours = [];
  //List<Mentee> educationHours = [40, 60, 30, 45, 55];

  // Favori mentorlar için veri deposu
  List<Mentee> favoriteMentors = [];

  // MentorCommend nesneleri için veri deposu
  List<MentorCommend> commendList = [];

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

  // Yorumları ve sayısı için veri deposu
  void getMenteeCommends(List<MentorCommend> commendList) {
  Map<String, int> mentorCommentCount = {};

  for (var commend in commendList) {
    String? menteeId = commend.getUserId();

    // Eğer menteeId null ise veya boş bir değer ise atlamak için continue kullanabilirsiniz
    if (menteeId == null || menteeId.isEmpty) {
      continue;
    }

    if (mentorCommentCount.containsKey(menteeId)) {
      mentorCommentCount[menteeId] = mentorCommentCount[menteeId]! + 1;
    } else {
      mentorCommentCount[menteeId] = 1;
    }
  }

  // Mentee yorum sayılarını yazdırma
  // for (var entry in mentorCommentCount.entries) {
  //   print('Mentee ID: ${entry.key}, Comment Count: ${entry.value}');
  // }
}

  void getMenteePayments(List<Mentee> menteeList, String menteeId) {
  Map<String, double> menteePayments = {};

  for (var mentee in menteeList) {
    if (mentee.getUserId() == menteeId) {
      String? mentorId = mentee.getMentorId();
      String? price = mentee.getPrice();

      // Eğer mentorId veya price null ise veya boş bir değer ise atlamak için continue kullanıldı
      if (mentorId == null || mentorId.isEmpty || price == null || price.isEmpty) {
        continue;
      }

      double? payment = double.tryParse(price);

      if (payment != null) {
        if (menteePayments.containsKey(mentorId)) {
          menteePayments[mentorId] = menteePayments[mentorId]! + payment;
        } else {
          menteePayments[mentorId] = payment;
        }
      }
    }
  }

  // Mentora ödenen ücretleri ve toplam tutarı yazdırma
  // for (var entry in menteePayments.entries) {
  //   print('Mentor ID: ${entry.key}, Payment: ${entry.value}');
  // }

  double totalPayment = menteePayments.values.fold(0, (sum, payment) => sum + payment);
  //print('Total Payment: $totalPayment');
}

}
