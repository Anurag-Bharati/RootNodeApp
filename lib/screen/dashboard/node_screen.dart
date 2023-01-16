import 'package:flutter/material.dart';

class NodeScreen extends StatefulWidget {
  const NodeScreen({super.key});

  @override
  State<NodeScreen> createState() => _NodeScreenState();
}

class _NodeScreenState extends State<NodeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Test",
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
