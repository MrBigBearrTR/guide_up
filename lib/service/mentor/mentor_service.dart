import 'package:guide_up/core/models/mentor/mentee_model.dart';
import 'package:guide_up/core/models/mentor/mentor_favourite_model.dart';
import 'package:guide_up/core/models/mentor/mentor_model.dart';
import 'package:guide_up/core/models/users/user_detail/user_categories_model.dart';
import 'package:guide_up/repository/mentor/mentor_favourite_repository.dart';
import 'package:guide_up/repository/mentor/mentor_repository.dart';
import 'package:guide_up/repository/user/user_detail/user_categories_repository.dart';

import '../../core/models/category/category_model.dart';
import '../../core/utils/repository_helper.dart';
import '../../repository/mentee/mentee_repository.dart';

class MentorService {
  late MentorRepository _mentorRepository;
  late MenteeRepository _menteeRepository;
  late UserCategoriesRepository _userCategoriesRepository;
  late MentorFavouriteRepository _mentorFavouriteRepository;

  MentorService() {
    _mentorRepository = MentorRepository();
    _menteeRepository = MenteeRepository();
    _userCategoriesRepository = UserCategoriesRepository();
    _mentorFavouriteRepository = MentorFavouriteRepository();
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
      var tempMentorList = await _mentorRepository.getList(limit);
      for (var tempMentor in tempMentorList) {
        bool isContain=false;
        for (var mentor in mentorList) {
          if (tempMentor.getId()! == mentor.getId()!) {
            isContain=true;
            break;
          }
        }
        if(!isContain) {
          mentorList.add(tempMentor);
        }
      }
    }

    return mentorList;
  }

  Future<List<Mentor>> searchMentorList(
      String text, List<Category> categoryList, int limit) async {
    List<Mentor> mentorList = [];
    List<Mentor> tempUniqueMentorList = [];
    List<Mentor> tempUniqueCategoryMentorList = [];
    List<String> tempMentorIdList = [];

    if (text.isNotEmpty) {
      List<String> searchTextList = text.split(" ");

      List<Mentor> tempMentorList = [];
      for (var searchText in searchTextList) {
        String useSerchText =
            RepositoryHelper.capitalizeFirstLetter(searchText);

        if (searchText.isNotEmpty) {
          tempMentorList.addAll(await _mentorRepository.searchBySearchColumn(
              "name", useSerchText));
          tempMentorList.addAll(await _mentorRepository.searchBySearchColumn(
              "surname", useSerchText));
        }
      }

      for (var tempMentor in tempMentorList) {
        if (!tempMentorIdList.contains(tempMentor.getId()!)) {
          tempMentorIdList.add(tempMentor.getId()!);
          tempUniqueMentorList.add(tempMentor);
        }
      }
    }

    if (categoryList.isNotEmpty) {
      List<UserCategories> catList = [];
      for (var tempCat in categoryList) {
        catList.addAll(await _userCategoriesRepository
            .getUserCategoriesListByCategoryId(tempCat.getId()!));
      }

      List<String> tempUserIdList = [];
      List<UserCategories> tempUniqueCategoryList = [];
      for (var tempCat in catList) {
        if (!tempUserIdList.contains(tempCat.getId()!)) {
          tempUserIdList.add(tempCat.getId()!);
          tempUniqueCategoryList.add(tempCat);
        }
      }
      for (var tempCat in tempUniqueCategoryList) {
        tempUniqueCategoryMentorList
            .add((await _mentorRepository.get(tempCat.getUserId()!))!);
      }
    }

    if (text.isNotEmpty) {
      if (categoryList.isNotEmpty) {
        for (var tempMentorId in tempMentorIdList) {
          for (var tempMentor in tempUniqueCategoryMentorList) {
            if (tempMentor.getId()!.compareTo(tempMentorId) == 0) {
              mentorList.add(tempMentor);
            }
          }
        }
      } else {
        mentorList.addAll(tempUniqueMentorList);
      }
    } else {
      mentorList.addAll(tempUniqueCategoryMentorList);
    }

    return mentorList;
  }

  Future<List<Mentor>> getMentorFavouriteListByUserId(String userId) async {
    List<Mentor> mentorList = [];

    List<MentorFavourite> mentorFavouriteList =
        await _mentorFavouriteRepository.getMentorFavouriteListByUserId(userId);

    for (var mentorFavourite in mentorFavouriteList) {
      Mentor? mentor =
          await _mentorRepository.get(mentorFavourite.getMentorId()!);
      if (mentor != null) {
        mentorList.add(mentor);
      }
    }
    return mentorList;
  }
}
