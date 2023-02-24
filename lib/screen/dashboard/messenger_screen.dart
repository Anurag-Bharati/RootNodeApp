import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rootnode/helper/message_service.dart';
import 'package:rootnode/helper/switch_route.dart';
import 'package:rootnode/model/user/user.dart';
import 'package:rootnode/provider/session_provider.dart';
import 'package:rootnode/screen/misc/message_screen.dart';
import 'package:rootnode/widgets/live_messenger_stats.dart';
import 'package:rootnode/widgets/messenger_card.dart';

class MessengerScreen extends ConsumerStatefulWidget {
  const MessengerScreen({super.key});

  @override
  ConsumerState<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends ConsumerState<MessengerScreen> {
  late final User user;
  late final MessageService x;

  @override
  void initState() {
    user = ref.read(sessionProvider.select((value) => value.user!));
    x = ref.read(messageServiceProvider("123"));
    super.initState();
  }

  @override
  void dispose() {
    x.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const RNLiveMessage(),
          const MessengerCard(),
          const SizedBox(height: 5),
          const MessengerCard(),
          const SizedBox(height: 5),
          const MessengerCard(),
          const SizedBox(height: 5),
          const MessengerCard(),
          const SizedBox(height: 5),
          ElevatedButton(
              onPressed: () =>
                  switchRouteByPush(context, const MessageScreen()),
              child: null)
        ],
      ),
    );
  }
}
