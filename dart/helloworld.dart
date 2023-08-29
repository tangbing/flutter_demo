class Person {
  const Person();
}

main(List<String> args) {
  print("helloworld");

  var name = "tb";
  name = "Hello World";
  name = "jkjk";
  print(name);

  // runtime
  dynamic add = "xxxxxwww";
  print(add.runtimeType);

  add = 1122;
  print(add.runtimeType);

  // final与const
  /*
  const在赋值时，赋值的内容必须是在编译期间就确定下来的
  final在赋值时，可以动态获取，比如赋值一个函数
  */
  // final age = 113;
  // age = 989;

  // const phone = 1111;
  // phone = 44444;

  final time = DateTime.now();
  print(time);
  // sleep(Duration(seconds: 2));
  // print(time);

  // const可以共享变量，提高性能
  final a = const Person();
  final b = const Person();
  print(identical(a, b));

  final m = Person();
  final n = Person();
  print(identical(m, n));

// 数据类型
  int age1 = 199;
  int hexAge = 0x12;
  print(age1);
  print(hexAge);

  double height = 1.99;
  print(height);

// 1. 字符串转数字
  var one = int.parse("1234");
  var two = double.parse("1234.111");
  print("${one} ${one.runtimeType}");

// 2. 数字转字符串
  var num1 = 123;
  var num2 = 123.456;
  var num1Str = num1.toString();
  var num2Str = num2.toString();
  print("${num1Str}, ${num1Str.runtimeType}");
  print("${num2Str}, ${num2Str.runtimeType}");

// bool, 不能判断非0即真
// var message = "是是是";
// if （message） {
//   print(message);
// }
// 字符串

  var message1 = '''
1111123333
3333333
gffffffff
''';

  //print(message1);

  /// 集合操作
  var letters = ["a", "b", "c", "d"];
  print("$letters ${letters.runtimeType}");

  List<int> numbers = [1, 2, 3, 4, 5];
  print(numbers.length);
  print("$numbers ${numbers.runtimeType}");

  var lettersSet = {'a', 'b', 'c', 'd'};
  print('$lettersSet ${lettersSet.runtimeType}');

  Set numbersSet = {'1', '2', '3', '4'};
  print('$numbersSet ${numbersSet.runtimeType}');

  var infoMap = {'name': 'tb', 'age': 28};
  print('length: ${infoMap.length}');
  print('$infoMap ${infoMap.runtimeType}');

  Map<String, Object> infoMap2 = {'height': 1.99, 'address': 'ssssssss'};
  print(infoMap2.length);
  print('$infoMap2 ${infoMap2.runtimeType}');
  print('address: ${infoMap2['address']}');

  print('${infoMap2.entries}');
  print('${infoMap2.keys}');
  print('${infoMap2.values}');

  infoMap2.remove('address');
  print(infoMap2);

  // int sum(num1, num2) {
  //   return num1 + num2;
  // }
  // 如果函数中只有一个表达式，那么可以使用箭头语法，注意，这里面只能是一个表达式，不能是一个语句
  sum(num1, num2) => num1 + num2;

  var result = sum(11, 22);
  print(result);

  // 函数参数问题, 分成两类：必须参数和可选参数

  // 可选参数可以分为 命名可选参数和位置可选参数

// 命名可选参数
  printinfo1(String name, {int? age1, double? height1}) {
    print('name=$name age=$age1 height=$height1');
  }

  printinfo1('tb');
  printinfo1('tb', age1: 18);
  printinfo1('tb', age1: 18, height1: 1.888);
  printinfo1('tbb', height1: 1.88);

  // 位置可选参数
  printInfo2(String name, [int? age, double? height]) {
    print('name=$name age=$age height=$height');
  }

  printInfo2('tb');
  printInfo2('tb', 18);
  printInfo2('tbb', 18, 1.99);

  // printInfo3(String name,
  //     {int? age, double? height, @required String? address}) {
  //   print('name=$name age=$age, height=$height address=$address');
  // }

  printInfo4(String name, {int age = 18, double height = 1.99}) {
    print('name=$name age=$age height=$height');
  }

  var movies = ['盗梦空间', '星际穿越', '少年派', '大话西游'];

  printElement(item) {
    print(item);
  }

  movies.forEach(printElement);

  print('====================');
  movies.forEach((item) {
    print(item);
  });

  movies.forEach((item) => print(item));

  makeAddr(num addBy) {
    return (num i) {
      return i + addBy;
    };
  }

  var addr = makeAddr(2);
  print(addr(10));

  var addr2 = makeAddr(5);
  print(addr2(6));
  print(addr2(16));
  print(addr2(16));

  print("end....");

// 位置可选参数
  eat(int age, [int? age1, int? age2]) {}

  eat(12, 1, 2);

// 命名可选参数
  sleep(int sleep, {int? sleep1, int? sleep2}) {
    print("sleep: $sleep, sleep1: $sleep1, sleep2: $sleep2");
  }

  sleep(1, sleep1: 111, sleep2: 12222);

// 匿名函数
  void test(void foo(String name)) {
    foo("tbb");
  }

  // void caculator(int add(int num1, int num2)) {
  //   print("caculator");
  //   add(20, 30);
  // }

  // caculator((num1, num2) {
  //   return num1 + num2;
  // });

  //typedef Calculate = int Function(int num1, int num2);

  // void caculator() {
  //   print("caculator");
  //   add(20, 30);
  // }

  test((name) {
    print(name);
  });

  //var p = Personer("tb", 28);
  var p = Personer();
  print(p);

  var p2 = Personer.withArgments("tbb", 29);
  print(p2);

  var pp = TbPerson.fromName("tb");
  print(pp.name);
  print(pp.age);

  var tbbp = const TBPerson('tb');
  var tbbp1 = const TBPerson('tb');
  print(identical(tbbp, tbbp1));
}

class Personer {
  String? name;
  int? age;

  // Personer(String name, int age) {
  //   this.name = name;
  //   this.age = age;
  // }
  // 为了简化这一过程, Dart提供了一种更加简洁的语法糖形式
  //Personer(this.name, this.age);

  Personer() {
    name = '';
    age = 0;
  }

  /*
  因为不支持方法（函数）的重载，所以我们没办法创建相同名称的构造方法。
  我们需要使用命名构造方法:
  */
  Personer.withArgments(String name, int age) {
    this.name = name;
    this.age = age;
  }

  Personer.fromMap(Map<String, Object> map) {
    this.name = (map['name'] ?? Object()) as String?;
    this.age = (map['age'] ?? Object()) as int?;
  }

  @override
  String toString() {
    return "name=$name age=$age";
  }
}

class Point {
  final num x = 0.0;
  final num y = 0.0;
  final num distance = 0.0;

  // Point(this.x, this.y) {
  //   distance = sqrt(x * x + y * y);
  // }

  //Point(this.x, this.y) : distance = sqrt(x * x + y * y);
}

class TbPerson {
  String name = "";
  int age = 0;

  TbPerson(this.name, this.age);
  //  重定向构造方法
  TbPerson.fromName(String name) : this(name, 0);
}

class TBPerson {
  String name = "";

  //const TBPerson(this.name);
}
