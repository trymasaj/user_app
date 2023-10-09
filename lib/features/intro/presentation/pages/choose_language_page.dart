import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/shared_widgets/stateless/custom_text.dart';
import '../../../../di/injector.dart';
import '../../../../shared_widgets/stateless/custom_radio_list_tile.dart';
import '../blocs/choose_language_cubit/choose_language_cubit.dart';
import 'guide_page.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/stateless/custom_app_page.dart';

class ChooseLanguagePage extends StatefulWidget {
  static const routeName = '/ChooseLanguagePage';

  const ChooseLanguagePage({Key? key}) : super(key: key);

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
              if (state.isError)
                showSnackBar(context, message: state.errorMessage);
              else if (state.isLanguageSet) _goToGuidePage(context);
            },
            child: Scaffold(body: _buildBody(context)),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 80,
            width: double.infinity,
          ),
          const CustomText(
            text: 'choose_app_language',
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            margin: EdgeInsets.only(bottom: 4.0),
          ),
          const CustomText(
            text: 'choose_app_language_subtitle',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: AppColors.FONT_LIGHT_COLOR,
            margin: EdgeInsets.only(bottom: 20.0),
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
      label: 'continue'.tr(),
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
