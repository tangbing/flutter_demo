import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

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
      home:  Scaffold(
            appBar: AppBar(title: Text('Listener')),
            body: const GestureRecognizer()
      ),
    );
  }
}

class GestureRecognizer extends StatefulWidget {
  const GestureRecognizer({Key? key}) : super(key: key);

  @override
  State<GestureRecognizer> createState() => _GestureRecognizerState();
}

class _GestureRecognizerState extends State<GestureRecognizer> {
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false; //变色开关

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(text: "你好世界"),
        TextSpan(text: "点我变色",
            style: TextStyle(fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
          recognizer: _tapGestureRecognizer..onTap = () {
              setState(() {
                _toggle = !_toggle;
              });
          },
        ),
        TextSpan(text: "hello world"),
      ])),
    );
  }
}



class ScaleTest extends StatefulWidget {
  const ScaleTest({Key? key}) : super(key: key);

  @override
  State<ScaleTest> createState() => _ScaleTestState();
}

class _ScaleTestState extends State<ScaleTest> {
  double _width = 200.0; // 通过修改图片宽度来达到缩放效果
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Image.asset('images/avatar.png', width: _width),
        onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              _width = 200 * details.scale.clamp(.8, 10.0);
            });
        },
      ),
    );
  }
}


class DragTest extends StatefulWidget {
  const DragTest({Key? key}) : super(key: key);

  @override
  State<DragTest> createState() => _DragTestState();
}

class _DragTestState extends State<DragTest> {
  double _top = 0.0; // 距顶部的偏移
  double _left = 0.0; // 距左边的偏移
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(child: Text("A")),
              // 手指按下时会触发此回调
              onPanDown: (DragDownDetails e) {
                // 打印手指按下的位置(相对于屏幕)
                print("用户手指按下: ${e.globalPosition}");
              },
             // 手指滑动时会触发此回调
             onPanUpdate: (DragUpdateDetails e) {
                // 用户手指滑动时，更新偏移，重新构建
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
             },

              onPanEnd: (DragEndDetails e) {
                // 打印滑动结束时在x， y轴上的速度
                print(e.velocity);
              },

            ))
      ],
    );
  }
}

class DragVertical extends StatefulWidget {
  const DragVertical({Key? key}) : super(key: key);

  @override
  State<DragVertical> createState() => _DragVerticalState();
}

class _DragVerticalState extends State<DragVertical> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: _top,
            child: GestureDetector(
              child: CircleAvatar(child: Text("A")),
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _top += details.delta.dy;
                });
              },
            ))
      ],
    );
  }
}



class GestureTest extends StatefulWidget {
  const GestureTest({Key? key}) : super(key: key);

  @override
  State<GestureTest> createState() => _GestureTestState();
}

class _GestureTestState extends State<GestureTest> {
  String _operation = "No Gesture detected!";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200.0,
          height: 100.0,
          child: Text(
            _operation,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => updateText("tap"),
        onDoubleTap: () => updateText("DoubleTap"),
        onLongPress: () => updateText("LongPress"),
      ),
    );
  }

  void updateText(String text) {
    // 更新显示的事件名
    setState(() {
      _operation = text;
    });
  }
}



class PointerMoveIndicatorState extends StatefulWidget {
  const PointerMoveIndicatorState({Key? key}) : super(key: key);

  @override
  State<PointerMoveIndicatorState> createState() => _PointerMoveIndicatorStateState();
}

class _PointerMoveIndicatorStateState extends State<PointerMoveIndicatorState> {
  PointerEvent? _event;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('Listener')),
  //     body: Listener(
  //       child: Container(
  //         alignment: Alignment.center,
  //         color: Colors.blue,
  //         width: 300,
  //         height: 300,
  //         child: Text(
  //           '${_event?.localPosition ?? ''}',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //       onPointerDown: (PointerDownEvent event) => setState(() => _event = event),
  //       onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
  //       onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
  //     ),
  //   );
  // }

  /*
  忽略指针事件: 使用IgnorePointer和AbsorbPointer，
  这两个组件都能阻止子树接收指针事件，不同之处在于AbsorbPointer本身会参与命中测试，
  而IgnorePointer本身不会参与，这就意味着AbsorbPointer本身是可以接收指针事件的(但其子树不行)，
  而IgnorePointer不可以
   */
  @override
  Widget build(BuildContext context) {
    return Listener(
        child: IgnorePointer(
          child: Listener(
            child: Container(
              color: Colors.red,
              width: 200,
              height: 100,
            ),
            onPointerDown: (event) => print('in'),
          ),
        ),
        onPointerDown: (event) => print('up'),
      );
  }
}
