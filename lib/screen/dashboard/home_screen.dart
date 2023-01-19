import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_post.dart';
import 'package:rootnode/model/post.dart';
import 'package:rootnode/repository/post_repo.dart';
import 'package:rootnode/widgets/posts.dart';
import 'package:rootnode/widgets/stories.dart';

import '../../model/user.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "home";
  final User? user;
  final VoidCallback showNavbar;
  final VoidCallback hideNavbar;
  const HomeScreen(
      {super.key,
      this.user,
      required this.showNavbar,
      required this.hideNavbar});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _postRepo = PostRepoImpl();
  late final ScrollController _scrollController;
  late final TabController? _tabController;
  bool navHidden = false;
  bool privateFeed = false;

  late PostResponse? _postResponse;
  List<Post> _posts = [];
  final List<Post> _publicFeed = [];
  final List<Post> _privateFeed = [];
  late int privateTotal;
  late int publicTotal;
  int privatePage = 1;
  int publicPage = 1;

  void _clearInitials() async {
    setState(() {
      _posts.clear();
      privateFeed ? _privateFeed.clear() : _publicFeed.clear();
      privateFeed ? privatePage = 1 : publicPage = 1;
    });
  }

  void _getInitialData({int refresh = 0}) async {
    _postResponse = await _postRepo.getPostFeed(
      page: privateFeed ? privatePage : publicPage,
      refresh: refresh,
      private: privateFeed,
    );
    Future.delayed(
        const Duration(seconds: 1),
        () => setState(() {
              privateFeed
                  ? _privateFeed
                      .addAll(_postResponse!.data!.posts as Iterable<Post>)
                  : _publicFeed
                      .addAll(_postResponse!.data!.posts as Iterable<Post>);
              privateFeed
                  ? privateTotal = _postResponse!.totalPages!
                  : publicTotal = _postResponse!.totalPages!;
              _posts = privateFeed ? _privateFeed : _publicFeed;
            }));
  }

  void _fetchMoreData() async {
    bool condn =
        privateFeed ? privatePage == privateTotal : publicPage == publicTotal;
    if (condn) return;
    privateFeed
        ? privatePage == privateTotal
            ? privatePage = privateTotal
            : privatePage++
        : publicPage == publicTotal
            ? publicTotal
            : publicPage++;
    _postResponse = await _postRepo.getPostFeed(
      page: privateFeed ? privatePage : publicPage,
      refresh: 0,
      private: privateFeed,
    );
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          privateFeed
              ? _privateFeed
                  .addAll(_postResponse!.data!.posts as Iterable<Post>)
              : _publicFeed
                  .addAll(_postResponse!.data!.posts as Iterable<Post>);
          _posts = privateFeed ? _privateFeed : _publicFeed;
        }));
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    _getInitialData();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (navHidden) {
          debugPrint("Show");
          widget.showNavbar();
          navHidden = false;
        }
      } else {
        if (!navHidden) {
          debugPrint("Hide");
          widget.hideNavbar();
          navHidden = true;
        }
      }
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetchMoreData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.cyan,
      backgroundColor: Colors.transparent,
      onRefresh: () async {
        _clearInitials();
        _getInitialData(refresh: 1);
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverToBoxAdapter(child: DummySearchField()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stories(currentUser: User(), stories: _posts),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(20)),
              child: TabBar(
                enableFeedback: true,
                overlayColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.transparent),
                onTap: (value) => setState(() {
                  privateFeed = value == 0 ? false : true;
                  _clearInitials();
                  _getInitialData();
                }),
                labelColor: Colors.white70,
                indicatorColor: Colors.cyan,
                indicatorPadding: const EdgeInsets.all(10),
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: RootNodeFontStyle.body,
                unselectedLabelColor: Colors.white30,
                splashFactory: NoSplash.splashFactory,
                isScrollable: false,
                dividerColor: Colors.transparent,
                padding: EdgeInsets.zero,
                controller: _tabController,
                tabs: const [Tab(text: "Public"), Tab(text: "Mutual")],
              ),
            ),
          ),
          _posts.isEmpty
              ? SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Colors.white10,
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return index < _posts.length
                        ? PostContainer(post: _posts[index])
                        : PostLoader(
                            page: privateFeed ? privatePage : publicPage,
                            total: privateFeed ? privateTotal : publicTotal,
                          );
                  }, childCount: _posts.length + 1),
                )
        ],
        // POST
      ),
    );
  }
}

class DummySearchField extends StatelessWidget {
  const DummySearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: const Color(0xFF333333),
          borderRadius: BorderRadius.circular(10)),
      child: Wrap(
        spacing: 10,
        children: [
          const Icon(Boxicons.bx_search, color: Colors.white54),
          Text(
            "Find people, events...",
            style: RootNodeFontStyle.label,
          )
        ],
      ),
    );
  }
}
