import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/warning_container.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  static const String routeName = '/checkoutScreen';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const double _kDividerThickness = 2;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'checkout_title'.tr(),
        ),
        body: _buildBody(),
      );
    });
  }

  CustomAppPage _buildBody() {
    return CustomAppPage(
      child: Column(
        children: [
          _buildServiceTitle(),
          const WarningContainer(title: 'checkout_warning'),
          const Divider(thickness: _kDividerThickness),
          _buildDetailsSection(),
          const Divider(thickness: _kDividerThickness),
          _buildTherapistSection(),
          const Divider(thickness: _kDividerThickness),
          _buildLocationSection(),
          const Divider(thickness: _kDividerThickness),
          const TitleText(text: 'payment_method'),
          Row(
            children: [
              const SubtitleText(text: 'use_wallet ${200} dummy'),
              const Spacer(),
              CustomSwitch(onChange: (value) {}),
            ],
          ),
          ListView.builder(itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.PRIMARY_COLOR.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.PRIMARY_COLOR,
                ),
              ),
              child: Row(children: [
                const SubtitleText(text: 'payment'),
                const Spacer(),
                Radio.adaptive(
                    value: (value) {}, groupValue: false, onChanged: (value) {})
              ]),
            );
          })
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(text: 'details'),
        _buildDetailsRow(title: 'date', content: 'date_dummy'),
        _buildDetailsRow(title: 'date', content: 'date_dummy'),
        _buildDetailsRow(title: 'date', content: 'date_dummy'),
        _buildDetailsRow(title: 'date', content: 'date_dummy'),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(text: 'location'),
        const TitleText(
          text: 'home_dummy',
          subtractedSize: 2,
        ),
        _buildDetailsRow(title: 'date', content: 'date_dummy'),
      ],
    );
  }

  Widget _buildDetailsRow({required String title, required String content}) {
    return Row(
      children: [
        SubtitleText(text: title),
        const SizedBox(width: 36),
        SubtitleText(text: content)
      ],
    );
  }

  Widget _buildServiceTitle() {
    return Row(
      children: [
        CustomCachedNetworkImage(
          imageUrl: '',
          borderRadius: BorderRadius.circular(20),
        ),
        const Column(
          children: [
            SubtitleText(text: ''),
            SizedBox(height: 20),
            SubtitleText(text: ''),
          ],
        )
      ],
    );
  }

  Widget _buildTherapistSection() {
    return Row(
      children: [
        CustomCachedNetworkImage(
          imageUrl: '',
          borderRadius: BorderRadius.circular(20),
        ),
        const Column(
          children: [
            SubtitleText(text: ''),
            SizedBox(height: 20),
            SubtitleText(text: ''),
          ],
        )
      ],
    );
  }
}
