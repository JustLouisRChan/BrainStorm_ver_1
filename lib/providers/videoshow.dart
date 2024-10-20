import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoPath;
  final Function? onDispose; // Callback for dispose

  const VideoPlayerPage({super.key, required this.videoPath, this.onDispose});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late CustomVideoPlayerController _customVideoPlayerController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  @override
  void dispose() {
    _stopPlayback(); // Stop playback before disposing
    _customVideoPlayerController.videoPlayerController.dispose();
    widget.onDispose?.call(); // Call the callback if provided
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                  color: Color.fromRGBO(86, 63, 232, 1)),
            )
          : GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => _togglePlayPause(),
              child: AbsorbPointer(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 50,
                  width: MediaQuery.of(context).size.width,
                  child: CustomVideoPlayer(
                    customVideoPlayerController: _customVideoPlayerController,
                  ),
                ),
              ),
            ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      if (_customVideoPlayerController.videoPlayerController.value.isPlaying) {
        _customVideoPlayerController.videoPlayerController.pause();
      } else {
        _customVideoPlayerController.videoPlayerController.play();
      }
    });
  }

  void initializeVideoPlayer() {
    setState(() {
      isLoading = true;
    });

    final VideoPlayerController _videoPlayerController =
        VideoPlayerController.asset(widget.videoPath)
          ..initialize().then((_) {
            setState(() {
              isLoading = false;
            });
          });

    _customVideoPlayerController = CustomVideoPlayerController(
      customVideoPlayerSettings: CustomVideoPlayerSettings(
        controlBarAvailable: false,
        settingsButtonAvailable: false,
        showPlayButton: true,
      ),
      context: context,
      videoPlayerController: _videoPlayerController,
    );
  }

  void _stopPlayback() {
    if (_customVideoPlayerController.videoPlayerController.value.isPlaying) {
      _customVideoPlayerController.videoPlayerController
          .pause(); // Stop playback
    }
  }
}
