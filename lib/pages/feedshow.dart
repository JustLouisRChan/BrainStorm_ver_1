import 'package:flutter/material.dart';
import '../providers/video_provider.dart'; // Adjust this import as necessary
import '../providers/video.dart'; // Adjust this import as necessary
import 'search.dart';
import '../material/botnav.dart';
import '../providers/videoshow.dart'; // Import the VideoPlayerPage

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedPage> {
  final TextEditingController _searchController = TextEditingController();
  final String hintText = 'Search...';

  final VideoService videoService = VideoService();
  List<VideoData> videos = []; // List of videos
  late PageController _pageController;

  // ignore: unused_field
  int? _currentlyPlayingIndex; // Track currently playing video index

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    loadVideos();
  }

  Future<void> loadVideos() async {
    await videoService.loadVideos();
    setState(() {
      videos = videoService.videoList;
    });
  }

  void _resetUI() {
    setState(() {
      _currentlyPlayingIndex = null; // Reset UI state
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return _buildVideoPage(videos[index], index);
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildSearchBar(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPage(VideoData video, int index) {
    return GestureDetector(
      onTap: () {
        _currentlyPlayingIndex = index; // Track currently playing index
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerPage(
              videoPath: video.file,
              onDispose: () {
                // Reset UI when the video player is disposed
                _resetUI();
              },
            ),
          ),
        );
      },
      child: VideoPlayerPage(
        videoPath: video.file,
        onDispose: () {},
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          _navigateToSearchResults(value);
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: Color.fromARGB(168, 255, 239, 239),
        border: InputBorder.none,
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
          borderSide: const BorderSide(
            color: Color.fromRGBO(86, 63, 232, 1),
            width: 2,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  void _navigateToSearchResults(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(query: query),
      ),
    );
  }
}
