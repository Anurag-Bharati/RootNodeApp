import 'package:image_picker/image_picker.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_story.dart';
import 'package:rootnode/data_source/remote_data_store/story_remote_data_source.dart';
import 'package:rootnode/model/story.dart';

abstract class StoryRepo {
  Future<StoryResponse?> getStoryFeed(
      {int page = 1, int refresh = 0, bool private = false});
  Future<StoryResponse?> getStoryByUser(
      {int page = 1, int refresh = 0, required String id});
  Future<Story?> getStoryById({required String id});
  Future<bool> storyWatched({required String id});
  Future<bool> createStory({required Story story, XFile? file});
}

class StoryRepoImpl extends StoryRepo {
  @override
  Future<StoryResponse?> getStoryFeed(
      {int page = 1, int refresh = 0, bool private = false}) {
    return StoryRemoteDataSource()
        .getStoryFeed(page: page, refresh: refresh, private: private);
  }

  @override
  Future<Story?> getStoryById({required String id}) {
    return StoryRemoteDataSource().getStoryById(id: id);
  }

  @override
  Future<StoryResponse?> getStoryByUser(
      {int page = 1, int refresh = 0, required String id}) {
    return StoryRemoteDataSource()
        .getStoryByUser(page: page, refresh: refresh, id: id);
  }

  @override
  Future<bool> createStory({required Story story, XFile? file}) {
    return StoryRemoteDataSource().createStory(story: story, file: file);
  }

  @override
  Future<bool> storyWatched({required String id}) {
    return StoryRemoteDataSource().storyWatched(id: id);
  }
}
