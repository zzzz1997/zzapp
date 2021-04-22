import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzapp/controller/home.dart';
import 'package:zzapp/entity/user.dart';
import 'package:zzapp/page/common/base.dart';
import 'package:zzapp/widget/appbar.dart';

///
/// 首页页面
///
/// @author zzzz1997
/// @created_time 20210421
///
// ignore: must_be_immutable
class HomeFragment extends StatelessWidget with BaseRefresh<HomeController> {
  @override
  HomeController get controller => HomeController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar('home'.tr),
      body: buildRefresh(
        () => SliverPadding(
          padding: EdgeInsets.all(15),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => i.isEven
                  ? _buildArticle(c.data[i ~/ 2])
                  : SizedBox(
                      height: 10,
                    ),
              childCount: c.data.length * 2,
            ),
          ),
        ),
      ),
    );
  }

  ///
  ///构建文章
  ///
  Widget _buildArticle(Article article) {
    return Card(
      child: Text(article.title),
    );
  }
}
