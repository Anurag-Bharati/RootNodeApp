import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/model/post.dart';

class ViewPost extends StatelessWidget {
  const ViewPost({
    super.key,
    required this.post,
    required this.likedMeta,
  });
  final Post post;
  final bool likedMeta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: post.id.toString(),
        child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: PageView.builder(
              itemBuilder: (context, index) => InteractiveViewer(
                child: Image.network(
                  "${ApiConstants.baseUrl}/${post.mediaFiles[index].url!}",
                  fit: BoxFit.fitWidth,
                ),
              ),
              itemCount: post.mediaFiles.length,
            )),
      ),
    );
  }
}
