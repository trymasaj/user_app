import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
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
          body: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: HtmlWidget(
                  AppText.privacy_policy_content,
                  textStyle: theme.textTheme.bodyMedium!.copyWith(
                    height: 1.57,
                  ),
                ),
              )),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppText.lbl_privacy_policy,
      centerTitle: true,
    );
  }
}
