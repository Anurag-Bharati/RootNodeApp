import 'package:file_picker/file_picker.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_story.dart';
import 'package:rootnode/data_source/remote_data_store/story_remote_data_source.dart';
import 'package:rootnode/model/story.dart';

abstract class StoryRepo {
  Future<StoryResponse?> getStoryFeed(
      {int page = 1, int refresh = 0, bool private = false});
  Future<Story?> getStoryById({required String id});
  Future<bool> createStory({required Story story, PlatformFile? file});
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
  Future<bool> createStory({required Story story, PlatformFile? file}) {
    return StoryRemoteDataSource().createStory(story: story, file: file);
  }
}
