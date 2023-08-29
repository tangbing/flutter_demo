
import 'package:flutter/cupertino.dart';
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String selectStr = "对话框2";

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  bool? result = await showDailog1();
                  if (result == null) {
                    print("取消删除");
                  } else {
                    print("已确认删除");
                  }

                  // showDialog<bool>(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       var child = Column(children: [
                  //         ListTile(title: Text("请选择")),
                  //         Expanded(
                  //           child: ListView.builder(
                  //             itemCount: 50,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return ListTile(
                  //                   title: Text("$index"),
                  //                   onTap: () =>
                  //                       Navigator.of(context).pop(index));
                  //             },
                  //           ),
                  //         ),
                  //       ]);
                  //
                  //       return UnconstrainedBox(
                  //         constrainedAxis: Axis.vertical,
                  //         child: ConstrainedBox(
                  //           constraints: BoxConstraints(maxWidth: 280),
                  //           child: Material(
                  //             child: child,
                  //             type: MaterialType.card,
                  //           ),
                  //         ),
                  //       );
                  //     });
                },
                child: Text("对话框1")),
            ElevatedButton(onPressed: () async {
              int? result = await changeLanguage(context);
              if (result != null) {
                print("select: ${result == 1 ? "中文简体" : "美国英语"}");
                setState(() {
                  selectStr = result == 1 ? "中文简体" : "美国英语";
                });
              }
            }, child: Text(selectStr)),

            ElevatedButton(onPressed: () async {
              showListDailog();
            }, child: Text("长列表对话框")),

            ElevatedButton(onPressed: () async {
                 bool? delete = await showDeleteConfirmDialog();
                 if (delete == null) {
                   print("取消删除");
                 } else {
                   print("同时删除子目录: $delete");
                 }
                 
            }, child: Text("选中对话框")),

            ElevatedButton(onPressed: () async {
              int? result = await _showModalBottomSheet();
              if (result == null) {
                print("取消");
              } else {
                print("select index: $result");
              }

            }, child: Text("弹出底部菜单列表模态对话框")),

            ElevatedButton(onPressed: () async {
              showCustomLoadingDialog();

            }, child: Text("show loading")),


            ElevatedButton(onPressed: () async {

              _showIOSDatePicker1();

              // DateTime? date = await _showDatePicker1();
              // if (date != null) {
              //    String dmtDateTime = date.toString();
              //    print('select: ${dmtDateTime}');
              // }
            }, child: Text("显示ios风格的日历选择器")),

          ],
        ),
      ),
    );
    }

    Future<DateTime?> _showDatePicker1() {
      var date = DateTime.now();
      return showDatePicker(context: context,
          initialDate: date,
          firstDate: date,
          lastDate: date.add(Duration(days: 30)));
    }


  Future<DateTime?> _showIOSDatePicker1() {
    var date = DateTime.now();
    return showCupertinoModalPopup(context: context,
        builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
             mode: CupertinoDatePickerMode.dateAndTime,
             minimumDate: date,
              maximumDate: date.add(Duration(days: 30)),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
               print(value);
            },
          )

        );
    });
  }

  void showLoadingDialog() {
    showDialog(context: context,
        builder: (context) {
          return AlertDialog(content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Padding(padding: EdgeInsets.only(top: 26),
                child: Text("loading, wait a while"),
              )
            ],
          ));
        });
  }

    void showCustomLoadingDialog() {
        showDialog(context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
              width: 240,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(value: .8),
                    Padding(padding: EdgeInsets.only(top: 26), child: Text("正在加载，请稍后...")),
                  ],
                ),
              ),
            ),
          );
        });
    }


    Future<int?> _showModalBottomSheet() {
       return showModalBottomSheet(context: context,
           builder: (BuildContext context) {
                return ListView.builder(
                  itemCount: 50,
                  itemBuilder: (BuildContext context,
                    int index) {
                    return ListTile(title: Text("$index"),
                      onTap: () => Navigator.of(context).pop(index),
                    );
                  });
           });
    }
    
  Future<bool?> showDeleteConfirmDialog() async {
    bool _withTree = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("您确定要删除当前文件吗?"),
                Row(children: [
                  Text("同时删除子目录？"),
                  Builder(
                    builder: (BuildContext context) {
                      return Checkbox(value: _withTree, onChanged: (bool? value) {
                        (context as Element).markNeedsBuild();
                        _withTree = !_withTree;
                      });
                    },
                  ),

                  // 第二种
                  // StatefulBuilder(builder: (context, _setState) {
                  //   return Checkbox(value: _withTree, onChanged: (bool? value) {
                  //     _setState((){
                  //       _withTree = !_withTree;
                  //     });
                  //   });
                  // })

                  // 第一种
                  // DialogCheckbox(value: _withTree,
                  //     onChanged: (bool? value) {
                  //       setState(() {
                  //         _withTree = !_withTree;
                  //       });
                  //     }),
                ]),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("取消")),
              TextButton(onPressed: () => Navigator.of(context).pop(_withTree), child: Text("删除"))
            ],
          );
        },
    );
  }


  Future<T?> showCustomDialog<T>({
    required BuildContext context,
    bool barrierDismiissible = false,
    required WidgetBuilder builder,
    ThemeData? theme,
  }) {
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          final Widget pageChild = Builder(builder: builder);
          return SafeArea(child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
          );
        },
        barrierDismissible:  barrierDismiissible,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black87,
        transitionDuration: Duration(milliseconds: 150),
         transitionBuilder: _buildMaterialDialogTransitions,

        );
  }

  Widget _buildMaterialDialogTransitions(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) {
    return ScaleTransition(scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ), child: child);
  }

  Future<int?> changeLanguage(BuildContext context) async {
    return showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("对话框2"),
            children: [
              SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text('中文简体'),
                  )),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('美国英文'),
                ),
              )
            ],
          );
        });
  }

  Future<bool?> showDailog1() {
     return showCustomDialog<bool>(context: context, builder: (BuildContext context) {
       return AlertDialog(
         title: Text("提示"),
         content: Text("11提示提示提示提示提示提示"),
         actions: [
           TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("取消")),
           TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text("删除")),

         ],
       );
     });
  }

  Future<void> showListDailog() async {
    int? index = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        var child = Column(children: [
          ListTile(title: Text("请选择")),
          Expanded(
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text("$index"),
                    onTap: () => Navigator.of(context).pop(index));
              },
            ),
          ),
        ]);
        return Dialog(child: child);
      },
    );
    if (index != null) {
      print("select: $index");
    }
  }
}

// class StatefulBuilder extends StatefulWidget {
//   const StatefulBuilder({
//     Key? key,
//     required this.builder,
// }) : assert(builder != null),
//   super(key: key)
// }

class StatefulBuilder extends StatefulWidget {
  const StatefulBuilder({Key? key,
    required this.builder,}) : assert(builder != null), super(key: key);

  final StatefulWidgetBuilder builder;

  @override
  State<StatefulBuilder> createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, setState);
  }
}


// 单独抽离出StatefulWidget
class DialogCheckbox extends StatefulWidget {
  const DialogCheckbox({Key? key, this.value, required this.onChanged}) : super(key: key);

  final ValueChanged<bool?> onChanged;
  final bool? value;

  @override
  State<DialogCheckbox> createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool? value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: value,
        onChanged: (v) {
          // 将选中状态通过事件的形式抛出
          widget.onChanged(v);
          setState(() {
            // 更新自设选中状态
            value = v;
          });
        });
  }
}
