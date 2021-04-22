import 'package:get/get.dart';

///
/// 模型状态
///
enum ControllerStatus {
  // 加载中
  LOADING,
  // 完成
  DONE,
  // 错误
  ERROR
}

///
/// 基础加载控制器
///
/// @author zzzz1997
/// @created_time 20210416
///
abstract class BaseLoadController<T> extends GetxController {
  // 状态
  var status = ControllerStatus.LOADING.obs;

  // 数据
  Rx<T>? data;

  ///
  /// 加载数据
  ///
  Future<T> load();

  ///
  /// 刷新
  ///
  reload() async {
    status(ControllerStatus.LOADING);
    try {
      data = (await load()).obs;
      status(ControllerStatus.DONE);
    } catch (e) {
      status(ControllerStatus.ERROR);
      throw e;
    }
  }
}

///
/// 基础刷新控制器
///
abstract class BaseRefreshController<T> extends GetxController {
  // 状态
  var status = ControllerStatus.LOADING.obs;

  // 数据
  var data = RxList<T>();

  // 没有更多
  var noMore = false.obs;

  // 页码
  var _page = 1;

  ///
  /// 加载数据
  ///
  Future<List<T>> load(int page);

  ///
  /// 刷新
  ///
  reload() async {
    status(ControllerStatus.LOADING);
    data.clear();
    noMore(false);
    _page = 1;
    try {
      final list = await load(_page);
      if (data.isEmpty) {
        noMore(true);
      }
      data(list);
      status(ControllerStatus.DONE);
    } catch (e) {
      status(ControllerStatus.ERROR);
      throw e;
    }
  }

  ///
  /// 加载更多
  ///
  loadMore() async {
    final list = await load(_page + 1);
    if (list.isNotEmpty) {
      data += list;
      _page++;
    } else {
      noMore(true);
    }
  }
}
