import 'package:boxicons/boxicons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/app/constant/layout.dart';
import 'package:rootnode/model/post.dart';
import 'package:rootnode/repository/post_repo.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:string_extensions/string_extensions.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({
    Key? key,
    required this.post,
    required this.likedMeta,
  }) : super(key: key);

  final Post post;
  final bool likedMeta;

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
        _PostBody(
          post: post,
        ),
        const Divider(thickness: 3, color: Color(0xFF111111)),
        _PostFooter(
          post: post,
          likedMeta: likedMeta,
        )
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

  String _getPostedAgo(DateTime dt) {
    Duration diff = DateTime.now().difference(dt);
    int min = diff.inMinutes;
    return timeago.format(DateTime.now().subtract(Duration(minutes: min)),
        locale: 'en_short');
  }

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
            image: post.owner!.avatar != null
                ? "${ApiConstants.baseUrl}\\${post.owner!.avatar}"
                : "https://icon-library.com/images/anonymous-user-icon/anonymous-user-icon-2.jpg",
            placeholder: 'assets/images/image_grey.png',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Wrap(direction: Axis.vertical, spacing: -5, children: [
            Text("${post.owner!.fname!} ${post.owner!.lname!}".toTitleCase!,
                style: RootNodeFontStyle.title),
            Text(
              "@${post.owner!.username!}",
              style: RootNodeFontStyle.subtitle,
            ),
          ]),
        ),
        Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              Text(
                _getPostedAgo(post.createdAt!),
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

class _PostBody extends StatefulWidget {
  const _PostBody({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  State<_PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<_PostBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: LayoutConstants.postPadding),
          child: Text(
            widget.post.caption!,
            softWrap: true,
            style: RootNodeFontStyle.caption,
          ),
        ),
        widget.post.mediaFiles.isNotEmpty
            ? Center(
                child: Container(
                  width: double.maxFinite,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      borderRadius: LayoutConstants.postContentBorderRadius),
                  margin: const EdgeInsets.all(LayoutConstants.postInnerMargin),
                  child: AnimatedSize(
                      curve: Curves.easeInQuad,
                      duration: const Duration(milliseconds: 500),
                      child: widget.post.mediaFiles.length == 1 &&
                              widget.post.mediaFiles[0].type == "image"
                          ? PostImage(url: widget.post.mediaFiles[0].url!)
                          : CarouselSlider(
                              options: CarouselOptions(
                                height: 200.0,
                                enableInfiniteScroll: false,
                                disableCenter: true,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.scale,
                                viewportFraction: 1,
                              ),
                              items: widget.post.mediaFiles.map((e) {
                                return Builder(
                                  key: PageStorageKey(widget.key),
                                  builder: (BuildContext context) {
                                    return e.type! == 'image'
                                        ? PostImage(url: e.url!)
                                        : Container(color: Colors.cyan);
                                  },
                                );
                              }).toList(),
                            )),
                ),
              )
            : const SizedBox(height: 10),
      ],
    );
  }
}

//  Make Singleton controller for video player.
class PostVideoPlayer extends StatefulWidget {
  const PostVideoPlayer({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<PostVideoPlayer> createState() => _PostVideoPlayerState();
}

class _PostVideoPlayerState extends State<PostVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class PostImage extends StatelessWidget {
  const PostImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Image.network("${ApiConstants.baseUrl} \\$url", fit: BoxFit.cover,
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
    );
  }
}

class _PostFooter extends StatefulWidget {
  const _PostFooter({
    Key? key,
    required this.post,
    required this.likedMeta,
  }) : super(key: key);

  final Post post;
  final bool likedMeta;

  @override
  State<_PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<_PostFooter> {
  final postRepo = PostRepoImpl();
  bool liking = false;
  Future<bool> togglePostLike() async {
    if (liking) return !widget.likedMeta;
    liking = true;
    bool res = await postRepo.togglePostLike(id: widget.post.id!);
    liking = false;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: LayoutConstants.postActionPadding,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Wrap(spacing: 20, children: [
          LikeButton(
            onTap: (isLiked) => togglePostLike(),
            isLiked: widget.likedMeta,
            size: LayoutConstants.postIcon,
            likeCount: widget.post.likesCount,
            likeBuilder: (isLiked) {
              return isLiked
                  ? const Icon(
                      Boxicons.bxs_like,
                      color: Colors.white70,
                      size: 22,
                    )
                  : const Icon(
                      Boxicons.bx_like,
                      color: Colors.white70,
                      size: 22,
                    );
            },
            likeCountPadding: const EdgeInsets.only(top: 2, left: 8.0),
          ),
          LikeButton(
            size: LayoutConstants.postIcon,
            likeCount: widget.post.commentsCount,
            likeBuilder: (isLiked) {
              return isLiked
                  ? const Icon(
                      Boxicons.bxs_message_square_detail,
                      color: Colors.white70,
                      size: 22,
                    )
                  : const Icon(
                      Boxicons.bx_message_square_detail,
                      color: Colors.white70,
                      size: 22,
                    );
            },
            likeCountPadding: const EdgeInsets.only(top: 2, left: 8.0),
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
