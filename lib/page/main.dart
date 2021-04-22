import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zzapp/common/global.dart';
import 'package:zzapp/controller/main.dart';
import 'package:zzapp/controller/theme.dart';
import 'package:zzapp/page/home/home.dart';
import 'package:zzapp/page/mine/mine.dart';

///
/// 主页面
///
/// @author zzzz1997
/// @created_time 20200911
///
// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  // 页面数组
  final _pages = [HomeFragment(), MineFragment()];

  // 时间戳
  var _timestamp = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    return WillPopScope(
      child: Scaffold(
        body: Obx(
          () => _pages[controller.index.value],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.index.value,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.face),
                label: 'mine'.tr,
              ),
            ],
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Get.find<ThemeController>().themeColor.value,
            unselectedItemColor: Get.theme.textTheme.caption!.color,
            onTap: controller.setIndex,
          ),
        ),
      ),
      onWillPop: () {
        final now = DateTime.now();
        if (_timestamp.difference(now).inSeconds.abs() > 1) {
          _timestamp = now;
          Global.toast('exitMessage'.tr);
          return Future.value(false);
        } else {
          SystemNavigator.pop();
          return Future.value(false);
        }
      },
    );
  }
}
