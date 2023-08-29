

import 'package:json_annotation/json_annotation.dart';

part 'home_page_model.g.dart';

@JsonSerializable()
class HomePage {
  int? type; //分类，如推荐等
  String? title; //标题
  String? content; //内容
  String? playnum; //播放数量
  String? classname; //分类，如影视，追番等
  String? videoLength; //视频时长
  String? comments; //评论
  String? up; //博主
  String? videourl; //视频播放链接

  // 版权声明：本文为CSDN博主「吴庆森」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
  // 原文链接：https://blog.csdn.net/wuqingsen1/article/details/121673703

 HomePage();

 factory HomePage.fromJson(Map<String, dynamic>json) => _$HomePageFromJson(json);

 Map<String,dynamic> toJson() => _$HomePageToJson(this);

}