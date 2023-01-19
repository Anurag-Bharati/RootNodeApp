import 'package:rootnode/data_source/remote_data_store/response/res_story.dart';
import 'package:rootnode/data_source/remote_data_store/story_remote_data_source.dart';

abstract class StoryRepo {
  Future<StoryResponse?> getStoryFeed(
      {int page = 1, int refresh = 0, bool private = false});
}

class StoryRepoImpl extends StoryRepo {
  @override
  Future<StoryResponse?> getStoryFeed(
      {int page = 1, int refresh = 0, bool private = false}) {
    return StoryRemoteDataSource()
        .getStoryFeed(page: page, refresh: refresh, private: private);
  }
}
