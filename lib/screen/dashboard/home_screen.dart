import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/model/post_model.dart';
import 'package:rootnode/services/post_api_service.dart';
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
  late final ScrollController _scrollController;
  late final TabController? _tabController;

  late PostModel? _postModel;
  final List<Post> _posts = [];
  int page = 1;
  late int total;
  bool navHidden = false;

  void _clearInitials() async {
    setState(() {
      _posts.clear();
      page = 1;
    });
  }

  void _getInitialData() async {
    _postModel = await PostApiService.getPost(page: page);
    Future.delayed(
        const Duration(seconds: 1),
        () => setState(() {
              _posts.addAll(_postModel!.posts);
              total = _postModel!.totalPages;
            }));
  }

  void _fetchMoreData() async {
    if (page == total) return;
    page = page == total ? total : page + 1;
    _postModel = await PostApiService.getPost(page: page);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _posts.addAll(_postModel!.posts);
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
        _getInitialData();
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: TabBar(
              overlayColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.transparent),
              onTap: (value) => debugPrint("Tab is Tabbed"),
              labelColor: Colors.white70,
              indicatorColor: Colors.cyan,
              indicatorPadding: const EdgeInsets.all(10),
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: RootNodeFontStyle.body,
              unselectedLabelColor: Colors.white30,
              splashFactory: NoSplash.splashFactory,
              isScrollable: false,
              padding: EdgeInsets.zero,
              controller: _tabController,
              tabs: const [Tab(text: "Public"), Tab(text: "Mutual")],
            ),
          ),
          const SliverToBoxAdapter(child: DummySearchField()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stories(currentUser: User(), stories: _posts),
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
                        : PostLoader(page: page, total: total);
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
