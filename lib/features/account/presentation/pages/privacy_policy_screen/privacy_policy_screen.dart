import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';

import 'bloc/privacy_policy_bloc.dart';
import 'models/privacy_policy_model.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const routeName = '/privacy_policy';

  const PrivacyPolicyScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<PrivacyPolicyBloc>(
      create: (context) => PrivacyPolicyBloc(PrivacyPolicyState(
        privacyPolicyModelObj: PrivacyPolicyModel(),
      ))
        ..add(PrivacyPolicyInitialEvent()),
      child: PrivacyPolicyScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 26.w, 24.h),

            child: Column(
              children: [
                Text(
                  "msg_it_is_a_long_established".tr(),
                  maxLines: 14,
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "lbl_privacy_policy".tr(),
      ),
    );
  }
}
