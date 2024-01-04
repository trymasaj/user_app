import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle_four.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';
import 'package:masaj/features/settings_tab/presentation/pages/manage_members_screen/models/member.dart';

import 'bloc/manage_members_bloc.dart';
import 'models/manage_members_model.dart';

class MemberTile extends StatelessWidget {
  const MemberTile({
    super.key, required this.member,
  });
  final Member member;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomImageView(
              imagePath: member.image,
              height: 50.adaptSize,
              width: 50.adaptSize,
              radius: BorderRadius.circular(8.w)),
          SizedBox(width: 8.h),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(member.name, style: CustomTextStyles.titleMediumOnPrimary_1),
            SizedBox(height: 2.h),
            Text(member.phone, style: theme.textTheme.bodyMedium)
          ]),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRightOnprimary,
              height: 18.adaptSize,
              width: 18.adaptSize,
              radius: BorderRadius.circular(9.w),
              margin: EdgeInsets.symmetric(vertical: 16.h))
        ]),
        SizedBox(height: 16.h),
        Divider(color: appTheme.gray300),
        SizedBox(height: 14.h),
      ],
    );
  }
}
