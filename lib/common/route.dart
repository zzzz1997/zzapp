import 'package:get/get.dart';
import 'package:zzapp/page/main.dart';
import 'package:zzapp/page/splash.dart';

///
/// 自定义路由
///
/// @author zzzz1997
/// @created_time 20191121
///
class FluzzRoute {
  // 开屏路由
  static const splash = '/splash';

  // 主页路由
  static const home = '/';

  // 路由
  static final routes = [
    GetPage(name: splash, page: () => SplashPage()),
    GetPage(name: home, page: () => MainPage()),
  ];
}
