import 'package:flutter/material.dart';

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
      home: Scaffold(appBar: AppBar(title: Text("Animation demo")),
        body: const ScaleAnimationRoute(),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({Key? key, required this.animation, this.child}) : super(key: key);

  final Widget? child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}



class ScaleAnimationRoute extends StatefulWidget {
  const ScaleAnimationRoute({Key? key}) : super(key: key);

  @override
  State<ScaleAnimationRoute> createState() => _ScaleAnimationRouteState();
}

class AnimatedImage extends AnimatedWidget {
  const AnimatedImage({Key? key,
    required Animation<double> animation
  }) : super(key: key, listenable: animation);
  
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(child: Image.asset("imgs/avatar.png",
      width: animation.value,
      height: animation.value,
    ),
    );    
  }
}

// 需要继承TickerProvider， 如果有多个AnimationController，则应该使用TickerProviderStateMixin
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
        vsync: this);
    // 匀速，图片宽高从0到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
         controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
         controller.forward();
      }
    });

    // 启动动画，正向执行
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    //return AnimatedImage(animation: animation);
    return GrowTransition(
        child: Image.asset("imgs/avatar.png"),
        animation: animation);
  }

  @override
  void dispose() {
    // 路由销毁需要释放动画资源
    controller.dispose();
    super.dispose();
  }

}
