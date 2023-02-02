import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_story.dart';
import 'package:rootnode/model/story.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/repository/conn_repo.dart';
import 'package:rootnode/repository/story_repo.dart';
import 'package:rootnode/repository/user_repo.dart';
import 'package:rootnode/widgets/buttons.dart';
import 'package:rootnode/widgets/placeholder.dart';
import 'package:rootnode/widgets/profile_card.dart';
import 'package:rootnode/widgets/stories.dart';

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
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF111111),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretchTriggerOffset: 10,
            stretch: true,
            pinned: true,
            leadingWidth: 40,
            expandedHeight: 350 + 124,
            collapsedHeight: 180,
            backgroundColor: const Color(0xFF111111),
            title: Text("Back", style: RootNodeFontStyle.header),
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              titlePadding: EdgeInsets.zero,
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color(0xFF111111),
                    Color(0xFF111111),
                    Color(0x55111111),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
                width: double.infinity,
                height: 124 + 10,
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
                                disableBorder: true,
                                hideName: true,
                                stories: _stories,
                                index: index + 1,
                                color: Color(_stories[index].color!),
                                story: _stories[index]),
                          );
                        },
                      ),
              ),
              collapseMode: CollapseMode.parallax,
              stretchModes: const [StretchMode.zoomBackground],
              background: ProfileCard(
                actions: _actionButtons(),
                hasConn: hasConn,
                id: widget.id,
                user: user,
              ),
              centerTitle: true,
            ),
            leading: IconButton(
              icon: const Icon(Boxicons.bx_chevron_left,
                  color: Colors.white70, size: 40),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                      margin: EdgeInsets.only(
                        bottom: 5,
                        top: index == 0 ? 5 : 0,
                        left: 10,
                        right: 10,
                      ),
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                childCount: 10),
          )
        ],
      ),
    );
  }

  _toggleFollow() async {
    bool? res = await _connRepo.toggleConnection(id: widget.id);
    if (res != null) {
      setState(() {
        hasConn = res;
      });
    }
  }

  List<RootNodeOutlinedButton> _actionButtons() {
    return [
      RootNodeOutlinedButton(
        onPressed: () => debugPrint("Share Button Pressed!"),
        child: Text("Share", style: RootNodeFontStyle.body),
      ),
      RootNodeOutlinedButton(
        onPressed: () => debugPrint('Message Button Pressed!'),
        child:
            const Icon(Boxicons.bxs_message_square_dots, color: Colors.white54),
      ),
      RootNodeOutlinedButton(
        onPressed: () async {
          if (widget.id == widget.user.id!) {
            debugPrint("Edit Button Pressed!");
          } else {
            _toggleFollow();
            debugPrint("Follow Button Pressed!");
          }
        },
        child: hasConn != null
            ? widget.id != widget.user.id
                ? Text(hasConn! ? "Unfollow" : "Follow",
                    style: RootNodeFontStyle.body)
                : Text("Edit", style: RootNodeFontStyle.body)
            : const SizedBox.shrink(),
      ),
    ];
  }
}
