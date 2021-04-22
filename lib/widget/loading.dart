import 'package:flutter/material.dart' hide WidgetBuilder;
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:zzapp/controller/base.dart';
import 'package:zzapp/controller/theme.dart';

// 加载宽度
const loadingWidth = 54.0;

///
/// 组件构建器
///
typedef WidgetBuilder = Widget Function();

///
/// 加载组件
///
/// @author zzzz1997
/// @created_time 20210416
///
// ignore: must_be_immutable
class LoadingView extends StatelessWidget {
  // 状态
  final ControllerStatus status;

  // 子组件
  final WidgetBuilder builder;

  // 数据是否为空
  final bool isEmpty;

  // 请求失败点击事件
  final GestureTapCallback? onErrorTap;

  // 空数据组件
  Widget? empty;

  // 错误布局
  Widget? error;

  // 加载界面
  final Widget? loading;

  LoadingView(
      {required this.status,
      required this.builder,
      required this.isEmpty,
      this.onErrorTap,
      this.empty,
      this.error,
      this.loading}) {
    this.empty ??= prompt(true);
    this.error ??= prompt(false);
  }

  @override
  Widget build(BuildContext context) {
    return status == ControllerStatus.LOADING && isEmpty
        ? loading ?? LoadingView.load()
        : status == ControllerStatus.DONE
            ? Center(
                child: isEmpty ? empty : builder(),
              )
            : GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onErrorTap,
                child: Center(
                  child: error,
                ),
              );
  }

  ///
  /// 提示组件
  ///
  static Widget prompt(empty) => Text(
        empty ? '暂无记录' : '加载错误',
        style: TextStyle(
          fontSize: 12,
        ),
      );

  ///
  /// 加载组件
  ///
  static Widget load() => Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: loadingWidth,
            height: loadingWidth,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Get.find<ThemeController>().themeColor.value),
            ),
          ),
        ),
      );
}

///
/// 刷新加载组件
///
// ignore: must_be_immutable
class RefreshLoadingView extends StatelessWidget {
  // 状态
  final ControllerStatus status;

  // 子组件
  final WidgetBuilder builder;

  // 数据是否为空
  final bool isEmpty;

  // 请求失败点击事件
  final GestureTapCallback? onErrorTap;

  // 空数据组件
  Widget? empty;

  // 错误布局
  Widget? error;

  // 加载界面
  final Widget? loading;

  RefreshLoadingView(
      {required this.status,
      required this.builder,
      required this.isEmpty,
      this.onErrorTap,
      this.empty,
      this.error,
      this.loading}) {
    this.empty ??= LoadingView.prompt(true);
    this.error ??= LoadingView.prompt(false);
  }

  @override
  Widget build(BuildContext context) {
    return status == ControllerStatus.LOADING && isEmpty
        ? loading ??
            SliverToBoxAdapter(
              child: LoadingView.load(),
            )
        : status == ControllerStatus.DONE
            ? isEmpty
                ? _EmptyWidget(
                    child: empty!,
                  )
                : builder()
            : _EmptyWidget(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onErrorTap,
                  child: error,
                ),
              );
  }
}

///
/// 空视图组件
///
class _EmptyWidget extends StatelessWidget {
  // 子组件
  final Widget child;

  _EmptyWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_EmptyController());
    return Obx(
      () => controller.size.value.width == 0
          ? _SliverEmpty(
              child: LayoutBuilder(
                builder: (_, constraints) {
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    controller.size(
                        Size(constraints.maxWidth, constraints.maxHeight));
                  });
                  return SizedBox();
                },
              ),
              axisDirectionNotifier: controller.axisDirectionNotifier)
          : SliverToBoxAdapter(
              child: Container(
                width: controller.size.value.width,
                height: controller.size.value.height,
                alignment: Alignment.center,
                child: child,
              ),
            ),
    );
  }
}

///
/// 空组件控制器
///
class _EmptyController extends GetxController {
  // 列表方向
  final axisDirectionNotifier =
      ValueNotifier<AxisDirection>(AxisDirection.down);

  // 组件大小
  var size = Size(0, 0).obs;

  @override
  void onClose() {
    axisDirectionNotifier.dispose();
    super.onClose();
  }
}

///
/// 空视图组件
///
class _SliverEmpty extends SingleChildRenderObjectWidget {
  // 列表方向
  final ValueNotifier<AxisDirection> axisDirectionNotifier;

  const _SliverEmpty({
    required Widget child,
    required this.axisDirectionNotifier,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSliverEmpty(
      axisDirectionNotifier: axisDirectionNotifier,
    );
  }
}

///
/// 空视图组件渲染器
///
class _RenderSliverEmpty extends RenderSliverSingleBoxAdapter {
  // 列表方向
  final ValueNotifier<AxisDirection> axisDirectionNotifier;

  _RenderSliverEmpty({
    required this.axisDirectionNotifier,
  });

  // 获取子组件大小
  double get _childSize => constraints.axis == Axis.vertical
      ? child!.size.height
      : child!.size.width;

  @override
  void performLayout() {
    axisDirectionNotifier.value = constraints.axisDirection;
    child!.layout(
      constraints.asBoxConstraints(
        maxExtent: constraints.remainingPaintExtent,
      ),
      parentUsesSize: true,
    );
    geometry = SliverGeometry(
      paintExtent: constraints.remainingPaintExtent,
      maxPaintExtent: constraints.remainingPaintExtent,
      layoutExtent: constraints.remainingPaintExtent,
    );
  }

  @override
  void paint(PaintingContext paintContext, Offset offset) {
    if (constraints.remainingPaintExtent > 0.0 ||
        constraints.scrollOffset + _childSize > 0) {
      paintContext.paintChild(child!, offset);
    }
  }
}
