import 'package:guide_up/core/enumeration/enums/EnLikeSaveType.dart';
import 'package:guide_up/core/models/post/post_like_save_model.dart';
import 'package:guide_up/repository/post/post_like_save_repository.dart';

class PostLikeSaveService {
  late PostLikeSaveRepository _postLikeSaveRepository;

  PostLikeSaveService() {
    _postLikeSaveRepository = PostLikeSaveRepository();
  }

  Future<void> deleteById(String id) async{
    _postLikeSaveRepository.get(id).then((likeSave) async {
      if (likeSave != null) {
        likeSave.setActive(false);
        await _postLikeSaveRepository.update(likeSave);
      }
    });
  }

  Future<PostLikeSave> add(String userId, String postId, EnLikeSaveType enLikeSaveType) async{
    PostLikeSave postLikeSave = PostLikeSave();
    postLikeSave.setUserId(userId);
    postLikeSave.setPostId(postId);
    postLikeSave.setEnLikeSaveType(enLikeSaveType);
    return _postLikeSaveRepository.add(postLikeSave);
  }
}
