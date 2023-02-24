import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rootnode/helper/socket_service.dart';
import 'package:rootnode/model/message/message.dart';

final messageServiceProvider = Provider.family((ref, String nodeId) {
  print("USER READY FOR MSG: $nodeId");
  final x = MessageService(
      nodeId: nodeId, socketService: ref.watch(socketServiceProvider));
  print("MsgProviderHash: ${x.hashCode}");
  return x;
});

class MessageService {
  final String nodeId;
  final SocketService socketService;
  final _messages = <Message>[];
  final StreamController<List<Message>> _messagesController =
      StreamController<List<Message>>.broadcast();
  bool _isTyping = false;
  Timer? _typingTimer;

  get initials => _messages;

  void isConnected() => print(socketService.socket.connected);

  MessageService({required this.nodeId, required this.socketService}) {
    socketService.connect();
    socketService.attachEvent('message', _handleIncomingMessage);
    socketService.attachEvent('typing', _handleIncomingTyping);
  }

  get recent => messages.last;

  void _handleIncomingTyping(data) {
    final userId = data['senderId'];
    final isTyping = data['isTyping'];
    if (userId != nodeId) {
      if (isTyping) {
        // ignore: avoid_print
        print('User $userId is typing');
      } else {
        // ignore: avoid_print
        print('User $userId stopped typing');
      }
    }
  }

  void startTyping() {
    if (!_isTyping) {
      _isTyping = true;
      socketService.socket.emit('typing', {'node': nodeId, 'isTyping': true});
    }
    _resetTypingTimer();
  }

  void stopTyping() {
    if (_isTyping) {
      _isTyping = false;
      socketService.socket.emit('typing', {'node': nodeId, 'isTyping': false});
    }
    _resetTypingTimer();
  }

  void _resetTypingTimer() {
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 5), () {
      stopTyping();
    });
  }

  Stream<List<Message>> get messages => _messagesController.stream;

  void _handleIncomingMessage(dynamic data) {
    print("Incoming:$data");
    final messages = Message.fromJson(data);
    _messages.add(messages);
    _messagesController.add(_messages);
  }

  void sendMessage(Message message) {
    print("Sending:$message");
    socketService.emitEvent('message:send', message.toJson());
    _messages.add(message);
    _messagesController.add(_messages);
  }

  void dispose() {
    socketService.socket.off('message');
    socketService.socket.off('typing');
    messages.drain();
    _messagesController.close();
    socketService.dispose();
  }

  void deactivate() {
    // _messagesController.pause();
  }
}
