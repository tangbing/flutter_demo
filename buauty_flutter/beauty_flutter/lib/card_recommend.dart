
import 'package:beauty_flutter/base_card.dart';
import 'package:flutter/material.dart';

/// 本周推荐
class CardRecommend extends BaseCard {

 @override
 _CardcommendState createState() => _CardcommendState();

}

class _CardcommendState extends BaseCardState {

 @override
  void initState() {
   subTitleColor = Color(0xffbb99444);
    super.initState();
  }

  @override
  bottomContainer() {
    // 高度撑满
     return Expanded(child: Container(
       /// 通过BoxConstraints尽可能撑满父容器
         constraints: BoxConstraints.expand(),
         margin: EdgeInsets.only(top: 20),
         child: Image.network('http://www.devio.org/io/flutter_beauty/card_1.jpg',
             fit: BoxFit.cover),//宽高会充满容器，会裁剪

     ));
  }
  @override
  topTitle(String title) {
    // TODO: implement topTitle
    return super.topTitle('本周推荐');
  }
  @override
  Widget subTitle(String title) {
    // TODO: implement subTitle
    return super.subTitle('送你一天无限卡:全场书籍免费读>');
  }
}