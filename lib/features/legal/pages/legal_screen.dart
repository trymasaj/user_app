import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/utils/navigator_helper.dart';
import 'package:masaj/core/widgets/border_tile.dart';
import 'package:masaj/features/legal/pages/privacy_policy_screen.dart';
import 'package:masaj/features/legal/pages/terms_and_condititons_screen.dart';
import 'package:masaj/features/legal/pages/cancellation_policy_screen.dart';
import 'package:masaj/features/legal/pages/reschedule_policy_screen.dart';

import '../bloc/legal_bloc/legal_bloc.dart';
import '../models/legal_model.dart';
import 'package:flutter/material.dart';

class LegalScreen extends StatelessWidget {
  static const routeName = '/legal';

  const LegalScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<LegalBloc>(
        create: (context) => LegalBloc(LegalState(legalModelObj: LegalModel()))
          ,
        child: LegalScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegalBloc, LegalState>(builder: (context, state) {
      return Scaffold(
          appBar: _buildAppBar(context),
          body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.only(right: 7.w),
                    child: _buildLegalTile(
                        image: ImageConstant.imgGroup1000003173,
                        text: "lbl_privacy_policy".tr(),
                        onTap: () {
                          NavigatorHelper.of(context)
                              .pushNamed(PrivacyPolicyScreen.routeName);
                        })),
                SizedBox(height: 15.h),
                Padding(
                    padding: EdgeInsets.only(right: 7.w),
                    child: _buildLegalTile(
                        image: ImageConstant.imgGroup1000003174,
                        text: "msg_terms_conditions2".tr(),
                        onTap: () {
                          NavigatorHelper.of(context)
                              .pushNamed(TermsAndCondititonsScreen.routeName);
                        })),
                SizedBox(height: 15.h),
                Padding(
                    padding: EdgeInsets.only(right: 7.w),
                    child: _buildLegalTile(
                        image: ImageConstant.imgGroup1000003173,
                        text: "msg_cancellation_policy".tr(),
                        onTap: () {
                          NavigatorHelper.of(context)
                              .pushNamed(CancellationPolicyScreen.routeName);
                        })),
                SizedBox(height: 15.h),
                Padding(
                    padding: EdgeInsets.only(right: 7.w),
                    child: _buildLegalTile(
                        image: ImageConstant.imgGroup1000003176,
                        text: "msg_reschedule_policy".tr(),
                        onTap: () {
                          NavigatorHelper.of(context)
                              .pushNamed(ReschedulePolicyScreen.routeName);
                        })),
                SizedBox(height: 4.h)
              ])));
    });
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("lbl_legal".tr()),
    );
  }

  /// Common widget
  Widget _buildLegalTile({
    required String image,
    required String text,
    required VoidCallback onTap,
  }) {
    return BorderTile(
      image: image,
      text: text,
      onTap: onTap,
    );
  }
}
