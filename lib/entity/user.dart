import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

///
/// 文章实体
///
/// @author zzzz1997
/// @created_time 20210422
///
@JsonSerializable()
class Article {
  // id
  int id;

  // 作者id
  int authorId;

  // 标题
  String title;

  // 描述
  String description;

  // 链接
  String url;

  // 浏览次数
  int visited;

  // 时间
  @JsonKey(name: 'createdAt', fromJson: timeFromJson, toJson: timeToJson)
  DateTime time;

  Article(this.id, this.authorId, this.title, this.description, this.url,
      this.visited, this.time);

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

  ///
  /// json转时间
  ///
  static DateTime timeFromJson(int? time) =>
      DateTime.fromMillisecondsSinceEpoch(time == null ? 0 : time);

  ///
  /// 时间转json
  ///
  static int? timeToJson(DateTime time) => time.millisecondsSinceEpoch;
}
