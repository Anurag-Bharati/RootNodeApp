import 'package:image_picker/image_picker.dart';
import 'package:rootnode/data_source/remote_data_store/post_remote_data_source.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_post.dart';
import 'package:rootnode/model/post.dart';

abstract class PostRepo {
  Future<PostResponse?> getPostFeed(
      {int page = 1, int refresh = 0, bool private = false});
  Future<Post?> getPostById({required String id});
  Future<PostResponse?> getPostByUser(
      {int page = 1, int refresh = 0, required String id});
  Future<bool> togglePostLike({required String id});
  Future<bool> createPost({required Post post, required List<XFile>? files});
  Future<bool> deletePost({required String id});
}

class PostRepoImpl extends PostRepo {
  @override
  Future<PostResponse?> getPostFeed(
      {int page = 1, int refresh = 0, bool private = false}) {
    return PostRemoteDataSource()
        .getPostFeed(page: page, refresh: refresh, private: private);
  }

  @override
  Future<PostResponse?> getPostByUser(
      {int page = 1, int refresh = 0, required String id}) {
    return PostRemoteDataSource()
        .getPostByUser(page: page, refresh: refresh, id: id);
  }

  @override
  Future<bool> togglePostLike({required String id}) {
    return PostRemoteDataSource().togglePostLike(id: id);
  }

  @override
  Future<bool> createPost({required Post post, required List<XFile>? files}) {
    return PostRemoteDataSource().createPost(post, files);
  }

  @override
  Future<Post?> getPostById({required String id}) {
    return PostRemoteDataSource().getPostById(id: id);
  }

  @override
  Future<bool> deletePost({required String id}) {
    return PostRemoteDataSource().deletePost(id: id);
  }
}
