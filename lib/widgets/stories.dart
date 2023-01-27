import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_story.dart';
import 'package:rootnode/helper/switchRoute.dart';
import 'package:rootnode/model/story.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/repository/story_repo.dart';
import 'package:rootnode/screen/misc/create_story.dart';
import 'package:rootnode/screen/misc/view_story.dart';
import 'package:rootnode/widgets/selection_tile.dart';
import 'package:string_extensions/string_extensions.dart';

class StoriesWidget extends StatefulWidget {
  final User currentUser;

  const StoriesWidget({super.key, required this.currentUser});

  @override
  State<StoriesWidget> createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {
  late final ScrollController _scrollController;
  // late final RandomColor _randomColor;
  final _storyRepo = StoryRepoImpl();
  late StoryResponse? _storyResponse;
  final List<Story> _stories = [];
  late int storyTotal;
  int storyPage = 1;

  void _getInitialStoryData() async {
    _storyResponse = await _storyRepo.getStoryFeed(
        page: storyPage, refresh: 1, private: false);

    setState(() {
      _stories.addAll(_storyResponse!.stories!);
      storyTotal = _storyResponse!.totalPages!;
    });
  }

  void _fetchMoreStoryData() async {
    if (storyPage == storyTotal) return;
    storyPage = storyPage == storyTotal ? storyTotal : storyPage + 1;
    _storyResponse = await _storyRepo.getStoryFeed(
        page: storyPage, refresh: 0, private: false);
    setState(() {
      _stories.addAll(_storyResponse!.stories!);
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        print("Story Ref");
        _fetchMoreStoryData();
      }
    });
    _getInitialStoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 124.0,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
        itemCount: 1 + _stories.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _StoryCard(
                stories: _stories,
                index: index,
                color: Colors.cyan,
                isAddStory: true,
                currentUser: widget.currentUser,
                story: null,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _StoryCard(
                stories: _stories,
                index: index,
                color: Color(_stories[index - 1].color!),
                currentUser: widget.currentUser,
                story: _stories[index - 1]),
          );
        },
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final User currentUser;
  final Story? story;
  final List<Story> stories;
  final Color color;
  final int index;
  const _StoryCard({
    Key? key,
    this.isAddStory = false,
    required this.currentUser,
    required this.story,
    required this.color,
    required this.index,
    required this.stories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: "story-${index - 1}",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: isAddStory
                ? Container(
                    height: double.infinity,
                    width: 110.0,
                    color: Colors.cyan,
                  )
                : story!.media == null
                    ? Container(
                        height: double.infinity,
                        width: 110.0,
                        color: color,
                      )
                    : story!.media!.type == "image"
                        ? Image.network(
                            "${ApiConstants.baseUrl}/${story!.media!.url!}",
                            height: double.infinity,
                            width: 110.0,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: double.infinity,
                            width: 110.0,
                            color: color,
                            child: const Icon(
                              Boxicons.bx_video,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
          ),
        ),
        GestureDetector(
          onTap: () => isAddStory
              ? showDialog(
                  barrierColor: const Color(0xEE111111),
                  context: context,
                  builder: (context) => SelectionTile(
                    title: "Add Story",
                    tileButton: [
                      TileButton(
                        type: TileType.text,
                        icon: Boxicons.bx_text,
                        label: "Text",
                        onPressed: (TileType type) =>
                            _switchScreen(context, type),
                      ),
                      TileButton(
                        type: TileType.video,
                        icon: Boxicons.bx_video,
                        label: "Video",
                        onPressed: (TileType type) =>
                            _switchScreen(context, type),
                      ),
                      TileButton(
                        type: TileType.image,
                        icon: Boxicons.bx_image_add,
                        label: "Image",
                        onPressed: (TileType type) =>
                            _switchScreen(context, type),
                      ),
                    ],
                    widthFraction: 0.9,
                    column: 3,
                  ),
                )
              : switchRouteByPush(
                  context,
                  ViewStoryScreen(
                    stories: stories,
                    initial: index - 1,
                  )),
          child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: 110.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                  color: const Color(0xFF111111),
                  width: 1.0,
                  strokeAlign: BorderSide.strokeAlignOutside),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF111111),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: isAddStory
                ? const SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: Icon(Icons.add, size: 40),
                  )
                : SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        story!.type == "text" ? story!.quote! : "",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: RootNodeFontStyle.label,
                      ),
                    ),
                  ),
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            isAddStory
                ? 'Add story'
                : "${story!.owner!.fname!.toTitleCase!} ${story!.owner!.lname![0].capitalize!}.",
            style: RootNodeFontStyle.subtitle,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  _switchScreen(BuildContext context, TileType type) {
    print(type);
    Navigator.of(context, rootNavigator: true).pop('dialog');
    switchRouteByPush(context, const CreateStoryScreen());
  }
}
