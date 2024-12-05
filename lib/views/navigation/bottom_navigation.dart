import 'package:flutter/cupertino.dart';
import '../../core/constants/app_colors.dart';
import '../home/home_view.dart';
import '../library/library_view.dart';
import '../player/widgets/mini_player.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: AppColors.surface,
        activeColor: AppColors.primary,
        inactiveColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: '둘러보기',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_note_list),
            label: '보관함',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => Stack(
            children: [
              // 메인 화면
              if (index == 0)
                const HomeView()
              else if (index == 1)
                const Center(child: Text('둘러보기'))
              else if (index == 2)
                const LibraryView()
              else
                const SizedBox.shrink(),
              
              // 미니 플레이어
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: MiniPlayer(),
              ),
            ],
          ),
        );
      },
    );
  }
} 