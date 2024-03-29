import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

///
/// 矢量图标
///
/// @author zzzz1997
/// @created_time 20200115
///
class IconFonts {
  // 图标库名
  static const String _fontFamily = 'fluzz';

  // flutter图标
  static const IconData flutter = IconData(0xe6a7, fontFamily: _fontFamily);
}

///
/// 图片帮助类
///
class ImageHelper {
  ///
  /// 图片链接
  ///
  static String image(String name) => 'asset/image/$name';

  ///
  /// 网络图片
  ///
  static ExtendedImage networkImage(String url,
      {double? width, double? height, BoxFit? fit, BoxShape? shape}) {
    return ExtendedImage.network(
      url,
      width: width,
      height: height,
      fit: fit,
      shape: shape,
      loadStateChanged: (ExtendedImageState s) =>
          s.extendedImageLoadState == LoadState.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                )
              : s.extendedImageLoadState == LoadState.failed
                  ? const Center(
                      child: Icon(Icons.error_outline),
                    )
                  : null,
    );
  }

  ///
  /// 本地资源图片
  ///
  static Image assetImage(String name,
      {double? width, double? height, BoxFit? fit}) {
    return Image.asset(
      image(name),
      width: width,
      height: height,
      fit: fit,
    );
  }
}

///
///
/// 样式
class Style {}
