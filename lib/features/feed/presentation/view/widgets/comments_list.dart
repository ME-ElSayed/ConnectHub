import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/feed/presentation/cubits/comment_cubit.dart';
import 'package:connect_hub/features/feed/presentation/cubits/comment_state.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit,
        CommentState>(
      builder: (context, state) {
        if (state.isLoading &&
            state.comments.isEmpty) {
          return const Center(
            child:
                CircularProgressIndicator(),
          );
        }

        if (state.comments.isEmpty) {
          return Center(
            child: Text(
              'Be the first to comment.',
              style: AppStyles
                  .body14SecondaryRegular,
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.fromLTRB(
            16.w,
            12.h,
            16.w,
            16.h,
          ),
          itemCount: state.comments.length,
          separatorBuilder: (_, _) =>
              SizedBox(height: 14.h),
          itemBuilder: (_, index) {
            return CommentTile(
              comment:
                  state.comments[index],
            );
          },
        );
      },
    );
  }
}