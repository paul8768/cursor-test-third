import 'package:flutter/cupertino.dart';
import '../../views/player/player_view.dart';

class AppRoutes {
  static Future<void> navigateToPlayer(BuildContext context) {
    return Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => const PlayerView(),
      ),
    );
  }
} 