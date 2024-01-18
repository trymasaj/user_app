import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/legal/bloc/privacy_policy_bloc/privacy_policy_bloc.dart';
import 'package:masaj/features/legal/bloc/privacy_policy_bloc/privacy_policy_state.dart';
import 'package:masaj/features/legal/models/privacy_policy_model.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const routeName = '/privacy_policy';

  const PrivacyPolicyScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<PrivacyPolicyBloc>(
      create: (context) => PrivacyPolicyBloc(PrivacyPolicyState(
        privacyPolicyModelObj: const PrivacyPolicyModel(),
      )),
      child: const PrivacyPolicyScreen(),
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
                  'msg_it_is_a_long_established'.tr(),
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
        'lbl_privacy_policy'.tr(),
      ),
    );
  }
}
