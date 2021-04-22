import 'package:zzapp/entity/user.dart';
import 'package:zzapp/util/dio.dart';

///
/// 文章服务
///
/// @author zzzz1997
/// @created_time 20210422
///
class ArticleService {
  ///
  /// 获取文章数组
  ///
  static Future<List<Article>> getArticle(page) async {
    final List list = await DioUtil.get('/article/');
    return list.map((e) => Article.fromJson(e)).toList();
  }
}
