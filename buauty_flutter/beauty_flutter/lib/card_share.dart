

import 'package:beauty_flutter/base_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardShare extends BaseCard {

  @override
  _CardShareState createState() => _CardShareState();
}


class _CardShareState extends BaseCardState {
  
  @override
  bottomContainer() {
    // TODO: implement bottomContainer
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(color: Color(0xfff6f7f9)),
        child: Column(
          /// 水平向右边
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: Padding(padding: EdgeInsets.only(top: 10, left: 15, bottom: 20),
              child: Image.network('http://www.devio.org/io/flutter_beauty/card_list.png'),)),
           Container(
             /// 重写父布局得位置约束，位于父布局中央
             alignment: AlignmentDirectional.center,
             child:  Padding(padding: EdgeInsets.only(bottom: 20),
               child: bottomTitle('29876678人 · 参与活动'),),
           )
          ],
        ),
      ),
    );
  }

  topTitle(String title) {
    // TODO: implement topTitle
    return super.topTitle('分享得联名卡');
  }

  @override
  Widget subTitle(String title) {
    return super.subTitle('分享给朋友最多可获得12天无限卡');
  }

  @override
  topRightTitle(String title) {
    // TODO: implement topRightTitle
    return Padding(padding: EdgeInsets.only(bottom: 5), child: Text('/ 第19期',style: TextStyle(fontSize: 10),),);
  }


  
}