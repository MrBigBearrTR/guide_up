import 'package:guide_up/core/models/mentor/mentee_model.dart';
import 'package:guide_up/core/models/mentor/mentor_model.dart';
import 'package:guide_up/repository/mentor/mentor_repository.dart';

import '../../core/models/category/category_model.dart';
import '../../core/utils/repository_helper.dart';
import '../../repository/mentee/mentee_repository.dart';

class MentorService {
  late MentorRepository _mentorRepository;
  late MenteeRepository _menteeRepository;

  MentorService() {
    _mentorRepository = MentorRepository();
    _menteeRepository = MenteeRepository();
  }

  Future<List<Mentor>> getTopMentorList(int limit) async {
    List<Mentor> mentorList = [];

    List<Mentee> menteeList = await _menteeRepository.getList(0);
    if (menteeList.isNotEmpty) {
      Map<String, int> mostMap = {};
      for (var mentee in menteeList) {
        int count = 0;
        if (mostMap.containsKey(mentee.getMentorId())) {
          count = mostMap[mentee.getMentorId()]!;
        }
        count++;
        mostMap[mentee.getMentorId()!] = count;
      }

      Map<String, int> sortedMap = RepositoryHelper.sortedByCount(mostMap);

      if (limit > 0) {
        for (var entry in sortedMap.entries) {
          if (limit == 0) {
            break;
          } else {
            Mentor? mentor = await _mentorRepository.get(entry.key);
            if (mentor != null) {
              mentorList.add(mentor);
            }
            limit--;
          }
        }
      } else {
        for (var entry in sortedMap.entries) {
          Mentor? mentor = await _mentorRepository.get(entry.key);
          if (mentor != null) {
            mentorList.add(mentor);
          }
        }
      }
    }

    if (limit > 0 && mentorList.length < limit) {
      mentorList.addAll(await _mentorRepository.getList(limit));
    }

    return mentorList;
  }

  Future<List<Mentor>> searchMentorList(
      String text, List<Category> categoryList, int limit) async {
    List<Mentor> mentorList = [];

//TODO BigBear devam edilecek

    return mentorList;
  }
}
