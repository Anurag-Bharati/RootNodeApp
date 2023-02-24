import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rootnode/model/user/user.dart';
import 'package:rootnode/provider/session_provider.dart';
import 'package:rootnode/widgets/live_messenger_stats.dart';
import 'package:rootnode/widgets/messenger_card.dart';

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
        children: const [
          RNLiveMessage(),
          MessengerCard(),
          SizedBox(height: 5),
          MessengerCard(),
          SizedBox(height: 5),
          MessengerCard(),
          SizedBox(height: 5),
          MessengerCard(),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
