import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../models/song.dart';
import '../../view_models/player_view_model.dart';
import '../../services/youtube_service.dart';
import 'widgets/genre_button.dart';
import 'widgets/playlist_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.background,
        border: null,
        middle: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.music_note_2, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              'Music',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: CupertinoColors.activeOrange,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'U',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            // 상단 카테고리 버튼들
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryButton('운동'),
                  _buildCategoryButton('에너지 충전'),
                  _buildCategoryButton('팟캐스트'),
                  _buildCategoryButton('행복한 기분'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 빠른 선곡 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '빠른 선곡',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: YouTubeService.popularSongs.length,
                      itemBuilder: (context, index) {
                        final song = YouTubeService.popularSongs[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: PlaylistCard(
                            song: song,
                            onTap: () {
                              final playerViewModel = context.read<PlayerViewModel>();
                              playerViewModel.setPlaylist(
                                YouTubeService.popularSongs,
                                initialIndex: index,
                              );
                              AppRoutes.navigateToPlayer(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Shorts 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        '인기 급상승 Shorts 동영상',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: const [
                            Icon(CupertinoIcons.play_fill, color: AppColors.primary),
                            SizedBox(width: 4),
                            Text(
                              '모두 재생',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          final playerViewModel = context.read<PlayerViewModel>();
                          playerViewModel.setPlaylist(YouTubeService.popularSongs);
                          AppRoutes.navigateToPlayer(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 음악 리스트 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '인기 음악',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: YouTubeService.popularSongs.length,
                      itemBuilder: (context, index) {
                        final song = YouTubeService.popularSongs[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: PlaylistCard(
                            song: song,
                            onTap: () {
                              final playerViewModel = context.read<PlayerViewModel>();
                              playerViewModel.setPlaylist(
                                YouTubeService.popularSongs,
                                initialIndex: index,
                              );
                              AppRoutes.navigateToPlayer(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
} 