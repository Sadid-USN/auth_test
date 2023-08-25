import 'package:auth_test/controller/auth_controller.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurvedNavnBar extends StatelessWidget {
  const CurvedNavnBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, controller, child) => CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 250),
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        index: controller.selectedIndex,
        backgroundColor: Colors.white,
        items: controller.navItems,
        onTap: (index) {
          controller.onTapBar(index);
        },
      ),
    );
  }
}
