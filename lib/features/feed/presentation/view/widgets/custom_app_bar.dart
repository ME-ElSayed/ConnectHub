import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/auth/presentation/widgets/auth_logo.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        children: [
          AuthLogo(size: 60.r),
          SizedBox(width: 12.w),
          Text('ConnectHub', style: AppStyles.title20SemiBold),
          const Spacer(),
          ProfilePic(
            size: 50.r,
            imageUrl:
                'https://i.ibb.co/SXrF9sL1/image-cropper-1785691682814.jpg',
          ),
        ],
      ),
    );
  }
}
