import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';

import 'bloc/reschedule_policy_bloc.dart';
import 'models/reschedule_policy_model.dart';
import 'package:flutter/material.dart';

class ReschedulePolicyScreen extends StatelessWidget {
  static const routeName = '/reschedule-policy';

  const ReschedulePolicyScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<ReschedulePolicyBloc>(
      create: (context) => ReschedulePolicyBloc(ReschedulePolicyState(
        reschedulePolicyModelObj: ReschedulePolicyModel(),
      ))
        ..add(ReschedulePolicyInitialEvent()),
      child: ReschedulePolicyScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReschedulePolicyBloc, ReschedulePolicyState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(31.w, 24.h, 36.w, 24.h),
            child: Column(
              children: [
                Text(
                  "msg_user_cannot_reschedule".tr(),
                  maxLines: 11,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    height: 1.57,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "msg_reschedule_policy".tr(),
      ),
    );
    return CustomAppBar(
      centerTitle: true,
      title: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 106.w,
            ),
            child: Row(
              children: [
                AppbarTitleIconbutton(
                  imagePath: ImageConstant.imgGroup1000002973,
                ),
                AppbarSubtitle(
                  text: "msg_reschedule_policy".tr(),
                  margin: EdgeInsets.only(
                    left: 16.w,
                    top: 8.h,
                    bottom: 5.h,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: double.maxFinite,
              child: Divider(),
            ),
          ),
        ],
      ),
      styleType: Style.bgFill,
    );
  }
}
