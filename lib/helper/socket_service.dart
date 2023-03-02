// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rootnode/app/constant/api.dart';
import 'package:rootnode/provider/session_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as sc;

final socketServiceProvider = Provider<SocketService>((ref) {
  final rootnode = ref.watch(sessionProvider.select((value) => value.user!));
  return SocketService(
    socket: sc.io(
      ApiConstants.socket,
      sc.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'rootnode': rootnode.id})
          .disableAutoConnect()
          .build(),
    ),
  );
});

class SocketService {
  final sc.Socket socket;

  SocketService({required this.socket});

  void connect() {
    print("SocketStatus: ${socket.connected ? 'Connected!' : 'Connecting...'}");
    print("SocketHash: $hashCode");
    if (socket.connected) return;
    socket.connect();
    socket.onConnect((data) => print("SocketIO: connected"));
    socket.onConnectError((data) => throw data);
    socket.onConnecting((data) => print("SocketIO: connecting"));
  }

  void disconnect() => socket.disconnected ? null : socket.disconnect();

  void emitEvent(String event, Map<String, dynamic> object) =>
      socket.emit(event, object);

  void attachEvent(String event, Function(dynamic) e) => socket.on(event, e);

  bool get isConnected => socket.connected;

  void dispose() {
    socket.dispose();
  }
}
