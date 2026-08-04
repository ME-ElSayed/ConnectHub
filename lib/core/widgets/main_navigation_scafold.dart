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

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const HomeFeedView(),
      const AddPostView(),
      const ChatView(),
      const ProfileView(),
    ];
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
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),

      navBarHeight: 80.h,
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
    );
  }
}
