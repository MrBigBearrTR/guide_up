import 'package:guide_up/core/models/post/commend/commend_like_model.dart';
import 'package:guide_up/core/models/post/commend/commend_model.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/repository/post/comment/comment_like_repository.dart';
import 'package:guide_up/repository/post/comment/comment_repository.dart';

import '../../../core/dto/post/comment/post_commet_card_view.dart';
import '../../../repository/user/user_detail/user_detail_repository.dart';

class CommentService {
  late CommentRepository _commentRepository;
  late UserDetailRepository _userDetailRepository;
  late CommentLikeRepository _commentLikeRepository;

  CommentService() {
    _commentRepository = CommentRepository();
    _userDetailRepository = UserDetailRepository();
    _commentLikeRepository = CommentLikeRepository();
  }

  Future<List<PostCommentCardView>> getList(
      String postId, int limit, String? userId) async {
    List<Comment> commentList = await _commentRepository.getList(postId, limit);

    return await convertToCardView(commentList, userId);
  }

  Future<List<PostCommentCardView>> convertToCardView(
      List<Comment> commentList, String? userId) async {
    List<PostCommentCardView> commentCardList = [];
    List<UserDetail> userDetailList = [];
    for (var comment in commentList) {
      PostCommentCardView card = PostCommentCardView();

      card.id = comment.getId()!;
      card.postId = comment.getId();
      card.photo = comment.getPhoto();
      card.content = comment.getContent();

      UserDetail? userDetail;
      for (var user in userDetailList) {
        if (user.getUserId() == comment.getUserId()) {
          userDetail = user;
          break;
        }
      }
      userDetail ??=
          await _userDetailRepository.getUserByUserId(comment.getUserId()!);

      if (userDetail != null) {
        card.userFullName =
            "${userDetail.getName()!} ${userDetail.getSurname()!}";
        card.userPhoto = userDetail.getPhoto();
      }

      card.likeCount =
          await _commentLikeRepository.getCommentCount(comment.getId()!);
      if (userId != null) {
        CommentLike? commentLike = await _commentLikeRepository
            .getByUserIdAndCommentId(userId, comment.getId()!);
        if (commentLike != null) {
          card.isLikeUser = true;
          card.likeId = commentLike.getId()!;
        }
      }

      commentCardList.add(card);
    }
    return commentCardList;
  }
}
