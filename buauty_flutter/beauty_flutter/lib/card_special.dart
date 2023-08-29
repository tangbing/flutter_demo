

import 'package:beauty_flutter/base_card.dart';
import 'package:flutter/material.dart';

class CardSpecial extends BaseCard {

  @override
  _CardSpeicalState createState() => _CardSpeicalState();
}

class _CardSpeicalState extends BaseCardState {

  @override
  void initState() {
    bottomTitleColor = Colors.blue;
    super.initState();
  }

  @override
  topContainer() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 66, right: 66, top: 36, bottom: 30),
          decoration: BoxDecoration(color: Color(0xfffffcf7)),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 20), // 0，水平偏移距离，20垂直偏移距离
                  blurRadius: 20 // 模糊半径
                )
              ]
            ),
            child: Image.network(
                'http://www.devio.org/io/flutter_beauty/changan_book.jpg'),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20 ,top: 15, bottom: 15, right: 20),
          decoration: BoxDecoration(color: Color(0xfff7f3ea)),

          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('长安十二时辰···', style: TextStyle(fontSize: 18,color: Color(0xff473b25))),
                  Padding(padding: EdgeInsets.only(left: 5),child:  Text(
                      '马伯庸',
                      style: TextStyle(fontSize: 13, color: Color(0xff7d725c))
                  ),)

          ],
        ),
              Container(
                margin: EdgeInsets.only(left: 20),
                padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [Color(0xffd9bc82), Color(0xffecd9ae)],
                  ),
                ),
                child: Text(
                  '分享免费领',
                  style: TextStyle(color: Color(0xff4f3b1a), fontSize: 13),
              ),
    ),
          ],
        ),
    ),
    ]
    );
  }


  @override
  bottomContainer() {
    // TODO: implement bottomContainer
    return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,    // 水平撑开
          mainAxisAlignment: MainAxisAlignment.spaceAround, // 均分分布
          children: [
            Padding(padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network('http://www.devio.org/io/flutter_beauty/double_quotes.jpg',
                  width: 26,
                  height: 26,
                  ),
                  Text('揭露历史真相')
                  
                ],
              ),
            ),
            bottomTitle('更多免费好书领不停 >')
          ],
        ));
  }


}


