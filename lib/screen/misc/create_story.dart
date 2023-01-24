import 'package:boxicons/boxicons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/app/utils/snackbar.dart';
import 'package:rootnode/model/story.dart';
import 'package:rootnode/repository/story_repo.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {
  final _storyRepo = StoryRepoImpl();
  final _globalkey = GlobalKey<FormState>();
  final _headingFieldController = TextEditingController();
  List<String> visibilityOption = ['Private', 'Mutual', 'Public'];

  Story story = Story();
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Story",
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: double.infinity,
                color: Colors.cyan,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _craftStory(context) {
    String heading = _headingFieldController.text;
    if (heading == "" && (file == null)) {
      return showSnackbar(
        context,
        "Story must contain media or caption",
        Colors.red[400]!,
      );
    }
    if (heading != "") story.heading = heading;
    _uploadStory(context);
  }

  void _uploadStory(context) async {
    bool res = await _storyRepo.createStory(story: story, file: file);
    if (res) {
      Navigator.pop(context, "New post created!");
    } else {
      showSnackbar(context, "Something went wrong!", Colors.red[400]!);
    }
  }
}
