import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/helper/utils.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message, required this.date});
  final String message;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            maxRadius: 16,
            foregroundColor: Colors.white10,
            backgroundColor: Colors.white10,
          ),
          const SizedBox(width: 10),
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white10,
            ),
            child: Text(
              message,
              style: RootNodeFontStyle.caption,
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 64),
            margin: const EdgeInsets.only(left: 5),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Text(
              Utils.getTimeAgo(date),
              style: RootNodeFontStyle.labelSmall,
            ),
          )
        ],
      ),
    );
  }
}
