// video_data.dart
class VideoData {
  final String id;
  final String uploaded;
  final String updated;
  final String uploader;
  final String category;
  final String caption;
  final List<String> tags;
  final String file;
  final double rating;
  int likeCount; // Change to mutable
  int bookmarkCount; // Change to mutable
  final int viewCount;
  final int shareCount;
  int dislikeCount;

  bool isLiked = false; // Track liked state
  bool isBookmarked = false;
  bool isDisliked = false;

  VideoData({
    required this.id,
    required this.uploaded,
    required this.updated,
    required this.uploader,
    required this.category,
    required this.caption,
    required this.tags,
    required this.file,
    required this.rating,
    required this.likeCount,
    required this.bookmarkCount,
    required this.viewCount,
    required this.shareCount,
    required this.dislikeCount,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) {
    return VideoData(
      id: json['id'],
      uploaded: json['uploaded'],
      updated: json['updated'],
      uploader: json['uploader'],
      category: json['category'],
      caption: json['caption'],
      tags: List<String>.from(json['tags']),
      file: json['file'],
      rating: json['rating'].toDouble(),
      likeCount: json['likeCount'],
      bookmarkCount: json['bookmarkCount'] ?? 0,
      viewCount: json['viewCount'],
      shareCount: json['shareCount'],
      dislikeCount: json['dislikeCount'],
    );
  }

  void like() {
    isLiked = !isLiked; // Toggle liked state
    likeCount += isLiked ? 1 : -1; // Increment or decrement count
  }

  void bookmark() {
    isBookmarked = !isBookmarked;
    bookmarkCount += isBookmarked ? 1 : -1; // Increment bookmark count
  }

  void dislike() {
    isDisliked = !isDisliked;
    dislikeCount += isDisliked ? 1 : -1; // Increment bookmark count
  }
}
