import 'dart:io';

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/app/utils/snackbar.dart';
import 'package:rootnode/helper/utils.dart' show Utils;
import 'package:rootnode/model/story.dart';
import 'package:rootnode/repository/story_repo.dart';
import 'package:rootnode/widgets/add_media.dart';
import 'package:rootnode/widgets/radio_button.dart';
import 'package:rootnode/widgets/selection_tile.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({super.key, required this.type});
  final RNContentType type;

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {
  final _storyRepo = StoryRepoImpl();
  final _globalkey = GlobalKey<FormState>();
  final _quoteFieldController = TextEditingController();
  List<String> visibilityOption = ['Private', 'Mutual', 'Public'];

  Story story = Story();
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: file != null || widget.type == RNContentType.text,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Create Story",
          style: RootNodeFontStyle.header.copyWith(color: Colors.white70),
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
        padding: const EdgeInsets.all(00),
        child: Form(
          key: _globalkey,
          child: widget.type == RNContentType.text
              ? const CreateTextStory()
              : mediaStoryOptions(),
        ),
      ),
    );
  }

  Widget mediaStoryOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: file != null ? 400 : null,
          child: file != null
              ? Stack(fit: StackFit.expand, children: [
                  Image.file(
                    File(file!.path),
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: Utils.getViewShadow(),
                    ),
                  ),
                ])
              : Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(20),
                    child: RootNodeAddMedia(
                        single: true,
                        onChanged: (List<XFile>? files) => setState(() {
                              file = files!.first;
                            }),
                        type: widget.type),
                  ),
                ),
        ),
      ],
    );
  }

  void _craftStory(context) {
    String quote = _quoteFieldController.text;
    if (quote == "" && (file == null)) {
      return showSnackbar(
        context,
        "Story must contain media or quote",
        Colors.red[400]!,
      );
    }
    if (quote != "") story.quote = quote;
    _uploadStory(context);
  }

  void _uploadStory(context) async {
    bool res = await _storyRepo.createStory(story: story, file: file);
    if (res) {
      Navigator.pop(context, "New story created!");
    } else {
      showSnackbar(context, "Something went wrong!", Colors.red[400]!);
    }
  }
}

class CreateTextStory extends StatefulWidget {
  const CreateTextStory({
    super.key,
  });

  @override
  State<CreateTextStory> createState() => _CreateTextStoryState();
}

class _CreateTextStoryState extends State<CreateTextStory> {
  MaterialColor color = Colors.cyan;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 400,
          child: Stack(fit: StackFit.expand, children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              color: color,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: Utils.getViewShadow(),
              ),
            ),
          ]),
        ),
        RootNodeRadioButton<Color>(
          isColors: true,
          value: const [
            Colors.cyan,
            Colors.amber,
            Colors.red,
            Colors.purple,
            Colors.pink,
            Colors.green
          ],
          options: List.filled(6, ""),
          onChanged: (value) {
            setState(() {
              color = value as MaterialColor;
            });
          },
          selected: 0,
        )
      ],
    );
  }
}
