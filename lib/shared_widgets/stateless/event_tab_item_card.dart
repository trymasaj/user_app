import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../features/home/data/models/event.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import 'custom_cached_network_image.dart';
import 'subtitle_text.dart';
import 'title_text.dart';

class EventTabItemCard extends StatelessWidget {
  const EventTabItemCard({
    required this.event,
    required this.height,
    required this.onTap,
    required this.date,
    String? heroTag,
    super.key,
  }) : _heroTag = heroTag;

  final Event event;
  final double height;
  final VoidCallback onTap;
  final String? date;
  final String? _heroTag;
  @override
  Widget build(BuildContext context) {
    Widget child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.GREY_LIGHT_COLOR,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEventImage(event.picture ?? '', _heroTag),
            _buildDetails(context, event),
          ],
        ),
      ),
    );

    return InkWell(
      child: child,
      onTap: onTap,
    );
  }

  Widget _buildDetails(BuildContext context, Event e) {
    return Expanded(
        flex: 6,
        child: SizedBox(
          height: height + 32,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildName(e),
                const SizedBox(height: 8.0),
                _buildDates(e),
                const Spacer(),
                _buildShowDetailsButton(context, e),
              ],
            ),
          ),
        ));
  }

  Widget _buildName(Event e) {
    return TitleText.medium(
      text: e.name ?? '',
      color: AppColors.ACCENT_COLOR,
    );
  }

  Expanded _buildEventImage(String picture, String? heroTag) {
    Widget child = CustomCachedNetworkImage(
      imageUrl: picture,
      fit: BoxFit.cover,
      height: height,
      urlHeight: height,
      urlWidth: height,
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
    );

    if (heroTag != null) {
      child = Hero(
        transitionOnUserGestures: true,
        tag: heroTag,
        child: child,
      );
    }
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildDates(Event e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText.small(
          text: 'event_date_and_time',
          color: AppColors.GREY_NORMAL_COLOR,
        ),
        SubtitleText.small(
          text: date ?? '',
          color: AppColors.GREY_NORMAL_COLOR,
        )
      ],
    );
  }

  Widget _buildShowDetailsButton(BuildContext context, Event e) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: DefaultButton(
        label: 'show_details'.tr(),
        labelStyle: Theme.of(context).textTheme.bodyLarge!,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        onPressed: onTap,
      ),
    );
  }
}
