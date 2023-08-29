// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePage _$HomePageFromJson(Map<String, dynamic> json) => HomePage()
  ..type = json['type'] as int?
  ..title = json['title'] as String?
  ..content = json['content'] as String?
  ..playnum = json['playnum'] as String?
  ..classname = json['classname'] as String?
  ..videoLength = json['videoLength'] as String?
  ..comments = json['comments'] as String?
  ..up = json['up'] as String?
  ..videourl = json['videourl'] as String?;

Map<String, dynamic> _$HomePageToJson(HomePage instance) => <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'content': instance.content,
      'playnum': instance.playnum,
      'classname': instance.classname,
      'videoLength': instance.videoLength,
      'comments': instance.comments,
      'up': instance.up,
      'videourl': instance.videourl,
    };
