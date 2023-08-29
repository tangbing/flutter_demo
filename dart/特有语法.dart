void main(List<String> args) {
  var pp = Person("tb", 1111);
  print(pp);
  print(pp.run()); 
}

// class Person {
//   String name = "tb";
//   static final Map<String, Person> _cache = <String, Person>{};

//   factory Person(String name) {
//     if (_cache.containsKey(name)) {
//       return _cache[name];
//     } else {
//       final p = Person._internal(name);
//       _cache[name] = p;
//       return p;
//     }
//   }

//   Person._internal(this.name);
// }

class Animal {
  int age;

  Animal(this.age);

  run() {
    print('在奔跑ing');
  }
}

class Person extends Animal {
  String name = "tb";

  Person(String name, int age)
      : name = name,
        super(age);

  @override
  run() {
    // TODO: implement run
    print("$name在奔跑ing");
  }

  @override
  String toString() {
    // TODO: implement toString
    return "name=$name, age=$age";
  }
}
