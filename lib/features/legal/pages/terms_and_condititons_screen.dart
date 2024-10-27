import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/legal/bloc/terms_and_condititons_bloc/terms_and_condititons_bloc.dart';
import 'package:masaj/features/legal/models/terms_and_condititons_model.dart';

class TermsAndCondititonsScreen extends StatelessWidget {
  static const routeName = '/terms-conditions';

  const TermsAndCondititonsScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<TermsAndCondititonsBloc>(
      create: (context) => TermsAndCondititonsBloc(TermsAndCondititonsState(
        termsAndCondititonsModelObj: const TermsAndCondititonsModel(),
      )),
      child: const TermsAndCondititonsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TermsAndCondititonsBloc, TermsAndCondititonsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: HtmlWidget(
                  'terms_and_conditions_content'.tr(),
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
      title: 'msg_terms_conditions',
      centerTitle: true,
    );
  }
}
