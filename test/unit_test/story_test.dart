import 'package:flutter_test/flutter_test.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_story.dart';
import 'package:rootnode/data_source/remote_data_store/story_remote_data_source.dart';
import 'package:rootnode/data_source/remote_data_store/user_remote_data_source.dart';
import 'package:rootnode/model/story.dart';

void main() {
  // For the access
  setUpAll(() async => await UserRemoteDataSource()
      .login(identifier: 'anuragbharati', password: "anurag", isEmail: false));

  test("Fetch public story test", () async {
    //Act
    StoryResponse? actual = await StoryRemoteDataSource().getStoryFeed();
    // Assert
    expect(actual, isNotNull);
  });

  test("Get story by id test", () async {
    //Arrange
    String sid = "63d3c830965075255239db45";
    //Act
    Story? actual = await StoryRemoteDataSource().getStoryById(id: sid);
    // Assert
    expect(actual, isNotNull);
  });

  test("Fetch story by user test", () async {
    //Arrange
    String myId = "63d2a32d69b2e6e141abd01e";
    //Act
    StoryResponse? actual =
        await StoryRemoteDataSource().getStoryByUser(id: myId);
    // Assert
    expect(actual, isNotNull);
  });
}
