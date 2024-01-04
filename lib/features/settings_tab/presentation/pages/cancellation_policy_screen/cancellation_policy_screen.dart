import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';

import 'bloc/cancellation_policy_bloc.dart';
import 'models/cancellation_policy_model.dart';
import 'package:flutter/material.dart';

class CancellationPolicyScreen extends StatelessWidget {
  static const routeName = '/cancelation-policy';

  const CancellationPolicyScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<CancellationPolicyBloc>(
      create: (context) => CancellationPolicyBloc(CancellationPolicyState(
        cancellationPolicyModelObj: CancellationPolicyModel(),
      ))
        ..add(CancellationPolicyInitialEvent()),
      child: CancellationPolicyScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CancellationPolicyBloc, CancellationPolicyState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(31.w, 24.h, 25.w, 24.h),

            child: Column(
              children: [
                Text(
                  "msg_cancellation_refund".tr(),
                  maxLines: 16,
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
      "msg_cancellation_policy".tr(),
    ));
  }
}
