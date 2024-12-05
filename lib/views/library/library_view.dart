import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../view_models/library_view_model.dart';
import 'widgets/library_playlist_card.dart';
import 'widgets/library_song_tile.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LibraryViewModel>().loadLibrary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryViewModel>(
      builder: (context, viewModel, child) {
        return CupertinoPageScaffold(
          backgroundColor: AppColors.background,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: AppColors.surface,
            middle: const Text('보관함'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.plus, color: AppColors.text),
              onPressed: () => _showCreatePlaylistDialog(context),
            ),
          ),
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                if (viewModel.isLoading)
                  const SliverFillRemaining(
                    child: Center(child: CupertinoActivityIndicator()),
                  )
                else if (viewModel.error != null)
                  SliverFillRemaining(
                    child: Center(
                      child: Text(
                        viewModel.error!,
                        style: const TextStyle(color: AppColors.text),
                      ),
                    ),
                  )
                else
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPlaylists(viewModel),
                          const SizedBox(height: 32),
                          _buildLikedSongs(viewModel),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaylists(LibraryViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '내 플레이리스트',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.playlists.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: LibraryPlaylistCard(
                  playlist: viewModel.playlists[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLikedSongs(LibraryViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '좋아요 표시한 곡',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.likedSongs.length,
          itemBuilder: (context, index) {
            return LibrarySongTile(
              song: viewModel.likedSongs[index],
              isLiked: true,
              onLikePressed: () {
                viewModel.toggleLikeSong(viewModel.likedSongs[index]);
              },
            );
          },
        ),
      ],
    );
  }

  void _showCreatePlaylistDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('새 플레이리스트'),
        content: Column(
          children: [
            const SizedBox(height: 16),
            CupertinoTextField(
              placeholder: '플레이리스트 이름',
              autofocus: true,
            ),
            const SizedBox(height: 8),
            CupertinoTextField(
              placeholder: '설명 (선택사항)',
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('생성'),
            onPressed: () {
              // TODO: 플레이리스트 생성 로직 구현
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
} 