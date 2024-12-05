import 'package:flutter/foundation.dart';
import '../models/song.dart';
import '../services/youtube_service.dart';

class ExploreViewModel extends ChangeNotifier {
  final YouTubeService _youtubeService = YouTubeService();
  List<Song> _trendingSongs = [];
  bool _isLoading = false;
  String? _error;

  List<Song> get trendingSongs => _trendingSongs;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTrendingSongs() async {
    _isLoading = true;
    notifyListeners();

    try {
      _trendingSongs = await _youtubeService.getPopularSongs();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 