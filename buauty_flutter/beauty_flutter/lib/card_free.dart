

import 'package:beauty_flutter/base_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardFree extends BaseCard {
  @override
  _CardFreeState createState() => _CardFreeState();
}


const BOOK_LIST = [
  {'title': '暴力沟通', 'cover': '51VykQqGq9L._SY346_.jpg', 'price': '19.6'},
  {'title': '论中国', 'cover': '41APiBzC41L.jpg', 'price': '36.6'},
  {'title': '饥饿的盛世：乾隆时代的得与失', 'cover': '51M6M87AXOL.jpg', 'price': '15.92'},
  {'title': '焚天之怒第4卷至大结局', 'cover': '51oIE7H5gnL.jpg', 'price': '56.9'},
  {'title': '我就是风口', 'cover': '51vzcX1U1FL.jpg', 'price': '88.8'},
  {'title': '大宋的智慧', 'cover': '517DW6EbhGL.jpg', 'price': '22.8'}
];


class _CardFreeState extends BaseCardState {


  @override
  bottomContainer() {
     return Expanded(child: Container(
       margin: EdgeInsets.only(top: 20),
       child: Column(
         children: [
           Expanded(child: _bookList()),
           Padding(
             padding: EdgeInsets.only(bottom: 20),
             child: _bottomButton(),
           )
         ],
       ),
     ));
  }

   _bookList() {
      return GridView.count(
          // 一行有多少个
        crossAxisCount: 3,
        // 垂直间距
        mainAxisSpacing: 10,
        // 水平间距
        crossAxisSpacing: 15,
        // 长宽必
        childAspectRatio: 0.46,
        padding: const EdgeInsets.only(left: 30, right: 20),
        children: BOOK_LIST.map((item) {
           return _item(item);
        }).toList(),
      );
  }
  
  Widget _item(Map<String, String> item) {
    return Container(
       child: Column(
         children: [
           // 绝对布局，与Positioned，一起使用
           Stack(
             alignment: AlignmentDirectional.center,
             children: [
               Image.network('http://www.devio.org/io/flutter_beauty/book_cover/${item['cover']}',
                 //fit: BoxFit.cover,
               ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black38,
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
               Positioned(
                 bottom: 0,
                   left: 0,
                   right: 0,
                   child: Container(
                     padding: EdgeInsets.all(3),
                     decoration: BoxDecoration(color: Colors.black54),
                     child: Text('原价${item['price']}',style: TextStyle(fontSize: 10,color: Colors.white),),
                   )
               ),
             ],
           ),
           Padding(padding: EdgeInsets.only(top: 10),
             child: Text(item['title']!, maxLines: 2,overflow:TextOverflow.ellipsis),
           )
         ],
       ),
    );
  }
  
  

  _bottomButton() {
    return FractionallySizedBox(
      widthFactor: 1,

      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: RaisedButton(onPressed: (){},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.only(top: 13, bottom: 15),
          color: Colors.blue,
          child: Text('免费领取',style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }



  @override
  topTitle(String title) {
    return super.topTitle('免费听书馆');
  }

  subTitle(String title) {
    // TODO: implement topTitle
    return super.subTitle('第 108 期');
  }

}
