import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
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
          body: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: HtmlWidget(
                  'reschedule_policy_content'.tr(),
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
    return const CustomAppBar(
      title: 'msg_reschedule_policy',
      centerTitle: true,
    );
  }
}
