import 'package:flutter_test/flutter_test.dart';
import 'package:rootnode/data_source/remote_data_store/post_remote_data_source.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_post.dart';
import 'package:rootnode/data_source/remote_data_store/user_remote_data_source.dart';
import 'package:rootnode/model/post.dart';

void main() {
  // For the access
  setUpAll(() async => await UserRemoteDataSource()
      .login(identifier: 'anuragbharati', password: "anurag", isEmail: false));

  test("Fetch public post test", () async {
    //Act
    PostResponse? actual =
        await PostRemoteDataSource().getPostFeed(private: false);
    // Assert
    expect(actual, isNotNull);
  });

  test("Fetch private post test", () async {
    //Act
    PostResponse? actual =
        await PostRemoteDataSource().getPostFeed(private: true);
    // Assert
    expect(actual, isNotNull);
  });

  test("Fetch specific post page test", () async {
    //Act
    PostResponse? actual = await PostRemoteDataSource().getPostFeed(page: 2);
    // Assert
    expect(actual?.currentPage, 2);
  });

  test("Fetch post by user test", () async {
    //Arrange
    String myId = "63d2a32d69b2e6e141abd01e";
    //Act
    PostResponse? actual = await PostRemoteDataSource().getPostByUser(id: myId);
    // Assert
    expect(actual, isNotNull);
  });

  test("Toggle like on a post test", () async {
    //Arrange
    String myId = "63d2a32d69b2e6e141abd01e";
    bool? actual;
    //Act
    PostResponse? posts = await PostRemoteDataSource().getPostByUser(id: myId);

    bool? matcher = posts?.data?.meta?.isLiked?.first;
    Post? post = posts?.data?.posts?.first;
    expect(post, isNotNull);
    if (post != null) {
      actual = await PostRemoteDataSource().togglePostLike(id: post.id!);
    }
    // since the endpoint toggles like this need to be flipped
    if (matcher != null) matcher = !matcher;
    expect(actual, matcher);
  });

  tearDownAll(() => null);
}
