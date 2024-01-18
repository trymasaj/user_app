import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masaj/core/presentation/widgets/stateless/back_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoGalleryItem extends StatelessWidget {
  const VideoGalleryItem({
    super.key,
    required this.video,
    this.height = 150.0,
    this.width = 150.0,
    this.margin = const EdgeInsets.all(8.0),
  });

  final String video;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final controller = YoutubePlayerController(
      initialVideoId: video,
      flags: const YoutubePlayerFlags(),
    );
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
            margin: margin,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: CustomCachedNetworkImage(
              imageUrl: 'https://img.youtube.com/vi/$video/0.jpg',
              fit: BoxFit.cover,
              urlWidth: width,
              urlHeight: height,
              width: width,
              height: height,
            )),
        IconButton(
          icon: const Icon(
            Icons.play_circle_outline_outlined,
            size: 40.0,
          ),
          onPressed: () => Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => SafeArea(
                    child: YoutubePlayerBuilder(
                      key: ValueKey('https://img.youtube.com/vi/$video/0.jpg'),
                      player: YoutubePlayer(
                        controller: controller,
                        showVideoProgressIndicator: true,
                        topActions: const [
                          CustomBackButton(color: Colors.white)
                        ],
                      ),
                      builder: (_, player) => player,
                    ),
                  ),
                ),
              )
              .whenComplete(_setOrientationPortrait),
        )
      ],
    );
  }

  void _setOrientationPortrait() =>
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
