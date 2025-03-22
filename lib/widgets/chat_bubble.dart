import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String prompt;
  const ChatBubble({super.key, required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).primaryColor.withOpacity(0.4),
      ),
      child: Text(
        prompt,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
