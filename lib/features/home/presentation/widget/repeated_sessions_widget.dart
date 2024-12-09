import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/features/book_service/data/models/booking_model/session_model.dart';
import 'package:masaj/features/home/presentation/pages/home_tab.dart';
import 'package:masaj/features/services/presentation/screens/serice_details_screen.dart';

class RepeatedSessions extends StatefulWidget {
  const RepeatedSessions({
    super.key,
    required this.repeatedSessions,
  });
  final List<SessionModel> repeatedSessions;
  @override
  State<RepeatedSessions> createState() => _RepeatedSessionsState();
}

class _RepeatedSessionsState extends State<RepeatedSessions> {
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
              SectionTitle(title: AppText.repeated_sessions),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemCount: widget.repeatedSessions.length,
              itemBuilder: (context, index) {
                final repeatedSession = widget.repeatedSessions[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ServiceDetailsScreen.routeName,
                      arguments: ServiceDetailsScreenArguments(
                          id: repeatedSession.serviceId ?? 1),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right:  context.locale.languageCode == 'ar' ? 0 :10, left:context.locale.languageCode == 'ar' ? 10 :0),
                    width: 280,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.GREY_LIGHT_COLOR_2,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // image
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: AppColors.GREY_LIGHT_COLOR_2,
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: CustomCachedNetworkImageProvider(
                                repeatedSession.serviceMediaUrl ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              repeatedSession?.serviceName ?? '',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.FONT_COLOR),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            // start from
                            Text(
                              AppText.start_from,
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.PlaceholderColor),
                            ),
                            Text(
                              AppText.price_in_kd(args: [
                                repeatedSession?.servicePrice?.toString() ?? ''
                              ]),
                              // 'KD ${repeatedSession?.servicePrice ?? ''}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.FONT_COLOR),
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
