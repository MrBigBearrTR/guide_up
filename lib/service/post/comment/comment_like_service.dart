import 'package:guide_up/core/models/post/commend/commend_like_model.dart';
import 'package:guide_up/repository/post/comment/comment_like_repository.dart';

class CommentLikeService {
  late CommentLikeRepository _commentLikeRepository;

  CommentLikeService() {
    _commentLikeRepository = CommentLikeRepository();
  }

  Future<void> deleteById(String id) async {
    _commentLikeRepository.get(id).then((likeSave) async {
      if (likeSave != null) {
        likeSave.setActive(false);
        await _commentLikeRepository.update(likeSave);
      }
    });
  }

  Future<CommentLike> add(String userId, String commentId) async {
    CommentLike commentLike = CommentLike();
    commentLike.setUserId(userId);
    commentLike.setCommentId(commentId);
    return _commentLikeRepository.add(commentLike);
  }
}
