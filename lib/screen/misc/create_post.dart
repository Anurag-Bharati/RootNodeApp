import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/model/user.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key, this.user});
  final User? user;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _globalkey = GlobalKey<FormState>();
  final _captionFieldController = TextEditingController();
  int maxLines = 1;
  int selected = 0;
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
                    maxLines = 1;
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
                const SizedBox(height: 12),
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
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [
                        Text("Visibility", style: RootNodeFontStyle.body),
                        Wrap(
                          spacing: 10,
                          children: [
                            RootNodeRadioButton("Private", 0),
                            RootNodeRadioButton("Mutual", 1),
                            RootNodeRadioButton("Public", 2),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [
                        Text("Markdown", style: RootNodeFontStyle.body),
                        Wrap(
                          spacing: 10,
                          children: [
                            RootNodeRadioButton("No", 0),
                            RootNodeRadioButton("Yes", 1),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text("Likeable", style: RootNodeFontStyle.body),
                        Checkbox(value: true, onChanged: (x) {})
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text("Commentable", style: RootNodeFontStyle.body),
                        Checkbox(value: true, onChanged: (x) {})
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text("Shareable", style: RootNodeFontStyle.body),
                        Checkbox(value: true, onChanged: (x) {})
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Create Now!")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget RootNodeRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () => setState(() {
        selected = index;
      }),
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) =>
            selected == index
                ? const Color.fromRGBO(2, 116, 132, 1)
                : Colors.white10),
        side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
            color: selected == index ? Colors.cyan : Colors.white10)),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: Text(
        text,
        style: RootNodeFontStyle.caption,
      ),
    );
  }
}

// CustomRadioButton(
//                   elevation: 0,
//                   height: 48,
//                   unSelectedColor: Colors.white10,
//                   selectedBorderColor: Colors.transparent,
//                   unSelectedBorderColor: Colors.transparent,
//                   autoWidth: true,
//                   buttonLables: const [
//                     'Private',
//                     'Mutual',
//                     'Public',
//                   ],
//                   buttonValues: const [
//                     "private",
//                     "mutual",
//                     "public",
//                   ],
//                   buttonTextStyle: ButtonTextStyle(
//                     selectedColor: Colors.white,
//                     unSelectedColor: Colors.white30,
//                     textStyle: RootNodeFontStyle.caption,
//                   ),
//                   defaultSelected: "public",
//                   radioButtonValue: (value) {
//                     print(value);
//                   },
//                   selectedColor: Colors.cyan,
//                 ),