import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.blueGrey,
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
