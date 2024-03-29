import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzapp/common/global.dart';
import 'package:zzapp/common/resource.dart';
import 'package:zzapp/controller/locale.dart';
import 'package:zzapp/controller/theme.dart';
import 'package:zzapp/widget/appbar.dart';

///
/// 主页面
///
/// @author zzzz1997
/// @created_time 20200911
///
class MineFragment extends StatelessWidget {
  const MineFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final localeController = Get.find<LocaleController>();
    return Scaffold(
      appBar: MyAppBar('mine'.tr),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Global.toast('FLUZZ');
                },
                child: Icon(
                  IconFonts.flutter,
                  size: 200,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text('darkMode'.tr),
                  onTap: () {
                    themeController.switchTheme(mode: !Get.isDarkMode);
                  },
                  leading: Transform.rotate(
                    angle: -pi,
                    child: Icon(
                      Theme.of(context).brightness == Brightness.light
                          ? Icons.brightness_5
                          : Icons.brightness_2,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  trailing: Switch(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (_) {
                      themeController.switchTheme(mode: !Get.isDarkMode);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Text('colorTheme'.tr),
                  leading: Icon(
                    Icons.color_lens,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: <Widget>[
                          ...Colors.primaries
                              .map((color) => Material(
                                    color: color,
                                    child: InkWell(
                                      onTap: () {
                                        themeController.switchTheme(
                                            color: color);
                                      },
                                      child: const SizedBox(
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          Material(
                            child: InkWell(
                              onTap: () {
                                themeController.randomTheme();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                width: 40,
                                height: 40,
                                child: Text(
                                  '?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('font'.tr),
                      ),
                      Text(
                        ThemeController.fontName(themeController.fontIndex),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  leading: Icon(
                    Icons.font_download,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, i) => Obx(
                        () => RadioListTile<int>(
                          value: i,
                          groupValue: themeController.fontIndex.value,
                          onChanged: (i) {
                            themeController.switchFont(i!);
                          },
                          title: Text(ThemeController.fontName(i)),
                        ),
                      ),
                      itemCount: ThemeController.fontValueList.length,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('language'.tr),
                      ),
                      Text(
                        LocaleController.localeName(
                            localeController.localeIndex.value),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  leading: Icon(
                    Icons.public,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, i) => Obx(
                        () => RadioListTile<int>(
                          value: i,
                          groupValue: localeController.localeIndex.value,
                          onChanged: (i) {
                            localeController.switchLocale(i!);
                          },
                          title: Text(LocaleController.localeName(i)),
                        ),
                      ),
                      itemCount: LocaleController.localeValueList.length,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
