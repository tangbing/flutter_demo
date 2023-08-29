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
      title: 'Fade Demo',
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
      home: const MyFadeTest(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  const MyFadeTest({Key? key, required this.title}) : super(key: key);

  final String title;
  
  @override
  State<MyFadeTest> createState() => _MyFadeTestState();
}

class _MyFadeTestState extends State<MyFadeTest> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late CurvedAnimation curve;
  bool _animation = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 2000),
        vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _update() {
    setState(() {
      print("_animation:$_animation");
      if (_animation) {
         controller.forward();
      } else {
        controller.reverse();
      }
      _animation = !_animation;
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FadeTransition(
          opacity: curve,
          child: const FlutterLogo(size: 100.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _update();
        },
        tooltip: 'Fade',
        child: const Icon(Icons.brush),
      ),
    );
  }
}

