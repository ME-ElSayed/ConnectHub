import 'package:connect_hub/core/utils/hide_nav_bar.dart';
import 'package:connect_hub/features/chat/presentation/views/chat_view.dart';
import 'package:connect_hub/features/feed/presentation/view/home_feed_view.dart';
import 'package:connect_hub/features/post/presentation/views/add_post_view.dart';
import 'package:connect_hub/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController _controller;
  late final HideNavbar hiding;
  @override
  void initState() {
    hiding = HideNavbar();
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        title: "post",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.chat),
        title: "chat",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: hiding.visible,
      builder: (context, value, child) => PersistentTabView(
        context,
        controller: _controller,
        isVisible: value,
        screens: [
          HomeFeedView(controller: hiding),
          const AddPostView(),
          const ChatView(),
          const ProfileView(),
        ],
        items: _navBarsItems(),

        navBarHeight: (value) ? 80.h : 0,
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),

        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(20.r),
          colorBehindNavBar: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 30,
              spreadRadius: 2,
              offset: const Offset(0, 12),
            ),

            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 60,
              spreadRadius: 5,
              offset: const Offset(0, 20),
            ),

            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: -2,
              offset: const Offset(0, -2),
            ),
          ],
        ),

        navBarStyle: NavBarStyle.style1,
      ),
    );
  }
}
