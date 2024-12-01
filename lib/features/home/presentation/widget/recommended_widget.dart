import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/features/home/presentation/pages/home_tab.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/presentation/screens/serice_details_screen.dart';
import 'package:masaj/gen/assets.gen.dart';

class Recommended extends StatefulWidget {
  const Recommended({
    super.key,
    required this.recommendedServices,
  });
  final List<ServiceModel> recommendedServices;
  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
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
              SectionTitle(title: AppText.recommended),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height:142,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              scrollDirection: Axis.horizontal,
              itemCount: widget.recommendedServices.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ServiceDetailsScreen.routeName,
                      arguments: ServiceDetailsScreenArguments(
                          id: widget.recommendedServices[index].serviceId),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right:  context.locale.languageCode == 'ar' ? 0 :10, left:context.locale.languageCode == 'ar' ? 10 :0),
                    width: 110.w,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.GREY_LIGHT_COLOR_2,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // image
                        Container(
                          height: 82.h,
                          width: 83.w,
                          decoration: BoxDecoration(
                            color: AppColors.GREY_LIGHT_COLOR_2,
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              image: CustomCachedNetworkImageProvider(
                                widget.recommendedServices[index].mainImage ??
                                    '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.recommendedServices[index].title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.FONT_COLOR),
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
