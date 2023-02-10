import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_cmnt.dart';
import 'package:rootnode/model/comment/comment.dart';
import 'package:rootnode/model/post.dart';
import 'package:rootnode/model/user/user.dart';
import 'package:rootnode/provider/session_provider.dart';
import 'package:rootnode/repository/cmnt_repo.dart';
import 'package:rootnode/repository/post_repo.dart';
import 'package:rootnode/widgets/comment.dart';
import 'package:rootnode/widgets/comment_bar.dart';
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
  CommentResponse? commentResponse;
  final List<Comment> comments = [];
  late final bool isOwn;

  Future<void> _fetchPost() async =>
      post = await PostRepoImpl().getPostById(id: widget.id);

  Future<void> _fetchComments() async =>
      commentResponse = await CommentRepoImpl().getPostComments(id: widget.id);

  @override
  void initState() {
    rootnode = ref.read(sessionProvider.select((value) => value.user!));
    _fetchPost().then((value) => setState(() {
          isOwn = rootnode.id! == post!.owner!.id!;
        }));

    _fetchComments().then((value) {
      if (commentResponse == null) return;
      comments.addAll(commentResponse!.comments ?? []);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rootnode = ref.watch(sessionProvider.select((value) => value.user!));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comment",
          style: RootNodeFontStyle.header,
        ),
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        commentResponse != null
            ? Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return post != null
                          ? PostContainer(
                              post: post!,
                              likedMeta: widget.liked,
                              disableComment: true,
                            )
                          : Container(height: 200, color: Colors.white10);
                    }
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: index == comments.length ? 10 : 0),
                      child: Center(
                          child:
                              CommentContainer(comment: comments[index - 1])),
                    );
                  },
                  itemCount: comments.length + 1,
                ),
              )
            : Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        height: 200,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        color: Colors.white10,
                      );
                    }
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: Colors.white10,
                    );
                  },
                  itemCount: 5,
                ),
              ),
        const BottomCommentBar(),
      ]),
    );
  }
}
