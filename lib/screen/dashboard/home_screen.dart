import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rootnode/model/post_model.dart';
import 'package:rootnode/widgets/post_container.dart';
import 'package:rootnode/services/post_api_service.dart';

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

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late PostModel? _postModel;
  final List<Post> _posts = [];
  int page = 1;
  late int total;
  bool navHidden = false;
  void _clearInitials() {
    setState(() {
      _posts.clear();
      page = 1;
    });
  }

  void _getInitialData() async {
    _postModel = await PostApiService.getPost(page: page);
    setState(() {
      _posts.addAll(_postModel!.posts);
      total = _postModel!.totalPages;
    });
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
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (navHidden) {
          widget.showNavbar();
          navHidden = false;
        }
      } else {
        if (!navHidden) {
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
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 650),
        color: const Color(0xFF111111),
        width: double.infinity,
        height: double.maxFinite,
        child:
            // POST
            _posts.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white10,
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
    );
  }
}
