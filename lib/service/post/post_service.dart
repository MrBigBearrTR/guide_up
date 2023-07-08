import 'package:guide_up/core/dto/post/post_card_view.dart';
import 'package:guide_up/core/enumeration/enums/EnLikeSaveType.dart';
import 'package:guide_up/core/models/post/post_like_save_model.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/repository/post/post_like_save_repository.dart';
import 'package:guide_up/repository/post/post_repository.dart';
import 'package:guide_up/repository/user/user_detail/user_detail_repository.dart';


import '../../core/models/post/post_model.dart';
import '../../core/utils/repository_helper.dart';

class PostService {
  late PostLikeSaveRepository _postLikeSaveRepository;
  late PostRepository _postRepository;
  late UserDetailRepository _userDetailRepository;

  PostService() {
    _postLikeSaveRepository = PostLikeSaveRepository();
    _postRepository = PostRepository();
    _userDetailRepository = UserDetailRepository();
  }

  Future<List<PostCardView>> getMostPopularPostCardViewList(int limit) async {
    List<PostCardView> postCardViewList = [];

    List<Post> postList = await getMostPopularPostList(limit);

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

}

