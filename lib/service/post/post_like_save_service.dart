import 'package:guide_up/core/enumeration/enums/EnLikeSaveType.dart';
import 'package:guide_up/core/models/post/post_like_save_model.dart';
import 'package:guide_up/repository/post/post_like_save_repository.dart';

class PostLikeSaveService {
  late PostLikeSaveRepository _postLikeSaveRepository;

  PostLikeSaveService() {
    _postLikeSaveRepository = PostLikeSaveRepository();
  }

  deleteById(String id) {
    _postLikeSaveRepository.get(id).then((likeSave) {
      if (likeSave != null) {
        likeSave.setActive(false);
        _postLikeSaveRepository.update(likeSave);
      }
    });
  }

  add(String userId, String postId, EnLikeSaveType enLikeSaveType) {
    PostLikeSave postLikeSave = PostLikeSave();
    postLikeSave.setUserId(userId);
    postLikeSave.setPostId(postId);
    postLikeSave.setEnLikeSaveType(enLikeSaveType);
    _postLikeSaveRepository.add(postLikeSave);
  }
}
