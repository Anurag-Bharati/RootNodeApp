import 'package:boxicons/boxicons.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/font.dart';

class RootNodeAddMedia extends StatefulWidget {
  const RootNodeAddMedia({
    super.key,
    required this.onChanged,
  });
  final ValueChanged<List<PlatformFile>?> onChanged;

  @override
  State<RootNodeAddMedia> createState() => _RootNodeAddMediaState();
}

class _RootNodeAddMediaState extends State<RootNodeAddMedia> {
  FilePickerResult? platformFiles;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => _pickFiles(),
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: platformFiles == null || platformFiles?.count == 0
                    ? Colors.white10
                    : const Color.fromRGBO(0, 188, 212, 0.1),
              ),
              child: DottedBorder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                borderType: BorderType.RRect,
                color: Colors.white54,
                strokeWidth: 2,
                dashPattern: const [8, 4],
                radius: const Radius.circular(10),
                strokeCap: StrokeCap.round,
                child: Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        platformFiles == null || platformFiles?.count == 0
                            ? "Select Media"
                            : "${platformFiles!.count} selected",
                        style: RootNodeFontStyle.body,
                      ),
                      const Icon(
                        Boxicons.bx_image_add,
                        size: 30,
                        color: Colors.white54,
                      ),
                    ],
                  ),
                ),
              )),
        ),
        platformFiles == null || platformFiles?.count == 0
            ? const SizedBox()
            : Positioned(
                right: 10,
                top: 1,
                bottom: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: IconButton(
                    color: Colors.red[300],
                    iconSize: 24,
                    onPressed: _clearFiles,
                    icon: Icon(Boxicons.bx_trash, color: Colors.red[300]),
                  ),
                ),
              )
      ],
    );
  }

  _pickFiles() async {
    platformFiles = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'gif', 'mp4', 'mkv'],
    );
    if (platformFiles != null && platformFiles!.files.isNotEmpty) {
      setState(() {});
      debugPrint("=====FILES=====");
      debugPrint(platformFiles!.files.map((e) => e.name).toString());
      debugPrint("===============");
      widget.onChanged(platformFiles!.files);
    }
    return null;
  }

  _clearFiles() async {
    if (platformFiles == null) return;
    platformFiles!.files.clear();
    widget.onChanged(null);
    setState(() {});
  }
}
