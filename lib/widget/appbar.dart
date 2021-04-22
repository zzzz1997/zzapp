import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// 自定义appbar
///
/// @author zzzz1997
/// @created_time 20210421
///
class MyAppBar extends AppBar {
  MyAppBar(String title)
      : super(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          title: Text(
            title,
            style: Get.theme.textTheme.bodyText2,
          ),
          centerTitle: true,
        );
}
