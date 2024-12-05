import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'core/constants/app_colors.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 시스템 UI 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: CupertinoColors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: CupertinoColors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // 세로 모드로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}
