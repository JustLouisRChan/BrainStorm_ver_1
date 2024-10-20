// video_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'video.dart';

class VideoService {
  List<VideoData> videoList = [];

  Future<void> loadVideos() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    videoList = (json.decode(jsonString) as List)
        .map((video) => VideoData.fromJson(video))
        .toList();
  }

  VideoData getRandomVideo() {
    // if (videoList.isEmpty) {
    //   return null;
    // }
    final randomIndex = Random().nextInt(videoList.length);
    return videoList[randomIndex];
  }
}
