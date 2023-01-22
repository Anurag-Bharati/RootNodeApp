import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/widgets/radio_button.dart';
import 'package:rootnode/widgets/switch_button.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key, this.user});
  final User? user;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _globalkey = GlobalKey<FormState>();
  final _captionFieldController = TextEditingController();
  int maxLines = 2;
  List<String> visibility = ['Private', 'Mutual', 'Public'];
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
                TextFormField(
                  onTap: () => setState(() {
                    maxLines = 3;
                  }),
                  onEditingComplete: () => setState(() {
                    FocusScope.of(context).unfocus();
                    maxLines = 2;
                  }),
                  controller: _captionFieldController,
                  maxLines: maxLines,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.cyan[400],
                  cursorHeight: 5,
                  cursorWidth: 10,
                  style: RootNodeFontStyle.captionDefault,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    hintText: "What's on your mind?",
                    hintStyle: RootNodeFontStyle.caption,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [
                        Text("Images or Videos", style: RootNodeFontStyle.body),
                        ElevatedButton(
                            onPressed: () {}, child: const Text("Add Media")),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: RootNodeRadioButton(
                    name: "Visibility",
                    options: const ["Private", "Mutual", "Public"],
                    onChanged: (String value) {
                      print(value);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    width: double.infinity,
                    child: RootNodeRadioButton(
                      name: "Markdown",
                      options: const ["No", "Yes"],
                      onChanged: (String value) {
                        print(value);
                      },
                    )),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RootNodeSwitchButton(
                    isChecked: false,
                    name: "Likeable",
                    onChanged: (value) => print(value),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RootNodeSwitchButton(
                    isChecked: false,
                    name: "Commentable",
                    onChanged: (value) => print(value),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RootNodeSwitchButton(
                    isChecked: false,
                    name: "Shareable",
                    onChanged: (value) => print(value),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
}
