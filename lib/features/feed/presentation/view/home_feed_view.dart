import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/core/utils/hide_nav_bar.dart';
import 'package:connect_hub/core/widgets/hide_naviagtion.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_app_bar.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_posts_sliver.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';
import 'package:flutter/material.dart';

class HomeFeedView extends StatelessWidget {
  HomeFeedView({
    super.key,
    required this.controller,
  });

  final HideNavbar controller;

  static final FirestoreService _firestore =
      getIt<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HideNavigation(
        hidecontroller: controller,
        child: StreamBuilder<List<PostModel>>(
          stream: _firestore.watchPosts(),
          builder: (context, snapshot) {
            return CustomScrollView(
              slivers: [
                const FeedAppBar(),
                FeedPostsSliver(snapshot: snapshot),
              ],
            );
          },
        ),
      ),
    );
  }
}