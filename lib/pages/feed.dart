import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import '../providers/video_provider.dart'; // Adjust this import as necessary
import '../providers/video.dart'; // Adjust this import as necessary
import 'view_prof.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    loadVideos();
  }

  Future<void> loadVideos() async {
    await videoService.loadVideos(); // Load all videos
    setState(() {
      videos = videoService.videoList; // Set the loaded videos
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
      return Center(child: CircularProgressIndicator()); // Loading state
    }

    return Scaffold(
      body: Stack(
        children: [
          // PageView for video content
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return _buildVideoPage(videos[index]);
            },
          ),
          // Fixed Search Bar at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildSearchBar(),
          ),
          // Fixed Bottom Navigation
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

  Widget _buildVideoPage(VideoData video) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerPage(
                  videoPath: video.file,
                  onDispose: () {
                    // Optionally handle video disposal if needed
                  },
                ),
              ),
            );
          },
          child: VideoPlayerPage(
            videoPath: video.file,
            onDispose: () {},
          ),
        ),
        Positioned(
          bottom: 70,
          left: MediaQuery.of(context).size.width * 0.05,
          child: _buildUserInfo(video.uploader, video.caption),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.15,
          right: MediaQuery.of(context).size.width * 0.05,
          child: _buildStats(video),
        ),
      ],
    );
  }

  Widget _buildUserInfo(String username, String caption) {
    return Container(
      constraints: BoxConstraints(maxWidth: 180),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildUsername(username),
              const SizedBox(width: 15),
              _buildFollowButton(),
            ],
          ),
          const SizedBox(height: 10),
          _buildCaption(caption),
        ],
      ),
    );
  }

  Widget _buildCaption(String caption) {
    int maxline = 2;

    return Text(
      caption,
      maxLines: maxline,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'Inter',
        fontSize: 12,
        height: 1.6,
      ),
    );
  }

  Widget _buildUsername(String username) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewProfPage()),
        );
      },
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            username,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontSize: 12,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: const Center(
        child: Text(
          'Follow',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 8,
            height: 2,
          ),
        ),
      ),
    );
  }

  String formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K'; // 1 decimal place
    }
    return count.toString();
  }

  Widget _buildStats(VideoData videoData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Like
        GestureDetector(
          onTap: () {
            setState(() {
              videoData.like(); // Increment like count
            });
          },
          child: _buildStatIcon(
              Boxicons.bx_heart,
              formatCount(videoData.likeCount),
              videoData.isLiked ? Colors.red : Colors.white),
        ),

        // Dislike
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            setState(() {
              videoData.dislike(); // Increment like count
            });
          },
          child: _buildStatIcon(
              Boxicons.bxs_sad,
              formatCount(videoData.dislikeCount),
              videoData.isDisliked ? Colors.purple : Colors.white),
        ),
        const SizedBox(height: 20),

        //Bookmark
        GestureDetector(
          onTap: () {
            setState(() {
              videoData.bookmark(); // Increment bookmark count
            });
          },
          child: _buildStatIcon(
              Boxicons.bx_bookmark,
              formatCount(videoData.bookmarkCount),
              videoData.isBookmarked ? Colors.yellow : Colors.white),
        ),
      ],
    );
  }

  Widget _buildStatIcon(IconData icon, String text, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: color),
        const SizedBox(width: 7),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontFamily: 'Inter',
            fontSize: 11,
          ),
        ),
      ],
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
        // Set the default border to be transparent
        border: InputBorder.none,
        // Custom focused border
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
          borderSide: const BorderSide(
            color: Color.fromRGBO(86, 63, 232, 1),
            width: 2,
          ),
        ),
        // This will apply the default bottom border when the field is focused
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
