import 'package:dart_mock/dart_mock.dart' as mock;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzapp/common/global.dart';

///
/// 主题控制器
///
/// @author zzzz1997
/// @created_time 20210414
///
class ThemeController extends GetxController {
  // 夜间模式键
  static const kIsDarkMode = 'kIsDarkMode';

  // 主题颜色键
  static const kThemeColor = 'kThemeColor';

  // 字体索引键
  static const kFontIndex = 'kFontIndex';

  // 字体数组
  static const fontValueList = ['system', 'kuaile'];

  // 是否黑暗模式
  late RxBool isDarkMode;

  // 主题色
  late Rx<MaterialColor> themeColor;

  // 字体位置
  late RxInt fontIndex;

  @override
  onInit() {
    super.onInit();

    isDarkMode = (Global.sp.getBool(kIsDarkMode) ?? Get.isDarkMode).obs;
    themeColor = Colors.primaries[Global.sp.getInt(kThemeColor) ?? 5].obs;
    fontIndex = (Global.sp.getInt(kFontIndex) ?? 0).obs;
  }

  @override
  onReady() {
    super.onReady();

    Get.changeTheme(themeData());
  }

  ///
  /// 更改主题
  ///
  switchTheme({bool? mode, MaterialColor? color}) {
    if (isDarkMode.value != mode || themeColor.value != color) {
      isDarkMode(mode);
      themeColor(color);
      Get.changeTheme(themeData());
      Global.sp.setBool(kIsDarkMode, isDarkMode.value);
      Global.sp.setInt(kThemeColor, Colors.primaries.indexOf(themeColor.value));
    }
  }

  ///
  /// 切换字体
  ///
  switchFont(int index) {
    if (fontIndex.value != index) {
      fontIndex(index);
      Global.sp.setInt(kFontIndex, index);
      Get.changeTheme(themeData());
    }
  }

  ///
  /// 切换随机主题
  ///
  randomTheme() {
    switchTheme(
      mode: mock.boolean(),
      color: Colors.primaries[mock.integer(max: Colors.primaries.length - 1)],
    );
  }

  ///
  /// 主题
  ///
  ThemeData themeData({bool platformDarkMode = false}) {
    bool isDark = platformDarkMode || isDarkMode.value;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    Color secondary = (isDark ? themeColor.value[700] : themeColor.value)!;
    ThemeData themeData = ThemeData(
      brightness: brightness,
      primarySwatch: themeColor.value,
      fontFamily: fontValueList[fontIndex.value],
    );

    Color primaryColor = themeData.primaryColor;
    Color dividerColor = themeData.dividerColor;
    Color errorColor = themeData.errorColor;
    Color disabledColor = themeData.disabledColor;

    double width = 0.5;

    themeData = themeData.copyWith(
      brightness: brightness,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: themeColor.value,
        brightness: brightness,
      ),
      colorScheme: isDark
          ? ColorScheme.dark(
              secondary: secondary,
            )
          : ColorScheme.light(
              secondary: secondary,
            ),
      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
      splashColor: themeColor.value.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      textTheme: themeData.textTheme.copyWith(
        subtitle2: themeData.textTheme.subtitle2!.copyWith(
          textBaseline: TextBaseline.alphabetic,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: secondary,
        selectionColor: secondary.withAlpha(60),
        selectionHandleColor: secondary.withAlpha(60),
      ),
      toggleableActiveColor: secondary,
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor?.withOpacity(0.1),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(fontSize: 14),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: width,
            color: errorColor,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.7,
            color: errorColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: width,
            color: primaryColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: width,
            color: dividerColor,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            width: width,
            color: dividerColor,
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: width,
            color: disabledColor,
          ),
        ),
      ),
    );
    return themeData;
  }

  ///
  /// 获取字体名称
  ///
  static String fontName(index) {
    switch (index) {
      case 0:
        return 'autoBySystem'.tr;
      case 1:
        return 'fontKuaiLe'.tr;
      default:
        return '';
    }
  }
}
