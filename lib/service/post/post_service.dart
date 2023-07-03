import 'package:guide_up/core/dto/post/post_card_view.dart';
import 'package:guide_up/core/enumeration/enums/EnLikeSaveType.dart';
import 'package:guide_up/core/models/post/post_categories_model.dart';
import 'package:guide_up/core/models/post/post_like_save_model.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/repository/post/post_categories_repository.dart';
import 'package:guide_up/repository/post/post_like_save_repository.dart';
import 'package:guide_up/repository/post/post_repository.dart';
import 'package:guide_up/repository/user/user_detail/user_detail_repository.dart';

import '../../core/models/category/category_model.dart';
import '../../core/models/post/post_model.dart';
import '../../core/utils/repository_helper.dart';

class PostService {
  late PostLikeSaveRepository _postLikeSaveRepository;
  late PostRepository _postRepository;
  late UserDetailRepository _userDetailRepository;
  late PostCategoriesRepository _postCategoriesRepository;

  PostService() {
    _postLikeSaveRepository = PostLikeSaveRepository();
    _postRepository = PostRepository();
    _userDetailRepository = UserDetailRepository();
    _postCategoriesRepository = PostCategoriesRepository();
  }

  Future<List<Post>> getMostPopularPostList(int limit) async {
    List<Post> postList = [];

    List<PostLikeSave> postLikeSaveList =
        await _postLikeSaveRepository.getListByType(EnLikeSaveType.like);
    if (postLikeSaveList.isNotEmpty) {
      Map<String, int> likeMap = {};
      for (var postLikeSave in postLikeSaveList) {
        int count = 0;
        if (likeMap.containsKey(postLikeSave.getPostId())) {
          count = likeMap[postLikeSave.getPostId()]!;
        }
        count++;
        likeMap[postLikeSave.getPostId()!] = count;
      }

      Map<String, int> sortedMap = RepositoryHelper.sortedByCount(likeMap);

      if (limit > 0) {
        for (var entry in sortedMap.entries) {
          if (limit == 0) {
            break;
          } else {
            Post? post = await _postRepository.get(entry.key);
            if (post != null) {
              postList.add(post);
            }
            limit--;
          }
        }
      } else {
        for (var entry in sortedMap.entries) {
          Post? post = await _postRepository.get(entry.key);
          if (post != null) {
            postList.add(post);
          }
        }
      }
    }

    if (limit > 0 && postList.length < limit) {
      postList.addAll(await _postRepository.getList(limit));
    }

    return postList;
  }
  
  Future<List<Post>> searchPostList(String text,List<Category> categoryList,int limit)async{
    List<Post> postList = [];
    List<Post> tempUniquePostList = [];
    List<Post> tempUniqueCategoryPostList = [];
    List<String> tempPostIdList = [];

    if (text.isNotEmpty) {
      List<String> searchTextList = text.split(" ");

      List<Post> tempPostList = [];
      for (var searchText in searchTextList) {
        String useSerchText =
        RepositoryHelper.capitalizeFirstLetter(searchText);

        if (searchText.isNotEmpty) {
          tempPostList.addAll(await _postRepository.searchBySearchColumn(
              "topic", useSerchText));
          tempPostList.addAll(await _postRepository.searchBySearchColumn(
              "content", useSerchText));
        }
      }

      for (var tempPost in tempPostList) {
        if (!tempPostIdList.contains(tempPost.getId()!)) {
          tempPostIdList.add(tempPost.getId()!);
          tempUniquePostList.add(tempPost);
        }
      }
    }

    if (categoryList.isNotEmpty) {
      List<PostCategories> catList = [];
      for (var tempCat in categoryList) {
        catList.addAll(await _postCategoriesRepository
            .getCategoriesPostListByPostId(tempCat.getId()!));
      }

      List<String> tempUserIdList = [];
      List<PostCategories> tempUniqueCategoryList = [];
      for (var tempCat in catList) {
        if (!tempUserIdList.contains(tempCat.getId()!)) {
          tempUserIdList.add(tempCat.getId()!);
          tempUniqueCategoryList.add(tempCat);
        }
      }
      for (var tempCat in tempUniqueCategoryList) {
        tempUniqueCategoryPostList
            .add((await _postRepository.get(tempCat.getPostId()!))!);
      }
    }

    if (text.isNotEmpty) {
      if (categoryList.isNotEmpty) {
        for (var tempPostId in tempPostIdList) {
          for (var tempPost in tempUniqueCategoryPostList) {
            if (tempPost.getId()!.compareTo(tempPostId) == 0) {
              postList.add(tempPost);
            }
          }
        }
      } else {
        postList.addAll(tempUniquePostList);
      }
    } else {
      postList.addAll(tempUniqueCategoryPostList);
    }

    return postList;
  }

  Future<List<PostCardView>> searchPostCardViewList(String text,List<Category> categoryList,int limit)async {
    List<PostCardView> postCardViewList = [];

    List<Post> postList = await searchPostList(text, categoryList, limit);
    postCardViewList.addAll(await convertToPostCardViewModel(postList));

    return postCardViewList;
  }

  Future<List<PostCardView>> getMostPopularPostCardViewList(int limit) async {
    List<PostCardView> postCardViewList = [];

    List<Post> postList = await getMostPopularPostList(limit);
    postCardViewList.addAll(await convertToPostCardViewModel(postList));

    return postCardViewList;
  }

  Future<List<PostCardView>> convertToPostCardViewModel(List<Post> postList) async{
    List<PostCardView> postCardViewList = [];

    for (var post in postList) {
      PostCardView cardView = PostCardView();
      UserDetail? userDetail =
          await _userDetailRepository.getUserByUserId(post.getUserId()!);

      if (userDetail != null) {

        cardView.userFullName =
        "${userDetail.getName()!} ${userDetail.getSurname()!}";
        cardView.userPhoto = userDetail.getPhoto();
      }

      cardView.isThereCategory = post.isThereCategory();
      cardView.topic = post.getTopic();
      cardView.content = post.getContent();
      cardView.photo = post.getPhoto();

      postCardViewList.add(cardView);
    }
    return postCardViewList;
  }
}
