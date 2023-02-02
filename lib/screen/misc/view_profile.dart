import 'package:avatar_glow/avatar_glow.dart';
import 'package:boxicons/boxicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_story.dart';
import 'package:rootnode/helper/responsive_helper.dart';
import 'package:rootnode/helper/utils.dart';
import 'package:rootnode/model/story.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/repository/conn_repo.dart';
import 'package:rootnode/repository/story_repo.dart';
import 'package:rootnode/repository/user_repo.dart';
import 'package:rootnode/widgets/buttons.dart';
import 'package:rootnode/widgets/placeholder.dart';
import 'package:rootnode/widgets/stories.dart';
import 'package:string_extensions/string_extensions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.id, required this.user});
  final String id;
  final User user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _userRepo = UserRepoImpl();
  final _storyRepo = StoryRepoImpl();
  final _connRepo = ConnRepoImpl();
  User? user;
  double maxContentWidth = 720;

  late final ScrollController _scrollController;
  late StoryResponse? _storyResponse;
  late int storyTotal;

  final List<Story> _stories = [];
  int storyPage = 1;

  bool noPost = false;
  bool noStory = false;

  bool? hasConn;

  _fetchFollowData() async {
    hasConn = await _connRepo.hasConnection(id: widget.id);
    if (mounted) setState(() {});
  }

  _fetchUser() async {
    user = await _userRepo.getUserById(widget.id);
    if (mounted) setState(() {});
  }

  void _getInitialStoryData() async {
    _storyResponse = await _storyRepo.getStoryByUser(
        page: storyPage, refresh: 1, id: widget.id);
    if (_storyResponse!.stories!.isEmpty) noStory = true;
    setState(() {
      _stories.addAll(_storyResponse!.stories!);
      storyTotal = _storyResponse!.totalPages!;
    });
  }

  void _fetchMoreStoryData() async {
    if (storyPage == storyTotal) return;
    storyPage = storyPage == storyTotal ? storyTotal : storyPage + 1;
    _storyResponse = await _storyRepo.getStoryByUser(
        page: storyPage, refresh: 0, id: widget.id);
    setState(() {
      _stories.addAll(_storyResponse!.stories!);
    });
  }

  @override
  void initState() {
    _fetchFollowData();
    _fetchUser();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetchMoreStoryData();
      }
    });
    _getInitialStoryData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Back",
          style: RootNodeFontStyle.header,
        ),
        backgroundColor: Colors.pink,
        leadingWidth: 40,
        leading: IconButton(
          icon: const Icon(
            Boxicons.bx_chevron_left,
            color: Colors.white70,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF111111),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  gradient: LinearGradient(
                    colors: [
                      Colors.pink,
                      Colors.pink,
                      Colors.pink.withAlpha(100),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      Stack(
                        children: [
                          user != null
                              ? CircleAvatar(
                                  maxRadius: 48,
                                  backgroundColor: Colors.white10,
                                  foregroundImage: CachedNetworkImageProvider(
                                    "${ApiConstants.baseUrl}/${user!.avatar!}",
                                    maxHeight: 256,
                                    maxWidth: 256,
                                    cacheKey: user!.avatar,
                                  ),
                                )
                              : const AvatarGlow(
                                  endRadius: 48,
                                  glowColor: Colors.white10,
                                  child: SizedBox.shrink(),
                                ),
                          user != null
                              ? Positioned(
                                  right: 0,
                                  bottom: 5,
                                  child: user!.isVerified!
                                      ? const Icon(Boxicons.bxs_check_circle,
                                          size: 20, color: Colors.green)
                                      : const Icon(Boxicons.bxs_error_circle,
                                          size: 20, color: Colors.amber),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                      user != null
                          ? Wrap(
                              direction: Axis.vertical,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: -2,
                              children: [
                                Text(
                                  "${user!.fname} ${user!.lname!}".toTitleCase!,
                                  style: RootNodeFontStyle.header,
                                ),
                                Text(
                                  "@${user!.username}",
                                  style: RootNodeFontStyle.caption,
                                ),
                              ],
                            )
                          : _getNamePlaceholder(),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.spaceEvenly,
                        spacing: 40,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 5,
                            spacing: -10,
                            direction: Axis.vertical,
                            children: [
                              user != null
                                  ? Text(
                                      Utils.humanizeNumber(user!.postsCount!),
                                      style: RootNodeFontStyle.title)
                                  : _getCountPlaceHolder(),
                              Text("POSTS", style: RootNodeFontStyle.label),
                            ],
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 5,
                            spacing: -10,
                            direction: Axis.vertical,
                            children: [
                              user != null
                                  ? Text(
                                      Utils.humanizeNumber(user!.storiesCount!),
                                      style: RootNodeFontStyle.title)
                                  : _getCountPlaceHolder(),
                              Text("STORYS", style: RootNodeFontStyle.label),
                            ],
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 5,
                            spacing: -10,
                            direction: Axis.vertical,
                            children: [
                              user != null
                                  ? Text(
                                      Utils.humanizeNumber(user!.nodesCount!),
                                      style: RootNodeFontStyle.title)
                                  : _getCountPlaceHolder(),
                              Text("NODES", style: RootNodeFontStyle.label),
                            ],
                          )
                        ],
                      ),
                      user != null
                          ? Wrap(
                              spacing: 10,
                              runAlignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.spaceEvenly,
                              runSpacing: 10,
                              children: [
                                RootNodeOutlinedButton(
                                  onPressed: () =>
                                      debugPrint("Share Button Pressed!"),
                                  child: Text("Share",
                                      style: RootNodeFontStyle.body),
                                ),
                                RootNodeOutlinedButton(
                                  onPressed: () =>
                                      debugPrint('Message Button Pressed!'),
                                  child: const Icon(
                                      Boxicons.bxs_message_square_dots,
                                      color: Colors.white54),
                                ),
                                RootNodeOutlinedButton(
                                  onPressed: () async {
                                    if (widget.user.id == user!.id!) {
                                      debugPrint("Edit Button Pressed!");
                                    } else {
                                      bool? res = await _connRepo
                                          .toggleConnection(id: widget.id);
                                      if (res != null) {
                                        setState(() {
                                          hasConn = res;
                                        });
                                      }
                                      debugPrint("Follow Button Pressed!");
                                    }
                                  },
                                  child: hasConn != null
                                      ? Text(
                                          widget.user.id != user!.id
                                              ? hasConn!
                                                  ? "Unfollow"
                                                  : "Follow"
                                              : "Edit",
                                          style: RootNodeFontStyle.body)
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            )
                          : _getNamePlaceholder()
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ConstrainedSliverWidth(
                maxWidth: maxContentWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 124.0,
                    child: noStory
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const MediaEmpty(
                                icon: Icons.error, message: "No story posted"),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10.0),
                            itemCount: _stories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: StoryCard(
                                    hideName: true,
                                    stories: _stories,
                                    index: index + 1,
                                    color: Color(_stories[index].color!),
                                    story: _stories[index]),
                              );
                            },
                          ),
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) => null))
          ],
        ),
      ),
    );
  }

  Container _getCountPlaceHolder() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 20,
      width: 48,
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(10)),
    );
  }

  Container _getNamePlaceholder() {
    return Container(
      height: 48,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(10)),
    );
  }
}
