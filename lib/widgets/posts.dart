import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/app/constant/layout.dart';
import 'package:rootnode/model/post_model.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: LayoutConstants.postMarginTLR,
      decoration: const BoxDecoration(
        color: Colors.white10,
        borderRadius: LayoutConstants.postCardBorderRadius,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _PostHeader(post: post),
        const SizedBox(height: 16),
        _PostBody(post: post),
        const Divider(thickness: 3, color: Color(0xFF111111)),
        _PostFooter(post: post)
      ]),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: LayoutConstants.postPaddingTLR,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: 40,
          width: 40,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white10,
            shape: BoxShape.circle,
          ),
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            image: post.profile,
            placeholder: 'assets/images/image_grey.png',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Wrap(direction: Axis.vertical, spacing: -5, children: [
            Text(post.user, style: RootNodeFontStyle.title),
            Text(post.usertag, style: RootNodeFontStyle.subtitle),
          ]),
        ),
        Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              Text(
                "14h",
                textAlign: TextAlign.center,
                style: RootNodeFontStyle.label,
              ),
              const Icon(
                Boxicons.bx_dots_vertical_rounded,
                color: Colors.white70,
                size: LayoutConstants.postIcon,
              ),
            ])
      ]),
    );
  }
}

class _PostBody extends StatelessWidget {
  const _PostBody({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: LayoutConstants.postPadding),
          child: Text(
            post.content,
            softWrap: true,
            style: RootNodeFontStyle.caption,
          ),
        ),
        post.media != null
            ? Center(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      borderRadius: LayoutConstants.postContentBorderRadius),
                  margin: const EdgeInsets.all(LayoutConstants.postInnerMargin),
                  child: AnimatedSize(
                    curve: Curves.easeInQuad,
                    duration: const Duration(milliseconds: 500),
                    child: Image.network(post.media!, fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white10,
                          color: Colors.white70,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    }),
                  ),
                ),
              )
            : const SizedBox(height: 10),
      ],
    );
  }
}

class _PostFooter extends StatefulWidget {
  const _PostFooter({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  State<_PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<_PostFooter> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: LayoutConstants.postActionPadding,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Wrap(spacing: 20, children: [
          LikeButton(
            size: LayoutConstants.postIcon,
            likeCount: widget.post.likes,
            likeBuilder: (isLiked) {
              return isLiked
                  ? const Icon(
                      Boxicons.bxs_like,
                      color: Colors.white70,
                      size: 20,
                    )
                  : const Icon(
                      Boxicons.bx_like,
                      color: Colors.white70,
                      size: 20,
                    );
            },
          ),
          LikeButton(
            size: LayoutConstants.postIcon,
            likeCount: widget.post.comment,
            likeBuilder: (isLiked) {
              return isLiked
                  ? const Icon(
                      Boxicons.bxs_message_square_detail,
                      color: Colors.white70,
                      size: 20,
                    )
                  : const Icon(
                      Boxicons.bx_message_square_detail,
                      color: Colors.white70,
                      size: 20,
                    );
            },
          ),
        ]),
        const Icon(
          Boxicons.bx_share,
          color: Colors.white70,
          size: 22,
        )
      ]),
    );
  }
}

class PostLoader extends StatelessWidget {
  const PostLoader({
    Key? key,
    required this.page,
    required this.total,
  }) : super(key: key);

  final int page;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: page == total
            ? const Text(
                "all caught up !",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70),
              )
            : const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white10,
                ),
              ),
      ),
    ]);
  }
}