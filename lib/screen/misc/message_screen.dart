import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/helper/switch_route.dart';
import 'package:rootnode/model/user/user.dart';
import 'package:rootnode/provider/session_provider.dart';
import 'package:rootnode/screen/misc/view_profile.dart';
import 'package:rootnode/widgets/message_bar.dart';
import 'package:rootnode/widgets/message_card.dart';

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({super.key});

  @override
  ConsumerState<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  late final User user;

  @override
  void initState() {
    user = ref.read(sessionProvider.select((value) => value.user!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 60,
          title: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () =>
                    switchRouteByPush(context, ProfileScreen(id: user.id!)),
                child: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.all(3),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                    shape: BoxShape.circle,
                  ),
                  child: FadeInImage.assetNetwork(
                    imageCacheHeight: 256,
                    imageCacheWidth: 256,
                    fit: BoxFit.cover,
                    image: "${ApiConstants.baseUrl}/${user.avatar}",
                    placeholder: 'assets/images/image_grey.png',
                  ),
                ),
              ),
              const SizedBox(width: 10 - 3),
              Expanded(
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: -5,
                  children: [
                    Text(user.fullname, style: RootNodeFontStyle.title),
                    Text('@${user.username}', style: RootNodeFontStyle.label),
                  ],
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          actions: _getActions()),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
              // This will be listview
              child: ShaderMask(
                blendMode: BlendMode.dstOut,
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF111111), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.02, 0.2],
                ).createShader(bounds),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MessageCard(
                          date: DateTime.now(), message: "Test message"),
                      MessageCard(
                        date: DateTime.now(),
                        message:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BottomMessageBar(onSuccess: () {}, id: "")
          ],
        ),
      ),
    );
  }

  List<Widget> _getActions() => [
        IconButton(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          highlightColor: Colors.white10,
          onPressed: () {},
          icon: const Icon(
            Boxicons.bxs_phone,
            color: Colors.white70,
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          highlightColor: Colors.white10,
          onPressed: () {},
          icon: const Icon(
            Boxicons.bx_dots_vertical_rounded,
            color: Colors.white70,
          ),
        ),
        const SizedBox(width: 5),
      ];
}
