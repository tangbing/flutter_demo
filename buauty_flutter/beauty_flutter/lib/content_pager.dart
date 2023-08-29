
import 'package:beauty_flutter/card_recommend.dart';
import 'package:flutter/material.dart';
import 'package:beauty_flutter/custom_appbar.dart';
import 'package:flutter/services.dart';

import 'card_free.dart';
import 'card_share.dart';
import 'card_special.dart';

class ContentPager extends StatefulWidget {

  final ValueChanged<int> onPageChanged;
  final ContentPagerController contentPagerController;
  // 构造方法
  /*
  1.{},中的，说明是可选参数
  2.冒号后面，初始化列表
   */
  const ContentPager({Key? key, required this.onPageChanged, required this.contentPagerController}) : super(key: key);

  @override
  _ContentPagerState createState() => _ContentPagerState();
}

class _ContentPagerState extends State<ContentPager> {

  final PageController _pageController = PageController(
    /// 视图比例
    viewportFraction: 0.8
  );

  static final List<Color> _colors = [Colors.blue,
    Colors.red,
    Colors.green,
    Colors.greenAccent
  ];

  // initState是state创建的第一个方法
  @override
  void initState() {
    if (widget.contentPagerController != null){
      widget.contentPagerController._pageController = _pageController;
    }
    _statusBar();
    super.initState();
  }
  /// 状态栏- 沉浸式状态栏
  _statusBar(){
    // 黑色沉浸式状态栏，基于SystemUiOverlayStyle.dark修改了statusBarColor
    SystemUiOverlayStyle UiOverlayStyle = const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(UiOverlayStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //appBar
        CustomAppBar(),
        /// 高度撑开，否则在Column中没有高度会报错
        Expanded(child: PageView(
          onPageChanged: widget.onPageChanged,
          controller: _pageController,
          children: [
              _wrapItem(CardRecommend()),
              _wrapItem(CardShare()),
              _wrapItem(CardFree()),
              _wrapItem(CardSpecial())
          ],
        ))
      ],
    );
  }

  Widget _wrapItem(Widget widget){
    return Padding(padding: EdgeInsets.all(10), child: widget);
  }
}

class ContentPagerController {
  late PageController _pageController;
  void jumpToPage(int page) {
     _pageController?.jumpToPage(page);
  }
}
