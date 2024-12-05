import 'package:flutter/foundation.dart';
import '../models/playlist.dart';
import '../models/song.dart';
import '../services/youtube_service.dart';

class HomeViewModel extends ChangeNotifier {
  final YouTubeService _youtubeService = YouTubeService();
  
  List<Playlist> _playlists = [];
  List<Song> _recentSongs = [];
  bool _isLoading = false;
  String? _error;
  
  List<Playlist> get playlists => _playlists;
  List<Song> get recentSongs => _recentSongs;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Map<String, String>> get genres => YouTubeService.genres;

  Future<void> loadData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final playlists = await _youtubeService.getFeaturedPlaylists();
      final popularSongs = await _youtubeService.getPopularSongs();
      
      _playlists = playlists;
      _recentSongs = popularSongs;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectGenre(String genre) {
    // TODO: 장르별 음악 필터링 구현
    notifyListeners();
  }
} 