import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../view_models/player_view_model.dart';
import 'widgets/player_controls.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(
      builder: (context, viewModel, child) {
        final song = viewModel.currentSong;
        if (song == null) return const SizedBox.shrink();

        return CupertinoPageScaffold(
          backgroundColor: AppColors.background,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: AppColors.background,
            border: null,
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.chevron_down,
                color: AppColors.text,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            middle: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '지금 재생 중',
                  style: TextStyle(
                    color: AppColors.text.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  song.title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 앨범 아트
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: YoutubePlayer(
                            controller: viewModel.controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: AppColors.primary,
                            progressColors: ProgressBarColors(
                              playedColor: AppColors.primary,
                              bufferedColor: AppColors.surface,
                              backgroundColor: AppColors.background,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // 제목과 아티스트
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Text(
                              song.title,
                              style: const TextStyle(
                                color: AppColors.text,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              song.artist,
                              style: TextStyle(
                                color: AppColors.text.withOpacity(0.7),
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // 좋아요, 가사, 관련 목록 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: CupertinoIcons.music_note_list,
                      label: '다음 트랙',
                      onTap: () {},
                    ),
                    _buildActionButton(
                      icon: CupertinoIcons.text_justify,
                      label: '가사',
                      onTap: () {},
                    ),
                    _buildActionButton(
                      icon: CupertinoIcons.list_bullet,
                      label: '관련 목록',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // 재생 컨트롤
                const PlayerControls(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.text),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.text.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
} 