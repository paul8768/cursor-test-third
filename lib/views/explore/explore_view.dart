import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../view_models/explore_view_model.dart';
import '../../view_models/player_view_model.dart';
import '../library/widgets/library_song_tile.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExploreViewModel>().loadTrendingSongs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreViewModel>(
      builder: (context, viewModel, child) {
        return CupertinoPageScaffold(
          backgroundColor: AppColors.background,
          navigationBar: const CupertinoNavigationBar(
            backgroundColor: AppColors.surface,
            middle: Text('둘러보기'),
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
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final song = viewModel.trendingSongs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 16,
                          ),
                          child: LibrarySongTile(
                            song: song,
                            isLiked: false,
                            onLikePressed: () {},
                            onTap: () {
                              final playerViewModel =
                                  context.read<PlayerViewModel>();
                              playerViewModel.setPlaylist(
                                viewModel.trendingSongs,
                                initialIndex: index,
                              );
                            },
                          ),
                        );
                      },
                      childCount: viewModel.trendingSongs.length,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
} 