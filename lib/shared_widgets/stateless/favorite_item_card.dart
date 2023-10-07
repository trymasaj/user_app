import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import '../../features/home/data/models/event.dart';
import 'subtitle_text.dart';
import 'title_text.dart';

import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import 'custom_cached_network_image.dart';

class FavoriteItemCard extends StatelessWidget {
  const FavoriteItemCard(
      {required this.event,
      required this.height,
      required this.onTap,
      this.onDeleteTap,
      super.key});

  final Event event;
  final double height;
  final VoidCallback onTap;
  final FutureCallback<bool>? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEventImage(event.picture ?? ''),
            _buildDetails(event),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDetails(Event e) {
    return Expanded(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildZoneAndRemoveSection(e),
              _buildName(e),
              _buildLocation(e),
              _buildEventDetails(),
            ],
          ),
        ));
  }

  Widget _buildZoneAndRemoveSection(Event e) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: TitleText.medium(
            text: e.zoneName ?? '',
            color: AppColors.PRIMARY_COLOR,
            maxLines: 1,
          ),
        ),
        if (onDeleteTap != null)
          DefaultButton(
              icon: const Icon(Icons.bookmark_remove),
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              onPressed: onDeleteTap!)
      ],
    );
  }

  Widget _buildName(Event e) {
    return TitleText(
      text: e.name ?? '',
      color: Colors.black,
      maxLines: 1,
    );
  }

  Expanded _buildEventImage(String picture) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomCachedNetworkImage(
          imageUrl: picture,
          fit: BoxFit.cover,
          height: height,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
  }

  Widget _buildLocation(Event e) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: AppColors.PRIMARY_COLOR,
          size: 20,
        ),
        SubtitleText.medium(
          text: e.zoneName ?? '',
          color: AppColors.PRIMARY_COLOR,
        ),
      ],
    );
  }

  Widget _buildEventDetails() {
    return SubtitleText(
      text: 'event_details',
      color: AppColors.ACCENT_COLOR,
    );
  }

  Widget _buildDatesAndInterest(Event e) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: e.eventDate != null
              ? SizedBox(child: _buildDates(e.eventDate!))
              : const SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Chip(
            label: TitleText.small(
              text: 'dfdf',
              margin: const EdgeInsets.symmetric(vertical: 8.0),
            ),
            backgroundColor: AppColors.PRIMARY_COLOR,
            avatar: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: CachedNetworkSVGImage(
                '',
                fit: BoxFit.contain,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDates(EventDate eventDate) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitleText.small(
          text:
              "${eventDate.startDateMonth} ${eventDate.startDateDay} - ${eventDate.endDateMonth} ${eventDate.endDateDay}",
          color: Colors.black,
        ),
        SubtitleText.small(
          text: "${eventDate.startTime}-${eventDate.endTime}",
          color: Colors.black,
        ),
      ],
    );
  }
}
