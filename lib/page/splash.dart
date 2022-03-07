import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zzapp/common/resource.dart';
import 'package:zzapp/common/route.dart';
import 'package:zzapp/controller/theme.dart';

///
/// 开屏页面
///
/// @author zzzz1997
/// @created_time 20200911
///
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      Get.offNamed(FluzzRoute.home);
    });
    final controller = Get.find<ThemeController>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageHelper.image('ic_fluzz.svg'),
            width: 200,
            height: 200,
          ),
          SizedBox(
            width: Get.width,
            height: 20,
          ),
          Text(
            'FLUZZ',
            style: TextStyle(
              color: controller.themeColor.value,
              fontSize: 30,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
