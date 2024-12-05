import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/song.dart';
import '../models/playlist.dart';

class YouTubeService {
  static final List<Map<String, String>> genres = [
    {
      'title': '운동',
      'imageUrl': 'https://i.ytimg.com/vi/gMaB-fG4u4g/maxresdefault.jpg',
    },
    {
      'title': '에너지 충전',
      'imageUrl': 'https://i.ytimg.com/vi/Y4goaZhNt4k/maxresdefault.jpg',
    },
    {
      'title': '집중',
      'imageUrl': 'https://i.ytimg.com/vi/DWcJFNfaw9c/maxresdefault.jpg',
    },
    {
      'title': '휴식',
      'imageUrl': 'https://i.ytimg.com/vi/rUxyKA_-grg/maxresdefault.jpg',
    },
  ];

  static final List<Song> popularSongs = [
    Song(
      id: '1',
      title: '지글지글',
      artist: '제이통 (J-Tong), Nosun, KHAN (Feat. ZICO)',
      youtubeUrl: 'https://www.youtube.com/watch?v=1dtbvg8FUuI',
      coverUrl: 'https://img.youtube.com/vi/1dtbvg8FUuI/maxresdefault.jpg',
    ),
    Song(
      id: '2',
      title: '지글지글',
      artist: '제이통 (J-Tong), Nosun, KHAN (Feat. ZICO)',
      youtubeUrl: 'https://www.youtube.com/watch?v=1dtbvg8FUuI',
      coverUrl: 'https://img.youtube.com/vi/1dtbvg8FUuI/maxresdefault.jpg',
    ),
    Song(
      id: '1dtbvg8FUuI',
      title: 'Pretender',
      artist: 'FREANER',
      coverUrl: 'https://i.ytimg.com/vi/1dtbvg8FUuI/maxresdefault.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=1dtbvg8FUuI',
    ),
    Song(
      id: '1dtbvg8FUuI',
      title: '빨워 (Remix)',
      artist: 'FREANER',
      coverUrl: 'https://i.ytimg.com/vi/1dtbvg8FUuI/maxresdefault.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=1dtbvg8FUuI',
    ),
    Song(
      id: '1dtbvg8FUuI',
      title: '[Play]이상한',
      artist: 'Unknown',
      coverUrl: 'https://i.ytimg.com/vi/1dtbvg8FUuI/maxresdefault.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=1dtbvg8FUuI',
    ),
    Song(
      id: '1dtbvg8FUuI',
      title: 'This Is Me',
      artist: 'The Greatest Showman',
      coverUrl: 'https://i.ytimg.com/vi/1dtbvg8FUuI/maxresdefault.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=1dtbvg8FUuI',
    ),
    Song(
      id: '1dtbvg8FUuI',
      title: 'Bubble Gum',
      artist: 'New Jeans',
      coverUrl: 'https://i.ytimg.com/vi/1dtbvg8FUuI/maxresdefault.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=1dtbvg8FUuI',
    ),
    Song(
      id: '1dtbvg8FUuI',
      title: 'K-힙합스트',
      artist: 'Unknown',
      coverUrl: 'https://i.ytimg.com/vi/1dtbvg8FUuI/maxresdefault.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=1dtbvg8FUuI',
    ),
    Song(
      id: '1dtbvg8FUuI',
      title: 'GODS',
      artist: 'NewJeans',
      coverUrl: 'https://i.ytimg.com/vi/1dtbvg8FUuI/maxresdefault.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=1dtbvg8FUuI',
    ),
    Song(
      id: '1dtbvg8FUuI',
      title: '정형창',
      artist: 'Unknown',
      coverUrl: 'https://i.ytimg.com/vi/1dtbvg8FUuI/maxresdefault.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=1dtbvg8FUuI',
    ),
  ];

  static final List<Playlist> featuredPlaylists = [
    Playlist(
      id: 'quick_picks',
      name: '빠른 선곡',
      description: '당신을 위한 추천 음악',
      coverUrl: 'https://i.ytimg.com/vi/1dtbvg8FUuI/maxresdefault.jpg',
      songs: popularSongs,
    ),
  ];

  Future<List<Song>> getPopularSongs() async {
    // TODO: YouTube Data API 연동
    return popularSongs;
  }

  Future<List<Playlist>> getFeaturedPlaylists() async {
    // TODO: YouTube Data API 연동
    return featuredPlaylists;
  }

  Future<Song?> getSongDetails(String videoId) async {
    try {
      final controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          hideControls: true,
        ),
      );
      
      // 메타데이터가 로드될 때까지 대기
      await Future.delayed(const Duration(milliseconds: 500));
      final metaData = controller.metadata;
      controller.dispose();

      return Song(
        id: videoId,
        title: metaData.title,
        artist: metaData.author,
        coverUrl: 'https://i.ytimg.com/vi/$videoId/maxresdefault.jpg',
        youtubeUrl: 'https://www.youtube.com/watch?v=$videoId',
      );
    } catch (e) {
      return null;
    }
  }
} 