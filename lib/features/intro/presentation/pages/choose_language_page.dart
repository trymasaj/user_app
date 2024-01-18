import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_radio_list_tile.dart';
import 'package:masaj/features/intro/presentation/blocs/choose_language_cubit/choose_language_cubit.dart';
import 'package:masaj/features/intro/presentation/pages/guide_page.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/shared_widgets/stateless/custom_text.dart';
import '../../../../core/di/injector.dart';
import '../../../../shared_widgets/stateless/custom_radio_list_tile.dart';
import '../blocs/choose_language_cubit/choose_language_cubit.dart';
import 'guide_page.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';

class ChooseLanguagePage extends StatefulWidget {
  static const routeName = '/ChooseLanguagePage';

  const ChooseLanguagePage({super.key});

  @override
  State<ChooseLanguagePage> createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {
  Locale _selectedLocal = const Locale('en');
  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      safeBottom: false,
      child: BlocProvider(
        create: (context) => Injector().chooseLanguageCubit,
        child: Builder(
          builder: (context) =>
              BlocListener<ChooseLanguageCubit, ChooseLanguageState>(
            listener: (context, state) {
              if (state.isError) {
                showSnackBar(context, message: state.errorMessage);
              } else if (state.isLanguageSet) _goToGuidePage(context);
            },
            child: Scaffold(
                appBar: AppBar(
                  title: Text('lbl_language'.tr()),
                ),
                body: _buildBody(context)),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.w),
            child: CustomText(
              text: 'msg_choose_you_preferred',
              fontSize: 18.0.fSize,
              fontWeight: FontWeight.w500,
              margin: const EdgeInsets.only(bottom: 4.0),
            ),
          ),
          CustomRadioListTile(
            label: const CustomText(
              text: 'arabic',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            value: const Locale('ar'),
            groupValue: _selectedLocal,
            onValueSelected: (value) =>
                setState(() => _selectedLocal = const Locale('ar')),
          ),
          const SizedBox(height: 14.0),
          CustomRadioListTile(
            label: const CustomText(
              text: 'english',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            value: const Locale('en'),
            groupValue: _selectedLocal,
            onValueSelected: (value) =>
                setState(() => _selectedLocal = const Locale('en')),
          ),
          const SizedBox(height: 24.0),
          _buildNextButton(context),
        ],
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final cubit = context.read<ChooseLanguageCubit>();

    return DefaultButton(
      label: 'lbl_save'.tr(),
      onPressed: () {
        context.setLocale(_selectedLocal);
        return cubit.saveLanguageCode(_selectedLocal.languageCode);
      },
      isExpanded: true,
    );
  }

  Future<void> _goToGuidePage(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(GuidePage.routeName);
}
