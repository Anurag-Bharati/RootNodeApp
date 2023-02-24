import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/provider/session_provider.dart';

class MessengerCard extends ConsumerWidget {
  const MessengerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootnode = ref.watch(sessionProvider.select((value) => value.user!));
    return Container(
      color: Colors.white10,
      child: Slidable(
        direction: Axis.horizontal,
        endActionPane: _endActionPane(),
        startActionPane: _startActionPane(),
        child: ListTile(
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.only(top: 5),
            constraints: const BoxConstraints(maxWidth: 100, maxHeight: 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red[300],
            ),
            child: Text("Busy", style: RootNodeFontStyle.caption),
          ),
          dense: true,
          contentPadding: const EdgeInsets.all(10),
          leading: CircleAvatar(
            foregroundColor: Colors.white10,
            backgroundColor: Colors.white10,
            foregroundImage: CachedNetworkImageProvider(
                "${ApiConstants.baseUrl}/${rootnode.avatar}"),
          ),
          title: Text(rootnode.fullname, style: RootNodeFontStyle.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Thats so awesome! Thanks for the help",
                  style: RootNodeFontStyle.subtitle),
              Text("Sun at 4:30PM", style: RootNodeFontStyle.labelSmall),
            ],
          ),
          enableFeedback: true,
        ),
      ),
    );
  }

  ActionPane _startActionPane() {
    return const ActionPane(
      extentRatio: 0.25,
      motion: ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: null,
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          icon: Icons.save,
          label: 'Save',
        ),
      ],
    );
  }

  ActionPane _endActionPane() {
    return const ActionPane(
      extentRatio: 0.25,
      motion: ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: null,
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          icon: Icons.save,
          label: 'Save',
        ),
      ],
    );
  }
}
