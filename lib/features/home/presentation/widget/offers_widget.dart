import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/features/home/presentation/pages/home_tab.dart';
import 'package:masaj/features/services/data/models/service_offer.dart';
import 'package:masaj/features/services/presentation/screens/serice_details_screen.dart';
import 'package:masaj/gen/assets.gen.dart';

class OffersSection extends StatefulWidget {
  const OffersSection({
    super.key,
    required this.offers,
  });
  final List<ServiceOffer> offers;

  @override
  State<OffersSection> createState() => _OffersSectionState();
}

class _OffersSectionState extends State<OffersSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SectionTitle(title: AppText.enjoy_offers),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 190,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemCount: widget.offers.length,
              itemBuilder: (context, index) {
                final offer = widget.offers[index];
                double originalPrice = offer.originalPrice ?? 0.0;
                double discountPrice = offer.discountedPrice ?? 0.0;
                final discountPercentage =
                    ((originalPrice - discountPrice) / originalPrice) * 100;

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ServiceDetailsScreen.routeName,
                      arguments: ServiceDetailsScreenArguments(
                        id: offer.serviceId,
                        durationId: offer.serviceDurationId,
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 280,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.GREY_LIGHT_COLOR_2,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image with discount
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.GREY_LIGHT_COLOR_2,
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: CustomCachedNetworkImageProvider(
                                      widget.offers[index].mainImage ?? '',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Color(0xffB73E53),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    AppText.percentage_off(args: [
                                      '${discountPercentage.toStringAsFixed(0)}'
                                    ]),
                                    // '${discountPercentage}% OFF',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        // title
                        Text(
                          offer.title ?? '',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.FONT_COLOR),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        // row of start from and price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // start from
                            Text(
                              AppText.start_from,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.PlaceholderColor),
                            ),
                            // price before discount

                            // price
                            Row(
                              children: [
                                Text(
                                  AppText.price_in_kd(
                                      args: ['${offer.originalPrice ?? 0.0}']),
                                  // 'KD ${offer.originalPrice ?? 0.0}',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.PlaceholderColor),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  AppText.price_in_kd(args: [
                                    '${offer.discountedPrice ?? 0.0}'
                                  ]),
                                  // 'KD ${offer.discountedPrice ?? 0.0}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.FONT_COLOR),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
