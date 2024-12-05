class Song {
  final String id;
  final String title;
  final String artist;
  final String coverUrl;
  final String youtubeUrl;
  final Duration? duration;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.youtubeUrl,
    this.duration,
  });
} 