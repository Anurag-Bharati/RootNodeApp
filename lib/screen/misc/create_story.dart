import 'dart:io';

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/app/utils/snackbar.dart';
import 'package:rootnode/helper/utils.dart' show Utils;
import 'package:rootnode/model/story.dart';
import 'package:rootnode/repository/story_repo.dart';
import 'package:rootnode/screen/misc/view_story.dart';
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
  List<String> visibilityOption = ['Private', 'Mutual', 'Public'];
  XFile? file;

  bool appBar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: file != null || widget.type == RNContentType.text,
      appBar: appBar
          ? AppBar(
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
            )
          : null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF111111),
        padding: const EdgeInsets.all(00),
        child: widget.type == RNContentType.text
            ? CreateTextStory(
                toggleAppbarOff: () => setState(() {
                  appBar = false;
                }),
                toggleAppbarOn: () => setState(() {
                  appBar = true;
                }),
                onSubmit: (value) => _uploadStory(context, value),
              )
            : mediaStoryOptions(),
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

  void _uploadStory(context, Story story) async {
    print(story.toJson());
    print(file);
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
    required this.toggleAppbarOn,
    required this.toggleAppbarOff,
    required this.onSubmit,
  });
  final VoidCallback toggleAppbarOn;
  final VoidCallback toggleAppbarOff;
  final ValueSetter<Story> onSubmit;

  @override
  State<CreateTextStory> createState() => _CreateTextStoryState();
}

class _CreateTextStoryState extends State<CreateTextStory> {
  final Story story = Story();
  MaterialColor color = Colors.cyan;
  final _quoteFieldController = TextEditingController();
  final _globalkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _globalkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 400,
              child: Stack(
                fit: StackFit.expand,
                children: [
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: StoryHeading(
                        story: Story(quote: _quoteFieldController.text),
                      ),
                    ),
                  )
                ],
              ),
            ),
            RootNodeRadioButton<MaterialColor>(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              isColors: true,
              value: const [
                Colors.cyan,
                Colors.green,
                Colors.amber,
                Colors.pink,
                Colors.red,
                Colors.purple,
              ],
              options: List.filled(6, ""),
              onChanged: (value) {
                setState(() {
                  color = value;
                });
              },
              selected: 0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                  widget.toggleAppbarOn();
                },
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                  widget.toggleAppbarOn();
                },
                onTap: () => widget.toggleAppbarOff(),
                controller: _quoteFieldController,
                onChanged: (value) => setState(() {}),
                maxLines: 5,
                textAlign: TextAlign.center,
                cursorColor: Colors.cyan[400],
                cursorHeight: 5,
                cursorWidth: 15,
                validator: (value) {
                  if (value == null || value == "" || value.length < 5) {
                    return "Quote must be 5 char long";
                  }
                  return null;
                },
                style: RootNodeFontStyle.captionDefault,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10,
                  hintText: 'Add a Quote',
                  hintStyle: RootNodeFontStyle.body,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () => _handleProcessing(context),
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
    );
  }

  _handleProcessing(BuildContext context) {
    if (!_globalkey.currentState!.validate()) {
      return;
    }
    story.quote = _quoteFieldController.text;
    story.color = color.value;
    widget.onSubmit(story);
  }
}
