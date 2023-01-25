import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/helper/utils.dart';
import 'package:rootnode/model/story.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/repository/story_repo.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:video_player/video_player.dart';

class ViewStoryScreen extends StatefulWidget {
  const ViewStoryScreen({
    super.key,
    required this.stories,
    required this.initial,
  });
  final List<Story> stories;
  final int initial;

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animationController;
  VideoPlayerController? _videoController;
  final _stroyRepo = StoryRepoImpl();
  late int currentIndex;
  bool paused = false;
  bool loved = false;
  Duration imageStoryDuration = const Duration(seconds: 5);
  final List<String> watchedStory = [];

  @override
  void initState() {
    currentIndex = widget.initial;
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);
    _loadStory(story: widget.stories[currentIndex], animateToPage: false);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if (currentIndex + 1 < widget.stories.length) {
            currentIndex++;
            _loadStory(story: widget.stories[currentIndex]);
          } else {
            currentIndex = 0;
            _loadStory(story: widget.stories[currentIndex]);
          }
        });
      }
    });
    super.initState();
  }

  _storyWatched({required String id}) {
    if (watchedStory.contains(id)) return;
    watchedStory.add(id);
    _stroyRepo.storyWatched(id: id);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    if (_videoController != null) {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
      }
      _videoController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Story story = widget.stories[currentIndex];
    return Scaffold(
        body: GestureDetector(
      onTapDown: (details) => _onTapDown(details, story),
      onDoubleTap: () => _likeStory(story),
      child: Stack(
        children: [
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: widget.stories.length,
            itemBuilder: (context, index) {
              final Story story = widget.stories[currentIndex];
              switch (story.type) {
                case "text":
                  return Hero(
                    tag: "story-$currentIndex",
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: Color(story.color!),
                      child: StoryHeading(story: story),
                    ),
                  );
                case "media":
                case "mixed":
                  switch (story.media!.type) {
                    case "image":
                      return Hero(
                        tag: "story-$currentIndex",
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                                "${ApiConstants.baseUrl}/${story.media!.url}",
                                fit: BoxFit.cover),
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF111111),
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.transparent
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter),
                              ),
                            ),
                            Positioned(
                                left: 10.0,
                                right: 10.0,
                                bottom: 40,
                                child: !paused
                                    ? Column(
                                        children: [
                                          const Icon(
                                            Boxicons.bx_heading,
                                            color: Colors.white54,
                                            size: 20,
                                          ),
                                          Text(
                                            "Heading Available!\ntap to reveal",
                                            textAlign: TextAlign.center,
                                            style: RootNodeFontStyle.label
                                                .copyWith(
                                                    fontSize: 12, height: 0),
                                          )
                                        ],
                                      )
                                    : const SizedBox.shrink()),
                            AnimatedContainer(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: paused
                                    ? Colors.black.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                              child: paused && story.quote != null
                                  ? StoryHeading(story: story)
                                  : null,
                            ),
                          ],
                        ),
                      );
                    case "video":
                      if (_videoController != null &&
                          _videoController!.value.isInitialized) {
                        return Hero(
                          tag: "story-$currentIndex",
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                                width: _videoController!.value.size.width,
                                height: _videoController!.value.size.height,
                                child: VideoPlayer(_videoController!)),
                          ),
                        );
                      }
                  }
              }
              return const SizedBox.shrink();
            },
          ),
          Positioned(
              top: 20.0,
              left: 10.0,
              right: 10.0,
              bottom: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 1.5, vertical: 10.0),
                    child: UserInfo(
                      user: story.owner!,
                      createdAt: story.createdAt!,
                      heartCount: story.likesCount!,
                      seenCount: story.seenBy!.length,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Row(
                      children: widget.stories
                          .asMap()
                          .map((i, e) {
                            return MapEntry(
                              i,
                              AnimatedBar(
                                  animationController: _animationController,
                                  position: i,
                                  currentIndex: currentIndex),
                            );
                          })
                          .values
                          .toList(),
                    ),
                  ),
                ],
              ))
        ],
      ),
    ));
  }

  void _onTapDown(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      paused = false;
      setState(() {
        if (currentIndex - 1 >= 0) {
          currentIndex--;
          _loadStory(story: widget.stories[currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      paused = false;
      setState(() {
        if (currentIndex + 1 < widget.stories.length) {
          currentIndex++;
        } else {
          currentIndex = 0;
        }
        _loadStory(story: widget.stories[currentIndex]);
      });
    } else {
      if (story.media == null) return;
      if (story.media!.type == 'image') {
        setState(() {
          paused = !paused;
          if (paused) {
            _animationController.stop();
          } else {
            _animationController.forward();
          }
        });
      }
      if (story.media!.type == 'video') {
        if (_videoController == null) return;
        if (_videoController!.value.isPlaying) {
          _videoController!.pause();
          _animationController.stop();
        } else {
          _videoController!.play();
          _animationController.forward();
        }
      }
    }
  }

  void _loadStory({required Story story, bool animateToPage = true}) {
    _storyWatched(id: story.id!);
    _animationController.stop();
    _animationController.reset();
    switch (story.type) {
      case "text":
        _animationController.duration = imageStoryDuration;
        _animationController.forward();
        break;
      case "media":
      case "mixed":
        switch (story.media!.type) {
          case 'image':
            _animationController.duration = imageStoryDuration;
            _animationController.forward();
            break;
          case 'video':
            if (_videoController != null) {
              _videoController!.dispose();
            }
            _videoController = VideoPlayerController.network(
                "${ApiConstants.baseUrl}/${story.media!.url!}")
              ..initialize().then((value) {
                setState(() {});
                if (_videoController!.value.isInitialized) {
                  _animationController.duration =
                      _videoController!.value.duration;
                  _videoController!.play();
                  _animationController.forward();
                }
              });
            break;
        }
        break;
    }
    if (animateToPage) {
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  _likeStory(Story story) {
    setState(() {
      loved = !loved;
    });
  }
}

class StoryHeading extends StatelessWidget {
  const StoryHeading({
    super.key,
    required this.story,
  });

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: story.quote!.length * 10 >
                    MediaQuery.of(context).size.width * 0.8
                ? MediaQuery.of(context).size.width * 0.8
                : story.quote!.length * 10,
            bottom: 5,
          ),
          child: const Icon(
            Boxicons.bxs_quote_left,
            color: Colors.white54,
            size: 18,
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white54, width: 2),
            borderRadius: BorderRadius.circular(10),
            // color: Colors.white10,
          ),
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Text(
              story.quote!,
              style: RootNodeFontStyle.body.copyWith(height: 1.5),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.center,
              maxLines: 500,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: story.quote!.length * 10 >
                    MediaQuery.of(context).size.width * 0.8
                ? MediaQuery.of(context).size.width * 0.8
                : story.quote!.length * 10,
            top: 5,
          ),
          child: const Icon(
            Boxicons.bxs_quote_right,
            color: Colors.white54,
            size: 18,
          ),
        )
      ],
    );
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animationController;
  final int position;
  final int currentIndex;

  const AnimatedBar(
      {Key? key,
      required this.animationController,
      required this.position,
      required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              _buildContainer(
                double.infinity,
                position < currentIndex
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
              ),
              position == currentIndex
                  ? AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return _buildContainer(
                            constraints.maxWidth * animationController.value,
                            Colors.white);
                      },
                    )
                  : const SizedBox.shrink()
            ],
          );
        }),
      ),
    );
  }

  Widget _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black26, width: 0.8),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final User user;
  final DateTime createdAt;
  final int heartCount;
  final int seenCount;
  const UserInfo(
      {super.key,
      required this.user,
      required this.createdAt,
      required this.heartCount,
      required this.seenCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          foregroundImage: NetworkImage(user.avatar != null
              ? "${ApiConstants.baseUrl}/${user.avatar}"
              : "https://icon-library.com/images/anonymous-user-icon/anonymous-user-icon-2.jpg"),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Wrap(
            direction: Axis.vertical,
            spacing: -5,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text(
                "${user.fname!} ${user.lname}".toTitleCase!,
                style: RootNodeFontStyle.body,
              ),
              Wrap(
                spacing: 5,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(Boxicons.bx_time, color: Colors.white70, size: 16),
                  Text(
                    Utils.getTimeAgo(createdAt),
                    style: RootNodeFontStyle.subtitle,
                  ),
                  Text("•", style: RootNodeFontStyle.subtitle),
                  const Icon(Boxicons.bx_heart,
                      color: Colors.white70, size: 16),
                  Text(
                    heartCount.toString(),
                    style: RootNodeFontStyle.subtitle,
                  ),
                  Text("•", style: RootNodeFontStyle.subtitle),
                  const Icon(Icons.visibility_outlined,
                      color: Colors.white70, size: 18),
                  Text(
                    seenCount.toString(),
                    style: RootNodeFontStyle.subtitle,
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Boxicons.bx_x,
              size: 30.0,
              color: Colors.white70,
            ))
      ],
    );
  }
}