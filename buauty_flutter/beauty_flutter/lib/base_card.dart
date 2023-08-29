


import 'package:flutter/material.dart';

/// 卡片基类
class BaseCard extends StatefulWidget {
  const BaseCard({Key? key}) : super(key: key);

  @override
  BaseCardState createState() => BaseCardState();
}

class BaseCardState extends State<BaseCard> {
  Color subTitleColor = Colors.grey;
  Color bottomTitleColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias, //抗锯齿
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
           children: [
             topContainer(),
             bottomContainer(),
           ],
        ),
      ),
    );
  }

  topContainer() {
    return Padding(padding: EdgeInsets.only(left: 20,top: 25, bottom: 20),
      child: Column(
        // 沿着x轴，左边对其
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              topTitle(''),
              topRightTitle('')
            ],
          ),
          subTitle('')
        ],
      ),
    );
  }

  bottomContainer() {
    return Container();
  }

  Widget subTitle(String title) {
    return Padding(padding: EdgeInsets.only(top: 5),
    child: Text(title, style: TextStyle(fontSize: 11,color: subTitleColor)));
  }

  topTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 22));
  }

  topRightTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 12),);
  }

  bottomTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 12,color: bottomTitleColor),);
  }

}
