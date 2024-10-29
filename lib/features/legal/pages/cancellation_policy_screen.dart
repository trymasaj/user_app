import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
          body: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: HtmlWidget(
                  AppText.cancellation_policy_content,
                  textStyle: theme.textTheme.bodyMedium!.copyWith(
                    height: 1.57,
                  ),
                ),
              )),
        );
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppText.msg_cancellation_policy,
      centerTitle: true,
    );
  }
}
