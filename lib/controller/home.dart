import 'package:zzapp/controller/base.dart';
import 'package:zzapp/entity/user.dart';
import 'package:zzapp/service/article.dart';

///
/// 首页控制器
///
/// @author zzzz1997
/// @created_time 20210422
///
class HomeController extends BaseRefreshController<Article> {
  @override
  Future<List<Article>> load(int page) async {
    return await ArticleService.getArticle(page);
  }
}
