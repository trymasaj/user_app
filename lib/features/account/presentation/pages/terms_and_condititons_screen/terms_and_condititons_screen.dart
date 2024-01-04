import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';

import 'bloc/terms_and_condititons_bloc.dart';
import 'models/terms_and_condititons_model.dart';
import 'package:flutter/material.dart';

class TermsAndCondititonsScreen extends StatelessWidget {
  static const routeName = '/terms-conditions';

  const TermsAndCondititonsScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<TermsAndCondititonsBloc>(
      create: (context) => TermsAndCondititonsBloc(TermsAndCondititonsState(
        termsAndCondititonsModelObj: TermsAndCondititonsModel(),
      ))
        ..add(TermsAndCondititonsInitialEvent()),
      child: TermsAndCondititonsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TermsAndCondititonsBloc, TermsAndCondititonsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 26.w, 24.h),
            child: Column(
              children: [
                Text(
                  "msg_it_is_a_long_established2".tr(),
                  maxLines: 17,
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
        "msg_terms_conditions".tr(),
      ),
    );
  }
}
