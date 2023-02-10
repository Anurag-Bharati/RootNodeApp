import 'package:rootnode/data_source/remote_data_store/cmnt_remote_data_source.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_cmnt.dart';
import 'package:rootnode/model/comment/comment.dart';

abstract class CommentRepo {
  Future<CommentResponse?> getPostComments({
    required String id,
    int page = 1,
  });
  Future<Object?> getCommentLikers({
    required String id,
    int page = 1,
  });
  Future<bool> toggleCommentLike({required String id});
  Future<Object?> updateCommentByID({required String id});
  Future<bool> deleteCommentById({required String id});
  Future<Object?> getCommentByID({required String id});
  Future<Comment?> createComment({required String id, required String comment});
}

class CommentRepoImpl extends CommentRepo {
  @override
  Future<bool> deleteCommentById({required String id}) {
    return CmntRemoteDataSource().deleteCommentById(id: id);
  }

  @override
  Future<Object?> getCommentByID({required String id}) {
    // TODO: implement getCommentByID
    throw UnimplementedError();
  }

  @override
  Future<Object?> getCommentLikers({required String id, int page = 1}) {
    // TODO: implement getCommentLikers
    throw UnimplementedError();
  }

  @override
  Future<CommentResponse?> getPostComments({required String id, int page = 1}) {
    return CmntRemoteDataSource().getPostComments(id: id, page: page);
  }

  @override
  Future<bool> toggleCommentLike({required String id}) {
    return CmntRemoteDataSource().toggleCommentLike(id: id);
  }

  @override
  Future<Object?> updateCommentByID({required String id}) {
    // TODO: implement updateCommentByID
    throw UnimplementedError();
  }

  @override
  Future<Comment?> createComment(
      {required String id, required String comment}) {
    return CmntRemoteDataSource().createComment(id: id, comment: comment);
  }
}
