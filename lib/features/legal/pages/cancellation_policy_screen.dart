import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/legal/bloc/cancellation_policy_bloc/cancellation_policy_bloc.dart';
import 'package:masaj/features/legal/models/cancellation_policy_model.dart';

class CancellationPolicyScreen extends StatelessWidget {
  static const routeName = '/cancelation-policy';

  const CancellationPolicyScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<CancellationPolicyBloc>(
      create: (context) => CancellationPolicyBloc(CancellationPolicyState(
        cancellationPolicyModelObj: const CancellationPolicyModel(),
      )),
      child: const CancellationPolicyScreen(),
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
                  'msg_cancellation_refund'.tr(),
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
    return CustomAppBar(
      title: 'msg_cancellation_policy'.tr(),
      centerTitle: true,
    );
  }
}
