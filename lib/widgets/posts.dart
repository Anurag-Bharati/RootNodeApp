import 'package:boxicons/boxicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/app/constant/layout.dart';
import 'package:rootnode/helper/switch_route.dart';
import 'package:rootnode/helper/utils.dart';
import 'package:rootnode/model/post.dart';
import 'package:rootnode/repository/post_repo.dart';
import 'package:rootnode/screen/misc/view_post_media.dart';
import 'package:rootnode/widgets/placeholder.dart';

import 'package:string_extensions/string_extensions.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({
    Key? key,
    required this.post,
    required this.likedMeta,
    this.tagPrefix,
    this.compact = false,
  }) : super(key: key);

  final Post post;
  final bool likedMeta;
  final String? tagPrefix;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: LayoutConstants.postMarginTLR,
      decoration: const BoxDecoration(
        color: Colors.white10,
        borderRadius: LayoutConstants.postCardBorderRadius,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _PostHeader(
          post: post,
          compact: compact,
        ),
        SizedBox(
          height: compact || post.caption == null ? 5 : 10,
        ),
        _PostBody(
          compact: true,
          tagPrefix: tagPrefix,
          post: post,
          isLiked: likedMeta,
        ),
        const Divider(thickness: 3, color: Color(0xFF111111)),
        _PostFooter(
          compact: true,
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
    required this.compact,
  }) : super(key: key);

  final Post post;
  final bool compact;

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
            imageCacheWidth: 128,
            imageCacheHeight: 128,
            fit: BoxFit.cover,
            image: post.owner!.avatar != null
                ? "${ApiConstants.baseUrl}\\${post.owner!.avatar}"
                : "https://icon-library.com/images/anonymous-user-icon/anonymous-user-icon-2.jpg",
            placeholder: 'assets/images/image_grey.png',
            imageErrorBuilder: (context, error, stackTrace) =>
                Icon(Icons.broken_image, color: Colors.red[400]!),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Wrap(direction: Axis.vertical, spacing: -5, children: [
            compact
                ? Text(post.owner!.fname!.toTitleCase!,
                    style: RootNodeFontStyle.title)
                : Text(
                    "${post.owner!.fname!} ${post.owner!.lname!}".toTitleCase!,
                    style: RootNodeFontStyle.title),
            compact
                ? Text(
                    "${Utils.getTimeAgo(post.createdAt!)} ago",
                    textAlign: TextAlign.center,
                    style: RootNodeFontStyle.label,
                  )
                : Text(
                    "@${post.owner!.username!}",
                    style: RootNodeFontStyle.subtitle,
                  ),
          ]),
        ),
        compact
            ? const SizedBox.shrink()
            : Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    Utils.getTimeAgo(post.createdAt!),
                    textAlign: TextAlign.center,
                    style: RootNodeFontStyle.label,
                  ),
                  const Icon(
                    Boxicons.bx_dots_vertical_rounded,
                    color: Colors.white70,
                    size: LayoutConstants.postIcon,
                  ),
                ],
              )
      ]),
    );
  }
}

class _PostBody extends StatelessWidget {
  const _PostBody({
    Key? key,
    required this.post,
    required this.isLiked,
    this.tagPrefix,
    required this.compact,
  }) : super(key: key);

  final Post post;
  final bool isLiked;
  final String? tagPrefix;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => switchRouteByPush(
          context,
          ViewPost(
            post: post,
            likedMeta: isLiked,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: compact ? 10 : LayoutConstants.postPadding),
            child: Text(
              post.caption ?? "",
              softWrap: true,
              style: RootNodeFontStyle.caption,
            ),
          ),
          post.mediaFiles.isNotEmpty
              ? Center(
                  child: Container(
                    width: double.maxFinite,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                        borderRadius: LayoutConstants.postContentBorderRadius),
                    margin: EdgeInsets.all(
                        compact ? 10 : LayoutConstants.postInnerMargin),
                    child: AnimatedSize(
                        curve: Curves.easeInQuad,
                        duration: const Duration(milliseconds: 500),
                        child: post.mediaFiles.length == 1 &&
                                post.mediaFiles[0].type == "image"
                            ? Hero(
                                tag: post.id.toString(),
                                child: AspectRatio(
                                  aspectRatio: 4 / 3,
                                  child:
                                      PostImage(url: post.mediaFiles[0].url!),
                                ),
                              )
                            : Stack(
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      enableInfiniteScroll: false,
                                      disableCenter: true,
                                      enlargeCenterPage: true,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.scale,
                                      viewportFraction: 1,
                                    ),
                                    items: post.mediaFiles.map((e) {
                                      return Builder(
                                        key: PageStorageKey(key),
                                        builder: (BuildContext context) {
                                          return e.type! == 'image'
                                              ? Hero(
                                                  tag: tagPrefix != null
                                                      ? '$tagPrefix-${post.id!}'
                                                      : post.id!,
                                                  child: PostImage(url: e.url!))
                                              : Container(color: Colors.cyan);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  const Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Boxicons.bx_images,
                                            size: 20, color: Colors.white54),
                                      ))
                                ],
                              )),
                  ),
                )
              : SizedBox(height: post.caption != null ? 10 : 0),
        ],
      ),
    );
  }
}

class PostImage extends StatelessWidget {
  const PostImage({
    super.key,
    required this.url,
    this.tagPrefix,
  });

  final String url;
  final String? tagPrefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      constraints: const BoxConstraints(maxHeight: 300, minHeight: 0),
      child: CachedNetworkImage(
          maxWidthDiskCache: 500,
          imageUrl: "${ApiConstants.baseUrl}/$url",
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const MediaError(
                icon: Icons.broken_image,
              ),
          progressIndicatorBuilder: (context, url, progress) => MediaLoading(
                label: "Loading Image",
                icon: Boxicons.bx_image,
                progress: progress,
              )),
    );
  }
}

class _PostFooter extends StatefulWidget {
  const _PostFooter({
    Key? key,
    required this.post,
    required this.likedMeta,
    required this.compact,
  }) : super(key: key);

  final Post post;
  final bool likedMeta;
  final bool compact;

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
        widget.compact
            ? const SizedBox.shrink()
            : const Icon(
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
