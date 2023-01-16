import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/model/post_model.dart';
import 'package:rootnode/model/user.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List<Post> stories;

  const Stories({super.key, required this.currentUser, required this.stories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 124.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
        itemCount: 1 + stories.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _StoryCard(
                isAddStory: true,
                currentUser: currentUser,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _StoryCard(
              currentUser: currentUser,
            ),
          );
        },
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final User currentUser;
  final Post? story = null;

  const _StoryCard({
    Key? key,
    this.isAddStory = false,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: isAddStory
              ? Container(
                  height: double.infinity,
                  width: 110.0,
                  color: Colors.cyan,
                )
              : Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png",
                  height: double.infinity,
                  width: 110.0,
                  fit: BoxFit.cover,
                ),
        ),
        GestureDetector(
          onTap: () => debugPrint("Hi Story"),
          child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: 110.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: const LinearGradient(
                colors: [
                  Color(0x55111111),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: isAddStory
                ? const SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: Icon(Icons.add, size: 40),
                  )
                : const SizedBox(),
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            isAddStory ? 'Add story' : "This is a test aaa sss",
            style: RootNodeFontStyle.subtitle,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
