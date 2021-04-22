import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zzapp/common/global.dart';
import 'package:zzapp/common/route.dart';
import 'package:zzapp/common/translation.dart';
import 'package:zzapp/controller/locale.dart';
import 'package:zzapp/controller/theme.dart';

///
/// 应用入口
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  debugPrint = (String message, {int wrapWidth}) => {};
  await Global.init();
  if (GetPlatform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  runApp(MyApp());
}

///
/// 主App
///
/// @author zzzz1997
/// @created_time 20191121
///
class MyApp extends StatelessWidget {
  // 标题
  static const title = 'zzapp';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)),
      builder: (_, snapshot) {
        final themeController = Get.find<ThemeController>();
        final localeController = Get.find<LocaleController>();
        return GetMaterialApp(
          title: title,
          getPages: FluzzRoute.routes,
          initialRoute: FluzzRoute.splash,
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          theme: themeController.themeData(),
          locale: localeController.locale,
          translations: FluzzTranslation(),
        );
      },
    );
  }
}
