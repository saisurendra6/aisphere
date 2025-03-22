import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name, email, picUrl;
  const UserCard({
    super.key,
    required this.name,
    required this.email,
    required this.picUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              child: Icon(
                Icons.person_rounded,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  email,
                  style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.black45, size: 18),
          ],
        ),
      ),
    );
  }
}
