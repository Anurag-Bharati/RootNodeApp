import 'package:rootnode/data_source/remote_data_store/post_remote_data_source.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_post.dart';

abstract class PostRepo {
  Future<PostResponse?> getPostFeed(
      {int page = 1, int refresh = 0, bool private = false});
  Future<bool> togglePostLike({required String id});
}

class PostRepoImpl extends PostRepo {
  @override
  Future<PostResponse?> getPostFeed(
      {int page = 1, int refresh = 0, bool private = false}) {
    return PostRemoteDataSource()
        .getPostFeed(page: page, refresh: refresh, private: private);
  }

  @override
  Future<bool> togglePostLike({required String id}) {
    return PostRemoteDataSource().togglePostLike(id: id);
  }
}
