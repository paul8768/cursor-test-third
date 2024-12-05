import 'package:flutter/foundation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/song.dart';
import 'dart:math';

class PlayerViewModel extends ChangeNotifier {
  late YoutubePlayerController _controller;
  YoutubePlayerController get controller => _controller;
  Song? _currentSong;
  bool _isPlaying = false;
  bool _isInitialized = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isShuffle = false;
  RepeatMode _repeatMode = RepeatMode.off;
  List<Song> _playlist = [];
  int _currentIndex = -1;

  Song? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;
  bool get isInitialized => _isInitialized;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get isShuffle => _isShuffle;
  RepeatMode get repeatMode => _repeatMode;
  List<Song> get playlist => _playlist;
  int get currentIndex => _currentIndex;

  void initializePlayer(Song song) {
    final videoId = YoutubePlayer.convertUrlToId(song.youtubeUrl) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: false,
        isLive: false,
        forceHD: true,
        showLiveFullscreenButton: false,
        hideThumbnail: true,
      ),
    );

    _controller.addListener(_onPlayerStateChange);
    _currentSong = song;
    _isInitialized = true;
    _isPlaying = true;
    notifyListeners();
  }

  void _onPlayerStateChange() {
    if (!_isInitialized) return;

    _isPlaying = _controller.value.isPlaying;
    _position = Duration(seconds: _controller.value.position.inSeconds);
    _duration = _controller.value.metaData.duration;
    
    if (_controller.value.playerState == PlayerState.ended) {
      if (_repeatMode == RepeatMode.one) {
        _controller.seekTo(Duration.zero);
        _controller.play();
      } else if (_repeatMode == RepeatMode.all) {
        playNext();
      }
    }
    
    notifyListeners();
  }

  void play(Song song) {
    if (!_isInitialized || _currentSong?.id != song.id) {
      initializePlayer(song);
    } else {
      resume();
    }
  }

  void pause() {
    if (_isInitialized) {
      _controller.pause();
      _isPlaying = false;
      notifyListeners();
    }
  }

  void resume() {
    if (_isInitialized) {
      _controller.play();
      _isPlaying = true;
      notifyListeners();
    }
  }

  void seek(Duration position) {
    if (_isInitialized) {
      _controller.seekTo(position);
    }
  }

  void toggleShuffle() {
    _isShuffle = !_isShuffle;
    notifyListeners();
  }

  void toggleRepeatMode() {
    switch (_repeatMode) {
      case RepeatMode.off:
        _repeatMode = RepeatMode.all;
        break;
      case RepeatMode.all:
        _repeatMode = RepeatMode.one;
        break;
      case RepeatMode.one:
        _repeatMode = RepeatMode.off;
        break;
    }
    notifyListeners();
  }

  void setPlaylist(List<Song> songs, {int initialIndex = 0}) {
    _playlist = songs;
    _currentIndex = initialIndex;
    if (songs.isNotEmpty && initialIndex >= 0 && initialIndex < songs.length) {
      play(songs[initialIndex]);
    }
  }

  void playNext() {
    if (_playlist.isEmpty) return;

    if (_isShuffle) {
      _currentIndex = _getRandomIndex();
    } else {
      _currentIndex = (_currentIndex + 1) % _playlist.length;
    }
    
    play(_playlist[_currentIndex]);
  }

  void playPrevious() {
    if (_playlist.isEmpty) return;

    if (_isShuffle) {
      _currentIndex = _getRandomIndex();
    } else {
      _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    }
    
    play(_playlist[_currentIndex]);
  }

  int _getRandomIndex() {
    if (_playlist.length <= 1) return 0;
    final random = Random();
    int newIndex;
    do {
      newIndex = random.nextInt(_playlist.length);
    } while (newIndex == _currentIndex);
    return newIndex;
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _controller.removeListener(_onPlayerStateChange);
      _controller.dispose();
    }
    super.dispose();
  }

  void seekTo(Duration position) {
    if (_isInitialized) {
      _controller.seekTo(position);
      seek(position);
    }
  }

  void previous() {
    playPrevious();
  }

  void next() {
    playNext();
  }

  void togglePlay() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }
}

enum RepeatMode { off, all, one } 