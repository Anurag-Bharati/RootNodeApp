import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/app/utils/snackbar.dart';
import 'package:rootnode/model/post.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/repository/post_repo.dart';
import 'package:rootnode/widgets/add_media.dart';
import 'package:rootnode/widgets/radio_button.dart';
import 'package:rootnode/widgets/switch_button.dart';

enum PostType { image, video, markdown }

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key, this.user, required this.type});
  final User? user;
  final PostType type;
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _postRepo = PostRepoImpl();
  final _globalkey = GlobalKey<FormState>();
  final _captionFieldController = TextEditingController();
  List<String> visibilityOption = ['Private', 'Mutual', 'Public'];

  Post post = Post();
  List<XFile>? files;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Post",
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF111111),
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _globalkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextFormField(
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                    controller: _captionFieldController,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.cyan[400],
                    cursorHeight: 5,
                    cursorWidth: 15,
                    style: RootNodeFontStyle.captionDefault,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      hintText: "What's on your mind?",
                      hintStyle: RootNodeFontStyle.body,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: RootNodeRadioButton(
                    selected: 2,
                    name: "Visibility",
                    options: const ["Private", "Mutual", "Public"],
                    onChanged: (String value) {
                      debugPrint(value);
                      post.visibility = value;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    width: double.infinity,
                    child: RootNodeRadioButton(
                      selected: 1,
                      name: "Markdown",
                      options: const ["Yes", "No"],
                      onChanged: (String value) {
                        debugPrint(value);
                        post.isMarkdown = value == "no" ? false : true;
                      },
                    )),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RootNodeSwitchButton(
                    isChecked: true,
                    name: "Likeable",
                    onChanged: (value) => post.likeable = value,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RootNodeSwitchButton(
                    isChecked: true,
                    name: "Commentable",
                    onChanged: (value) => post.commentable = value,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RootNodeSwitchButton(
                    isChecked: true,
                    name: "Shareable",
                    onChanged: (value) => post.shareable = value,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: RootNodeAddMedia(
                      onChanged: (value) {
                        debugPrint("==FILES AT CREATE POST==");
                        if (value == null || value.isEmpty) return;
                        files = value;
                      },
                      type: widget.type,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          _craftPost(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Text(
                            "Create Now!",
                            style: RootNodeFontStyle.body,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _craftPost(context) {
    String caption = _captionFieldController.text;
    if (caption == "" && (files == null || files!.isEmpty)) {
      return showSnackbar(
        context,
        "Post must contain media or caption",
        Colors.red[400]!,
      );
    }
    if (caption != "") post.caption = caption;
    _uploadPost(context);
  }

  void _uploadPost(context) async {
    bool res = await _postRepo.createPost(post: post, files: files);
    if (res) {
      Navigator.pop(context, "New post created!");
    } else {
      showSnackbar(context, "Something went wrong!", Colors.red[400]!);
    }
  }
}
