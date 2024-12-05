import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../view_models/player_view_model.dart';
import '../../../core/routes/app_routes.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(
      builder: (context, viewModel, child) {
        final song = viewModel.currentSong;
        if (song == null) return const SizedBox.shrink();

        return GestureDetector(
          onTap: () => AppRoutes.navigateToPlayer(context),
          child: Container(
            height: 64,
            color: AppColors.surface,
            child: Row(
              children: [
                // 썸네일
                Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage(song.coverUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // 제목, 아티스트
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        song.artist,
                        style: TextStyle(
                          color: AppColors.text.withOpacity(0.7),
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // 재생/일시정지 버튼
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    viewModel.isPlaying
                        ? CupertinoIcons.pause_fill
                        : CupertinoIcons.play_fill,
                    color: AppColors.text,
                  ),
                  onPressed: viewModel.togglePlay,
                ),
                // 다음 곡 버튼
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    CupertinoIcons.forward_fill,
                    color: AppColors.text,
                  ),
                  onPressed: viewModel.next,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 