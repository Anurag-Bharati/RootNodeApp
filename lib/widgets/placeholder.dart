import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/font.dart';

class MediaError extends StatelessWidget {
  const MediaError({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        color: const Color(0x47E57373),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                Icon(icon, size: 30, color: Colors.red[300]),
                Text("Something went wrong!", style: RootNodeFontStyle.body),
              ]),
        ),
      ),
    );
  }
}

class MediaLoading extends StatelessWidget {
  const MediaLoading({
    super.key,
    required this.label,
    required this.icon,
    required this.progress,
  });
  final String label;
  final IconData icon;
  final DownloadProgress? progress;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      children: [
        Icon(icon, size: 30, color: Colors.white54),
        Text(label, style: RootNodeFontStyle.body),
        SizedBox(
            width: 120,
            height: 6,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white10,
              color: Colors.white54,
              value: progress != null ? progress!.progress : null,
              // strokeWidth: 5,
            )),
      ],
    ));
  }
}
