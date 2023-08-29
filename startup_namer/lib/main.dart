import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Startup Name Generator11',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup name generator'),
        actions: [
          IconButton(onPressed: _pushPress, icon: Icon(Icons.list)),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushPress() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final result_tiles = _saved.map(
                (pair) {
              return new ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
            context: context,
            tiles: result_tiles,
          )
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  // void _pushPress() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(builder: (context) {
  //         final titles = _saved.map((pair) {
  //           return ListTile(
  //              title: Text(
  //                pair.asPascalCase,
  //                style: _biggerFont,
  //              ),
  //           );
  //         });
  //     }
  //     ),
  //   );



  Widget _buildSuggestions(){

    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
      if (i.isOdd) return Divider();

      final index = i ~/ 2;
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);
    }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadSaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadSaved ? Icons.favorite : Icons.favorite_border,
        color: alreadSaved ? Colors.red : null,
      ),
      onTap: (){
        /// 在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，从而导致对UI的更新
        setState(() {
          if (alreadSaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
  
}

