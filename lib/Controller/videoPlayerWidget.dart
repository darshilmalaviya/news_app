import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/get_x_controller.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final dynamic video;
  final String videoFrom;
  final bool autoPlay;
  final bool showPlayPause;
  final bool showVideoIcon;
  final bool touchToSeePlayPause;
  final int index;
  final double height;
  final double width;

  const VideoPlayerWidget(
      {Key? key,
      required this.video,
      this.videoFrom = 'network',
      this.autoPlay = false,
      this.showPlayPause = true,
      this.showVideoIcon = false,
      this.touchToSeePlayPause = true,
      this.index = 0,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool isLoading = false;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.video))
          ..initialize().then((value) {
            setState(() {
              isLoading = false;
            });
          });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController.value.hasError) {
      return Center(
        child: Icon(Icons.error_outline_rounded),
      );
    }

    return videoContainer();
  }

  Widget videoContainer() {
    return videoPlayerController.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: widget.height,
                  width: widget.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: VideoPlayer(
                    videoPlayerController,
                  ),
                ),
              ),
              widget.showPlayPause
                  ? GestureDetector(
                      onTap: () {
                        videoPlayerController.value.isPlaying
                            ? videoPlayerController.pause()
                            : videoPlayerController.play();
                        setState(() {});
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent.withOpacity(0.4),
                        child: Icon(
                          videoPlayerController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: widget.height * 0.15,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}
