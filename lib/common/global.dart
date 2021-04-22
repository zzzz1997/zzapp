import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zzapp/controller/locale.dart';
import 'package:zzapp/controller/theme.dart';

///
/// 全局参数
///
/// @author zzzz1997
/// @created_time 20191121
///
class Global {
  // SharedPreferences对象
  static late SharedPreferences sp;

  // 日志记录者
  static late Logger logger;

  ///
  /// 初始化
  ///
  static init() async {
    sp = await SharedPreferences.getInstance();
    logger = Logger();
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => LocaleController());
  }

  ///
  /// 设置状态栏风格
  ///
  static setStyle(bool light) {
    SystemChrome.setSystemUIOverlayStyle(
        light ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
  }

  ///
  /// 吐司
  ///
  static toast(String message) {
    BotToast.showText(
      text: message,
      textStyle: TextStyle(
        color: Colors.white,
      ),
    );
  }
}
