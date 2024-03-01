import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/features/address/application/blocs/my_addresses_bloc/my_addresses_cubit.dart';
import 'package:masaj/features/address/presentation/overlay/select_location_bottom_sheet.dart';
import 'package:masaj/features/address/presentation/pages/select_location_screen.dart';
import 'package:masaj/features/address/presentation/pages/update_address_screen.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/application/country_cubit/country_cubit.dart';
import 'package:masaj/features/auth/application/country_cubit/country_state.dart';
import 'package:masaj/gen/assets.gen.dart';

class FixedAppBar extends StatelessWidget {
  const FixedAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isGuest = context.read<AuthCubit>().state.isGuest;
    final topPadding = MediaQuery.of(context).padding.top * 1.5;
    return SliverPersistentHeader(
      floating: true,
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: topPadding + 60,
        maxHeight: topPadding + 60,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: topPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CustomText(
                        text: 'location',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(24, 27, 40, .7),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.images.imgFluentLocation48Filled,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          isGuest
                              ? _buildLocationForGuest(context)
                              : _buildLocationForUser(context),
                          const SizedBox(
                            width: 5,
                          ),
                          SvgPicture.asset(
                            Assets.images.imgArrowDown,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // circle shape
                          shape: BoxShape.circle,
                          // border color
                          border: Border.all(
                            color: AppColors.GREY_LIGHT_COLOR_2,
                            width: 1,
                          ),
                        ),
                        child: SvgPicture.asset(
                          Assets.images.fluentPeopleCommunity20Regular,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // circle shape
                          shape: BoxShape.circle,
                          // border color
                          border: Border.all(
                            color: AppColors.GREY_LIGHT_COLOR_2,
                            width: 1,
                          ),
                        ),
                        child: SvgPicture.asset(
                          Assets.images.bell,
                          color: AppColors.ACCENT_COLOR,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationForGuest(BuildContext context) {
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        if (!state.isLoaded) {
          return Text(
            'no_address_selected'.tr(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.FONT_COLOR,
            ),
          );
        }

        final currentCountry = state.currentCountry;
        return GestureDetector(
          onTap: () => _goToSelectLocationPage(context),
          child: Row(
            children: [
              Text(
                currentCountry?.nameEn ?? 'no_address_selected'.tr(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.FONT_COLOR,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (currentCountry?.flagIcon != null)
                Image.network(
                  currentCountry!.flagIcon!,
                  width: 12,
                  height: 12,
                ),
            ],
          ),
        );
      },
    );
  }

  void _goToSelectLocationPage(BuildContext context) =>
      NavigatorHelper.of(context).push(
        MaterialPageRoute(
            builder: (context) => const SelectLocationScreen(
                  isFromHomePage: true,
                )),
      );

  Widget _buildLocationForUser(BuildContext context) {
    return BlocConsumer<CountryCubit, CountryState>(
      listener: (context, state) async {
        final cubit = context.read<CountryCubit>();
        if (state.isPrimaryAddressLoaded) {
          final currentAddress = state.currentAddress;
          if (currentAddress == null) {
            await NavigatorHelper.of(context).pushNamed(
              AddAddressScreen.routeName,
            );
            await cubit.getAllAddressesAndSavePrimaryAddressLocally();
          }
        }
      },
      builder: (context, state) {
        final currentAddress = state.currentAddress;
        if (state.currentAddress == null) {
          return Text(
            'no_address_selected'.tr(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.FONT_COLOR,
            ),
          );
        }

        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              elevation: 4,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              builder: (subContext) => SelectLocationBottomSheet(
                onSave: () async {
                  final myAddressCubit = context.read<MyAddressesCubit>();
                  final countryCubit = context.read<CountryCubit>();
                  await myAddressCubit.saveAddress();
                  await countryCubit
                      .getAllAddressesAndSavePrimaryAddressLocally();
                  Navigator.of(context).pop();
                },
              ),
            );
          },
          child: SizedBox(
            width: 150,
            child: Text(
              currentAddress!.formattedAddress ?? 'no_address_selected'.tr(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.FONT_COLOR),
            ),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
