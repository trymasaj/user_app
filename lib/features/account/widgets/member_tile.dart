import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/members/data/model/member_model.dart';

class MemberTile extends StatelessWidget {
  const MemberTile(
      {super.key, required this.member, this.action, required this.index});

  final MemberModel member;
  final int index;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomImageView(
              imagePath: member.image,
              height: 50.adaptSize,
              width: 50.adaptSize,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(8.w)),
          SizedBox(width: 8.h),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(index == 0 ? 'lbl_me'.tr() : member.name ?? '',
                style: CustomTextStyles.titleMediumOnPrimary_1),
            SizedBox(height: 2.h),
            Text((member.countryCode ?? '') + (member.phone ?? ''),
                style: theme.textTheme.bodyMedium)
          ]),
          const Spacer(),
          action ?? const Icon(Icons.arrow_forward_ios)
        ]),
        SizedBox(height: 16.h),
        Divider(color: appTheme.gray300),
        SizedBox(height: 14.h),
      ],
    );
  }
}
