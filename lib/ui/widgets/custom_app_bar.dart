import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9FAFB),
      surfaceTintColor: const Color(0xFFF9FAFB),
      leading: const Icon(Icons.menu),
      centerTitle: true,
      title: const Text(
        "DEMO APP",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Stack(
            children: [
              Icon(
                Icons.notifications_outlined,
                color: Color(
                  0xFF040415,
                ),
              ),
              Positioned(
                right: 0,
                child: Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 12,
                ),
              ),
            ],
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
