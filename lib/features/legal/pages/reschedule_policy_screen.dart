import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/legal/bloc/reschedule_policy_bloc/reschedule_policy_bloc.dart';
import 'package:masaj/features/legal/models/reschedule_policy_model.dart';

class ReschedulePolicyScreen extends StatelessWidget {
  static const routeName = '/reschedule-policy';

  const ReschedulePolicyScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<ReschedulePolicyBloc>(
      create: (context) => ReschedulePolicyBloc(ReschedulePolicyState(
        reschedulePolicyModelObj: const ReschedulePolicyModel(),
      )),
      child: const ReschedulePolicyScreen(),
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
                  'msg_user_cannot_reschedule'.tr(),
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
        'msg_reschedule_policy'.tr(),
      ),
    );
  }
}
