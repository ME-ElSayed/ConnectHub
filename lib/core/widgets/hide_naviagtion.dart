import 'package:connect_hub/core/utils/hide_nav_bar.dart';
import 'package:flutter/material.dart';

class HideNavigation extends StatelessWidget {
  final HideNavbar hidecontroller;
  final Widget child;
  const HideNavigation({super.key, required this.hidecontroller, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (n) {
          hidecontroller.onScroll(n.direction);
          return false;
        },
        child: child,
      ),
    );
  }
}
