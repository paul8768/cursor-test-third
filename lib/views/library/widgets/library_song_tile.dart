import 'package:flutter/cupertino.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/song.dart';

class LibrarySongTile extends StatelessWidget {
  final Song song;
  final bool isLiked;
  final VoidCallback onLikePressed;
  final VoidCallback? onTap;

  const LibrarySongTile({
    super.key,
    required this.song,
    required this.isLiked,
    required this.onLikePressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // 앨범 커버
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: NetworkImage(song.coverUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 곡 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    song.artist,
                    style: TextStyle(
                      color: AppColors.text.withOpacity(0.7),
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // 좋아요 버튼
            CupertinoButton(
              padding: const EdgeInsets.all(12),
              onPressed: onLikePressed,
              child: Icon(
                isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: isLiked ? AppColors.primary : AppColors.text,
                size: 22,
              ),
            ),
            // 더보기 버튼
            CupertinoButton(
              padding: const EdgeInsets.all(12),
              onPressed: () => _showOptionsSheet(context),
              child: const Icon(
                CupertinoIcons.ellipsis_vertical,
                color: AppColors.text,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 재생목록에 추가 기능 구현
            },
            child: const Text('재생목록에 추가'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 아티스트로 이동 기능 구현
            },
            child: const Text('아티스트로 이동'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 앨범으로 이동 기능 구현
            },
            child: const Text('앨범으로 이동'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          isDestructiveAction: true,
          child: const Text('취소'),
        ),
      ),
    );
  }
} 