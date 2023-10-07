import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/injector.dart';
import '../blocs/choose_language_cubit/choose_language_cubit.dart';
import 'guide_page.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:size_helper/size_helper.dart';

import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

class ChooseLanguagePage extends StatefulWidget {
  static const routeName = '/ChooseLanguagePage';

  const ChooseLanguagePage({Key? key}) : super(key: key);

  @override
  State<ChooseLanguagePage> createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {
  Locale? _selectedLocal = Locale('en');
  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      safeBottom: false,
      withBackground: true,
      backgroundPath: 'lib/res/assets/choose_language_background.svg',
      backgroundFit: BoxFit.fitWidth,
      backgroundAlignment: Alignment.topCenter,
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
    final currentLocale = context.locale;
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final cubit = context.read<ChooseLanguageCubit>();

    return Column(
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
            width: screenWidth * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 7),
                const TitleText.extraLarge(
                  text: 'choose_your_language',
                  textAlign: TextAlign.start,
                ),
                const Spacer(flex: 2),
                _buildCustomRadioListTile(
                  label: const Text('arabic'),
                  value: const Locale('ar'),
                  groupValue: _selectedLocal,
                  onTap: () =>
                      setState(() => _selectedLocal = const Locale('ar')),
                ),
                _buildCustomRadioListTile(
                  label: const Text('english'),
                  value: const Locale('en'),
                  groupValue: _selectedLocal,
                  onTap: () =>
                      setState(() => _selectedLocal = const Locale('en')),
                ),
                _buildLanguageButton(
                  context,
                  label: 'English',
                  locale: const Locale('en'),
                  isSelected: currentLocale == const Locale('en'),
                  onSelected: context.setLocale,
                ),
                const Spacer(),
                _buildLanguageButton(
                  context,
                  label: 'عربي',
                  locale: const Locale('ar'),
                  isSelected: currentLocale == const Locale('ar'),
                  onSelected: context.setLocale,
                ),
                const Spacer(flex: 5),
              ],
            ),
          ),
        ),
        _buildLowerSection(context),
      ],
    );
  }

  Widget _buildLowerSection(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.PRIMARY_COLOR,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        // Column used in purpose to center the button
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildNextButton(context)],
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final cubit = context.read<ChooseLanguageCubit>();
    final currentLanguageCode = context.locale.languageCode;
    final textStyle = Theme.of(context).textTheme.headline1!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 18.0,
            tabletLarge: 21.0,
            desktopSmall: 24.0,
          ),
        );
    return DefaultButton(
      label: 'next'.tr(),
      labelStyle: textStyle,
      backgroundColor: Colors.transparent,
      icon: const Icon(Icons.arrow_forward, size: 24.0),
      iconLocation: DefaultButtonIconLocation.End,
      borderColor: Colors.white,
      borderWidth: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      onPressed: () => cubit.setLanguageCode(currentLanguageCode),
      isExpanded: true,
    );
  }

  Future<void> _goToGuidePage(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(GuidePage.routeName);

  Widget _buildLanguageButton(
    BuildContext context, {
    required Locale locale,
    required String label,
    required bool isSelected,
    required ValueChanged<Locale> onSelected,
  }) {
    final textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 18.0,
            tabletLarge: 21.0,
            desktopSmall: 24.0,
          ),
        );
    return DefaultButton(
      borderColor: isSelected ? Colors.white : const Color(0xAAAAAAAA),
      contentAlignment: MainAxisAlignment.start,
      backgroundColor: Colors.transparent,
      isExpanded: true,
      borderWidth: 2.0,
      label: label,
      labelStyle: textStyle.copyWith(
        color: isSelected ? Colors.white : const Color(0xAAAAAAAA),
      ),
      onPressed: () => onSelected(locale),
    );
  }

  Widget _buildCustomRadioListTile<T>({
    required Widget label,
    required T value,
    required T groupValue,
    required VoidCallback onTap,
  }) {
    assert(value.runtimeType == groupValue.runtimeType,
        'value and groupValue must be of the same type');
    final isSelected = value == groupValue;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.transparent,
          ),
          color: isSelected
              ? Colors.orange.withOpacity(0.2)
              : Colors.grey.withOpacity(0.3),
        ),
        child: ListTile(
          title: label,
          trailing: _customRadioButton(isSelected: isSelected),
        ),
      ),
    );
  }

  Widget _customRadioButton({required bool isSelected}) {
    return CircleAvatar(
      backgroundColor: isSelected ? Colors.orange : Colors.grey,
      radius: 8.0,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: isSelected ? 4.0 : 7.0,
      ),
    );
  }
}

class CustomRadioListTile<T> extends StatelessWidget {
  final Widget label;
  final T value;
  final T groupValue;
  final ValueChanged<T> onValueSelected;

  const CustomRadioListTile({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onValueSelected(value), // Calling the callback with value
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.transparent,
          ),
          color: isSelected
              ? Colors.orange.withOpacity(0.2)
              : Colors.grey.withOpacity(0.3),
        ),
        child: ListTile(
          title: label,
          trailing: _buildTrailingIndicator(isSelected: isSelected),
        ),
      ),
    );
  }

  Widget _buildTrailingIndicator({required bool isSelected}) {
    return CircleAvatar(
      backgroundColor: isSelected ? Colors.orange : Colors.grey,
      radius: 8.0,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: isSelected ? 4.0 : 7.0,
      ),
    );
  }
}
