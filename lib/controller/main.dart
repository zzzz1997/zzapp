import 'package:get/get.dart';

///
/// 主页控制器
///
/// @author zzzz1997
/// @created_time 20210421
///
class MainController extends GetxController {
  // 位置
  var index = 0.obs;

  ///
  /// 设置位置
  ///
  setIndex(i) {
    index(i);
  }
}
