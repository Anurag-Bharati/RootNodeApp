import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rootnode/helper/switch_route.dart';
import 'package:rootnode/model/user/user.dart';
import 'package:rootnode/provider/session_provider.dart';
import 'package:rootnode/screen/misc/message_screen.dart';

class MessengerScreen extends ConsumerStatefulWidget {
  const MessengerScreen({super.key});

  @override
  ConsumerState<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends ConsumerState<MessengerScreen> {
  late final User user;

  @override
  void initState() {
    user = ref.read(sessionProvider.select((value) => value.user!));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () =>
                  switchRouteByPush(context, const MessageScreen()),
              child: const Text("Message"))
        ],
      ),
    );
  }
}
