import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rootnode/constant/layout_constraints.dart';
import 'package:rootnode/model/post_model.dart';
import 'package:rootnode/widgets/post_container.dart';
import 'package:rootnode/services/post_api_service.dart';

class HomeScreen extends StatefulWidget {
  String? email;
  HomeScreen(email, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late PostModel? _postModel;
  final List<Post> _posts = [];
  int page = 1;
  late int total;

  void _clearInitials() {
    setState(() {
      _posts.clear();
      page = 1;
    });
  }

  void _getInitialData() async {
    _postModel = await PostApiService.getPost(page: page);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
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
    super.initState();
    _getInitialData();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetchMoreData();
      }
    });
  }

  @override
  void dispose() {
    _clearInitials();
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // extendBody: true,
        // extendBodyBehindAppBar: true,
        bottomNavigationBar: GNav(
          tabMargin: const EdgeInsets.all(10),
          tabBorderRadius: 50,
          tabBackgroundColor:
              mqSmallW(context) ? Colors.white12 : Colors.transparent,
          curve: Curves.easeInQuad,
          duration: const Duration(milliseconds: 300),
          color: Colors.white54,
          activeColor: Colors.cyan,
          iconSize: mqSmallW(context)
              ? LayoutConstants.postIconBig
              : LayoutConstants.postIcon,
          backgroundColor: const Color(0xFF111111),
          padding: mqSmallW(context)
              ? const EdgeInsets.all(10)
              : const EdgeInsets.all(5),
          gap: mqSmallW(context) ? 10 : 0,
          tabs: [
            GButton(
                icon: Boxicons.bxs_home,
                text: mqSmallW(context) ? 'Home' : "" /***/),
            GButton(
                icon: Boxicons.bx_stats,
                text: mqSmallW(context) ? 'Node' : "" /***/),
            GButton(
                icon: Boxicons.bxs_message_square_dots,
                text: mqSmallW(context) ? 'Chat' : ""),
            GButton(
                icon: Boxicons.bxs_calendar_event,
                text: mqSmallW(context) ? 'Event' : ""),
          ],
        ),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: mqSmallH(context) ? 80 : 60,
          backgroundColor: const Color(0xFF111111),
          title: const RootNodeBar(),
          actions: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 10),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: Colors.white70, size: 24),
                ),
                mqSmallW(context)
                    ? IconButton(
                        splashRadius: 20,
                        onPressed: () {},
                        icon: const Icon(Icons.notifications,
                            color: Colors.white70, size: 22),
                      )
                    : const SizedBox()
              ]),
            ),
          ],
        ),
        body: Container(
          color: const Color(0xFF111111),
          width: double.infinity,
          height: double.maxFinite,
          child:
              // POST
              _posts.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(LayoutConstants.postPadding),
                        child: CircularProgressIndicator(
                          color: Colors.white10,
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      color: Colors.white10,
                      backgroundColor: Colors.black12,
                      onRefresh: () async {
                        _clearInitials();
                        _getInitialData();
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _posts.length + 1,
                        itemBuilder: (context, index) {
                          return index < _posts.length
                              ? PostContainer(post: _posts[index])
                              : PostLoader(page: page, total: total);
                        },
                      ),
                    ),
        ),
      ),
    );
  }

  bool mqSmallW(BuildContext context) =>
      MediaQuery.of(context).size.width > 320;
  bool mqSmallH(BuildContext context) =>
      MediaQuery.of(context).size.height > 320;
}

class RootNodeBar extends StatelessWidget {
  const RootNodeBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {},
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.all(3),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white10,
              shape: BoxShape.circle,
            ),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              image:
                  "https://cdn.shopify.com/s/files/1/0344/6469/files/angry.jpg?v=1560891349",
              placeholder: 'assets/images/image_grey.png',
            ),
          ),
        ),
        const SizedBox(width: 10 - 3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Good Morning,",
                style: TextStyle(
                    overflow: TextOverflow.fade,
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              Text(
                "ANURAG",
                style: TextStyle(
                  overflow: TextOverflow.fade,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
