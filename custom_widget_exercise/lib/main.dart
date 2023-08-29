import 'dart:math';

import 'package:custom_widget_exercise/render_object_animation_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("TurnBoxRoute Demo")),
        body: const CustomChecboxTest(),
      ),
    );
  }
}

class CustomChecboxTest extends StatefulWidget {
  const CustomChecboxTest({Key? key}) : super(key: key);

  @override
  State<CustomChecboxTest> createState() => _CustomChecboxTestState();
}

class _CustomChecboxTestState extends State<CustomChecboxTest> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCheckbox(value: _checked, onChanged: _onChange),
          Padding(padding: EdgeInsets.all(18.0),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CustomCheckbox(
                  strokeWidth: 1,
                  radius: 1,
                  value: _checked,
                  onChanged: _onChange,
                ),
              ),
            ),
          SizedBox(
            width: 30,
            height: 30,
            child: CustomCheckbox(
              strokeWidth: 3,
              radius: 3,
              value: _checked,
              onChanged: _onChange,
            ),
          ),
        ],
      ),
    );
  }

  void _onChange(value) {
    setState(() {
      print("_onChange: $value");
      _checked = value;
    });
  }
}


class CustomCheckbox extends LeafRenderObjectWidget {
  const CustomCheckbox({
    Key? key,
    this.strokeWidth = 2.0,
    this.value = false,
    this.strokeColor = Colors.white,
    this.fillColor = Colors.blue,
    this.radius = 2.0,
    this.onChanged,
}) : super(key: key);

  final double strokeWidth;
  final Color strokeColor;
  final Color? fillColor;
  final bool value;
  final double radius;
  final ValueChanged<bool>? onChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCheckbox(strokeWidth, strokeColor, fillColor ?? Theme.of(context).primaryColor, value, radius, onChanged);
  }

  @override
  void updateRenderObject(BuildContext context, RenderCustomCheckbox renderObject) {

      renderObject
        ..strokeWidth = strokeWidth
        ..strokeColor = strokeColor
        ..fillColor = fillColor ?? Theme.of(context).primaryColor
        ..radius = radius
        ..value = value
        ..onChanged = onChanged;

      if(renderObject.value != value) {
        renderObject.animationStatus = value ? AnimationStatus.forward : AnimationStatus.reverse;
      }
  }
}

class RenderCustomCheckbox extends RenderBox with RenderObjectAnimationMixin {
  bool value;
  int pointerId = -1;
  double strokeWidth;
  Color strokeColor;
  Color fillColor;
  double radius;
  ValueChanged<bool>? onChanged;

  RenderCustomCheckbox(this.strokeWidth, this.strokeColor, this.fillColor, this.value, this.radius, this.onChanged) : progress = value ? 1 : 0;

  @override
  bool get isRepaintBoundary => true;

  //背景动画时长占比（背景动画要在前40%的时间内执行完毕，之后执行打勾动画）
  final double bgAnimationInterval = .4;

  @override
  void doPaint(PaintingContext context, Offset offset) {
    Rect rect = offset & size;
    _drawBackground(context, rect);
    _drawCheckMark(context, rect);
  }

  // 下面的属性用于调度动画
  double progress = 0;// 动画当前进度
  int? _lastTimeStamp;//上一次绘制的时间

  //布局
  @override
  void performLayout() {
    print("performLayout");
    size = constraints.constrain(
      constraints.isTight ? Size.infinite : Size(25, 25)
    );
   // markNeedsPaint(); // 标记需要重新绘制
  }
    @override
    bool hitTestSelf(Offset position) => true;

    // 只有通过点击测试的组件才会调用本方法
    @override
    void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
      print("handleEvent click");
      super.handleEvent(event, entry); // 调用父类的handleEvent方法以确保事件处理的正确传递
      // if(event.down) {
      //     pointerId = event.pointer;
      //   } else if(pointerId == event.pointer) {
      //     if(size.contains(event.localPosition)) {
      //       onChanged?.call(value);
      //     }
      //   }

      if(event is PointerDownEvent) {
        if(size.contains(event.localPosition)) {
          onChanged?.call(!value); // 切换选中状态
          markNeedsPaint(); // 标记需要重新绘制
        }
      }
    }

  @override
  void paint(PaintingContext context, Offset offset) {
      print("paint object");
    Rect rect = offset & size;
    // 将绘制分为背景（矩形）和 前景（打勾）两部分，先画背景，再绘制'勾'
    _drawBackground(context, rect);
    _drawCheckMark(context, rect);
      markNeedsPaint(); // 标记需要重新绘制

  }

  // 画背景
  void _drawBackground(PaintingContext context, Rect rect) {
    Color color = value ? fillColor : Colors.grey;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..strokeWidth
      ..color = color;

    // 我们需要算出每一帧里面矩形的大小，为此我们可以直接根据矩形插值方法来确定里面矩形
    final outer = RRect.fromRectXY(rect, radius, radius);
    var rects = [
      rect.inflate(-strokeWidth),
      Rect.fromCenter(center: rect.center, width: 0, height: 0)
    ];
    // 根据动画执行进度调整来确定里面矩形在每一帧的大小
    var rectProgress = Rect.lerp(rects[0], rects[1], min(progress, bgAnimationInterval) / bgAnimationInterval);

    final inner = RRect.fromRectXY(rectProgress!, 0, 0);
    // 绘制
    context.canvas.drawDRRect(outer, inner, paint);
  }

  //画 "勾"
  void _drawCheckMark(PaintingContext context, Rect rect) {
    // 在画好背景后再画前景
    if(customProgress > bgAnimationInterval) {
      print("customProgress:${customProgress}");
      //确定中间拐点位置
      final secondOffset = Offset(rect.left + rect.right / 2.5, rect.bottom - rect.height / 4);

      // 第三个点的位置
      final lastOffset = Offset(rect.right - rect.width / 6,
                                rect.top + rect.height / 4);

      // 我们只对第三个点的位置做插值
      final _lastOffset = Offset.lerp(secondOffset, lastOffset, (progress - bgAnimationInterval) / (1 - bgAnimationInterval))!;

      final path = Path()
        ..moveTo(rect.left + rect.width / 7, rect.top + rect.height / 2)
        ..lineTo(secondOffset.dx, secondOffset.dy)
        ..lineTo(_lastOffset.dx, _lastOffset.dy);

      final paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..color = strokeColor
        ..strokeWidth = strokeWidth;

      context.canvas.drawPath(path, paint..style = PaintingStyle.stroke);
    }
  }
}


class GradientCircularProgressRoute extends StatefulWidget {
  const GradientCircularProgressRoute({Key? key}) : super(key: key);

  @override
  State<GradientCircularProgressRoute> createState() => _GradientCircularProgressRouteState();
}

class _GradientCircularProgressRouteState extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.forward) {
        isForward = true;
      } else if(status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        if(isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if(status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(animation: _animationController,
                builder: (BuildContext context, child) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 10.0,
                            runSpacing: 16.0,
                            children: [
                              GradientCircularProgressIndicator(radius: 50.0,
                                  colors: [Colors.blue, Colors.blue],
                                  strokeWidth: 3.0,
                                  value: _animationController.value),
                              GradientCircularProgressIndicator(radius: 50.0,
                                  colors: [Colors.red, Colors.orange],
                                  strokeWidth: 3.0,
                                  value: _animationController.value),
                              GradientCircularProgressIndicator(radius: 50.0,
                                  colors: [Colors.red, Colors.orange, Colors.red],
                                  strokeWidth: 3.0,
                                  value: _animationController.value),
                              GradientCircularProgressIndicator(radius: 50.0,
                                  colors: [Colors.teal, Colors.cyan],
                                  strokeWidth: 5.0,
                                  strokeCapRound: true,
                                  value: CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.decelerate
                                  ).value,
                              ),
                              TurnBox(
                                  turns: 1/ 8,
                                  child: GradientCircularProgressIndicator(
                                    colors: const [Colors.red, Colors.orange, Colors.red],
                                    radius: 50.0,
                                    strokeWidth: 5.0,
                                    strokeCapRound: true,
                                    backgroundColor: Colors.red.shade50,
                                    totalAngle: 1.5 * pi,
                                    value: CurvedAnimation(
                                      parent: _animationController,
                                      curve: Curves.ease
                                    ).value,
                                  ),
                              ),
                              RotatedBox(quarterTurns: 1,
                                        child: GradientCircularProgressIndicator(
                                          colors: [Colors.blue.shade700, Colors.blue.shade200],
                                          radius: 50.0,
                                          strokeWidth: 3.0,
                                          strokeCapRound: true,
                                          backgroundColor: Colors.transparent,
                                          value: _animationController.value,
                                        ),
                              ),
                              GradientCircularProgressIndicator(
                                colors: [
                                  Colors.red,
                                  Colors.amber,
                                  Colors.cyan,
                                  Colors.green.shade200,
                                  Colors.blue,
                                  Colors.red
                                ],
                                radius: 50.0,
                                strokeWidth: 5.0,
                                strokeCapRound: true,
                                value: _animationController.value,
                              ),
                            ],
                          ),
                          GradientCircularProgressIndicator(
                            colors: [Colors.blue.shade700, Colors.blue.shade200],
                            radius: 100.0,
                            strokeWidth: 20.0,
                            value: _animationController.value,
                          ),
                          Padding(padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: GradientCircularProgressIndicator(
                              colors: [Colors.blue.shade700, Colors.blue.shade300],
                              radius: 100.0,
                              strokeWidth: 20.0,
                              value: _animationController.value,
                              strokeCapRound: true,
                            ),
                          ),
                          // 裁剪半圆
                          ClipRRect(
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: .5,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  child: TurnBox(
                                    turns: .75,
                                    child: GradientCircularProgressIndicator(
                                      colors: [Colors.teal, Colors.cyan.shade500],
                                      radius: 100.0,
                                      strokeWidth: 8.0,
                                      value: _animationController.value,
                                      totalAngle: pi,
                                      strokeCapRound: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 104,
                            width: 200.0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                    height: 200.0,
                                    top: .0,
                                    child: TurnBox(
                                      turns: .75,
                                      child: GradientCircularProgressIndicator(
                                        colors: [Colors.teal, Colors.cyan.shade500],
                                        radius: 100.0,
                                        strokeWidth: 8.0,
                                        value: _animationController.value,
                                        totalAngle: pi,
                                        strokeCapRound: true,
                                      ),
                                    ),
                                ),
                                Padding(padding: const EdgeInsets.only(top: 0.0),
                                        child: Text("${(_animationController.value * 100).toInt()}%",
                                            style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  );
                }
                ),
          ],
        ),
      ),
    );
  }
}


class GradientCircularProgressIndicator extends StatelessWidget {
  const GradientCircularProgressIndicator(
      {Key? key,
      this.strokeWidth = 2.0,
      required this.radius,
      required this.colors,
        this.stops,
      this.strokeCapRound = false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.totalAngle = 2 * pi,
      required this.value,
      }) : super(key: key);

  // 粗细
  final double strokeWidth;

  // 圆的半径
  final double radius;

  // 两端是否为圆角
  final bool strokeCapRound;

  // 当前进度，取值范围【0.0-1.0】
  final double value;
  
  // 进度条背景色
  final Color backgroundColor;
  
  // 进度条的总弧度，2*PI为圆，小于2*PI则不是整圆
  final double totalAngle;
  
  // 渐变色数组
  final List<Color> colors;
  
  // 渐变色的终止点，对应colors属性
  final List<double>? stops;

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    // 如果两端为圆角，则需要对起始位置进行调整，否则圆角部分会偏离起始位置
    // 下面调整的角度的计算公式是通过数学几何知识得出，读者有兴趣可以研究一下为什么是这样  
    if(strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).colorScheme.secondary;
      _colors = [color, color];
    }
    return Transform.rotate(
        angle: -pi / 2.0 - _offset,
        child: CustomPaint(
          size: Size.fromRadius(radius),
          painter: _GradientCircularProgressPainter(
            strokeWidth: strokeWidth,
              strokeCapRound: strokeCapRound,
              backgroundColor: backgroundColor,
              value: value,
              total: totalAngle,
              radius: radius,
              colors: colors),
        ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter({
   this.strokeWidth = 10.0,
   this.strokeCapRound = false,
   this.backgroundColor = const Color(0xFFEEEEEE),
    this.radius,
    this.total = 2 * pi,
    required this.colors,
    this.stops,
    this.value
});

  final double strokeWidth;
  final bool strokeCapRound;
  final double? value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double? radius;
  final List<double>? stops;

  @override
  void paint(Canvas canvas, Size size) {
    if(radius != null) {
      size = Size.fromRadius(radius!);
    }
    double _offset = strokeWidth / 2.0;
    double _value = value ?? .0;
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if(strokeCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) & Size(size.width - strokeWidth,
        size.height - strokeWidth);

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    //先画背景
    if(backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    if(_value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0.0,
          endAngle: _value,
          stops: stops,
          colors: colors).createShader(rect);

      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  //简单返回true，实践中应该根据画笔属性是否变化来确定返回true还是false
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}



class CustomPaintRoute extends StatelessWidget {
  const CustomPaintRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(
            size: Size(300, 300),
            painter: MyPainter(),
          ),
          RepaintBoundary(child: ElevatedButton(onPressed: () {} , child: Text("refresh")))
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    print("paint");
    var rect = Offset.zero & size;
    // 画棋盘
    drawChessboard(canvas, rect);
    // 画棋子
    drawPieces(canvas, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void drawChessboard(Canvas canvas, Rect rect) {
      var paint = Paint()
          ..isAntiAlias = true
          ..style = PaintingStyle.fill
          ..color = Color(0xFFDCC48C);
      canvas.drawRect(rect, paint);

      // 画棋盘网格
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black38
      ..strokeWidth = 1.0;


    for(int i = 0; i <= 15; ++i) {
      double dy = rect.top + rect.height / 15 * i;
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
    }

    for(int i = 0; i <= 15; ++i) {
      double dx = rect.left + rect.width / 15 * i;
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
    }
  }

  void drawPieces(Canvas canvas, Rect rect) {
      double eWidth = rect.width / 15;
      double eHeight = rect.height / 15;
      // 画一个黑子
      var paint = Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.black;

      canvas.drawCircle(Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
          min(eWidth / 2, eHeight / 2 - 2), paint);

      // 画一个白子
      paint.color = Colors.white;
      canvas.drawCircle(Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
          min(eWidth / 2, eHeight / 2) - 2, paint);
  }
}


class GradientButton extends StatelessWidget {
  const GradientButton({Key? key,
        this.colors,
        this.width,
        this.height,
        this.onPressed,
        this.borderRadius,
        required this.child,
  }) : super(key: key);

  // 渐变色数组
  final List<Color>? colors;

  // 按钮宽高
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  // 点击回调
  final GestureTapCallback? onPressed;

  final Widget child;


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    // 确保colors数组不空
    List<Color> _colors = colors ?? [theme.primaryColor, theme.primaryColorDark];
    return DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius,
        ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientButtonRoute extends StatefulWidget {
  const GradientButtonRoute({Key? key}) : super(key: key);

  @override
  State<GradientButtonRoute> createState() => _GradientButtonRouteState();
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientButton(
            colors: [Colors.orange, Colors.red],
            height: 50,
            onPressed: onTap,
            child: Text("Submit")),
        GradientButton(
            height: 50,
            onPressed: onTap,
            colors: [Colors.lightGreen, Colors.green.shade700],
            child: Text("Submit")),
        GradientButton(
            height: 50,
            colors: [Colors.lightGreen.shade300, Colors.blueAccent],
            onPressed: onTap,
            child: Text("Submit"))
      ],
    );
  }

  onTap() => print("button click");
}

class TurnBox extends StatefulWidget {
  const TurnBox({Key? key,
                this.turns = .0,
                this.speed = 200,
                required this.child
  }) : super(key: key);

  final double turns;
  final int speed;
  final Widget child;

  @override
  State<TurnBox> createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
      _controller = AnimationController(vsync: this,
          lowerBound: -double.infinity,
          upperBound: double.infinity
      );
      _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _controller, child: widget.child);
  }

  @override
  void didUpdateWidget(covariant TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(milliseconds: widget.speed?? 200),
            curve: Curves.easeOut,
          );
    }
  }
}

class TurnBoxRoute extends StatefulWidget {
  const TurnBoxRoute({Key? key}) : super(key: key);

  @override
  State<TurnBoxRoute> createState() => _TurnBoxRouteState();
}

class _TurnBoxRouteState extends State<TurnBoxRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            TurnBox(
              turns: _turns,
              speed: 500,
              child: Icon(
                Icons.refresh,
                size: 50,
              ),
            ),
            TurnBox(
              turns: _turns,
              speed: 1000,
              child: Icon(
                Icons.refresh,
                size: 150,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _turns += .2;
                  });
                },
                child:  Text("顺时针旋转1/5圈")
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _turns -= .7;
                  });
                },
                child:  Text("逆时针旋转1/7圈")
            ),
          ],
        ),
      ),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
