import 'package:flutter/material.dart';

class ReplyBubble extends StatelessWidget {
  final String response;
  const ReplyBubble({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        response,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
