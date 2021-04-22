import 'package:dio/dio.dart';
import 'package:zzapp/common/constant.dart';
import 'package:zzapp/common/global.dart';

///
/// dio工具类
///
/// @author zzzz1997
/// @created_time 20210422
///
class DioUtil {
  // 获取dio
  static Dio get dio => _getDio();

  // dio单例
  static Dio? _dio;

  ///
  /// 获取dio单例
  ///
  static Dio _getDio() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 10000,
      ));
    }
    return _dio!;
  }

  ///
  /// get请求
  ///
  static Future<dynamic> get(url,
      {Map<String, dynamic>? query, bool debug = false}) async {
    query ??= {};
    query.addAll({
      't': DateTime.now().millisecondsSinceEpoch,
    });
    if (debug) {
      Global.logger.d('GET: ${Constant.server}$url');
      Global.logger.d(query);
    }
    final response = await dio.get(
      Constant.server + url,
      queryParameters: query,
    );
    if (debug) {
      Global.logger.d('GET: ${Constant.server}$url -END');
      Global.logger.d(response.data);
    }
    if (response.data['code'] == 1) {
      return (response.data['data'] is Map && response.data['data'].isEmpty)
          ? response.data['message']
          : response.data['data'];
    } else {
      throw response.data['message'];
    }
  }

  ///
  /// post请求
  ///
  static Future<dynamic> post(url,
      {Map<String, dynamic>? data, bool debug = false}) async {
    data ??= {};
    data.addAll({
      't': DateTime.now().millisecondsSinceEpoch,
    });
    if (debug) {
      Global.logger.d('GET: ${Constant.server}$url');
      Global.logger.d(data);
    }
    final response = await dio.post(
      Constant.server + url,
      data: FormData.fromMap(data),
    );
    if (debug) {
      Global.logger.d('POST: ${Constant.server}$url -END');
      Global.logger.d(response.data);
    }
    if (response.data['code'] == 1) {
      return (response.data['data'] is Map && response.data['data'].isEmpty)
          ? response.data['message']
          : response.data['data'];
    } else {
      throw response.data['message'];
    }
  }
}
