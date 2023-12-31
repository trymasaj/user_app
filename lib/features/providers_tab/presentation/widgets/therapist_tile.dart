import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TherapistTile extends StatelessWidget {
  const TherapistTile({Key? key, required this.therapist}) : super(key: key);
  final TherapistSummaryData therapist;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: CachedNetworkImage(imageUrl: 'imageUrl')),
          Column(
            children: [
              Text(therapist.name),
              Text(therapist.special),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: 2.75,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 50.0,
                    direction: Axis.vertical,
                  ),
                  Spacer(),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
