import 'package:flutter/foundation.dart';
import '../models/playlist.dart';
import '../models/song.dart';
import '../services/youtube_service.dart';

class LibraryViewModel extends ChangeNotifier {
  final YouTubeService _youtubeService = YouTubeService();
  List<Song> _likedSongs = [];
  List<Playlist> _playlists = [];
  bool _isLoading = false;
  String? _error;

  List<Song> get likedSongs => _likedSongs;
  List<Playlist> get playlists => _playlists;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadLibrary() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: 실제 데이터 로드 구현
      _playlists = await _youtubeService.getFeaturedPlaylists();
      _likedSongs = await _youtubeService.getPopularSongs();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleLikeSong(Song song) {
    final index = _likedSongs.indexWhere((s) => s.id == song.id);
    if (index >= 0) {
      _likedSongs.removeAt(index);
    } else {
      _likedSongs.add(song);
    }
    notifyListeners();
  }

  bool isLiked(Song song) {
    return _likedSongs.any((s) => s.id == song.id);
  }

  Future<void> createPlaylist(String name, String description) async {
    // TODO: 플레이리스트 생성 구현
    notifyListeners();
  }

  Future<void> addToPlaylist(Playlist playlist, Song song) async {
    // TODO: 플레이리스트에 곡 추가 구현
    notifyListeners();
  }
} 