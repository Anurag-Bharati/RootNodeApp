import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/model/post.dart';
import 'package:rootnode/model/user/user.dart';
import 'package:rootnode/provider/session_provider.dart';
import 'package:rootnode/repository/post_repo.dart';
import 'package:rootnode/widgets/posts.dart';

class CommentScreen extends ConsumerStatefulWidget {
  const CommentScreen({
    super.key,
    required this.id,
    required this.liked,
  });
  final String id;
  final bool liked;

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  late User rootnode;
  Post? post;
  late final bool isOwn;

  Future<void> _fetchPost() async =>
      post = await PostRepoImpl().getPostById(id: widget.id);

  @override
  void initState() {
    rootnode = ref.read(sessionProvider.select((value) => value.user!));
    _fetchPost().then((value) => setState(() {
          isOwn = rootnode.id! == post!.owner!.id!;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rootnode = ref.watch(sessionProvider.select((value) => value.user!));
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment", style: RootNodeFontStyle.header),
        leadingWidth: 40,
        leading: IconButton(
          icon: const Icon(
            Boxicons.bx_chevron_left,
            color: Colors.white70,
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF111111),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              post != null
                  ? PostContainer(
                      post: post!,
                      likedMeta: widget.liked,
                      disableComment: true,
                    )
                  : Container(height: 400, color: Colors.white10),
            ],
          ),
        ),
      ),
    );
  }
}
