import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(const MyApp());//one-line function
//StatefulWidget
class RandomEnglishWords extends StatefulWidget {
  const RandomEnglishWords({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RandomEnglishWordsState();//return a state's object. Where is the state's class ?
  }
}
//State
class RandomEnglishWordsState extends State<RandomEnglishWords>{
  final _words = <WordPair>[];//Words displayed in ListView, 1 row contains 1 word
  final _checkedWords = <WordPair>{};//set contains "no duplicate items"
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List infini"),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        if (index >= _words.length) {
          _words.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_words[index], index);//Where is _buildRow ?
      }),
    );
  }
  Widget _buildRow(WordPair wordPair, int index) {
    final textColor = index % 2 == 0 ? Colors.green : Colors.redAccent;
    final isChecked = _checkedWords.contains(wordPair);
    return ListTile(
      //leading = left, trailing = right. Is is correct ? Not yet
      leading: Icon(
          isChecked ? Icons.check_box : Icons.check_box_outline_blank,
          color: textColor,
      ),
      title: Text(
        wordPair.asUpperCase,
        style: TextStyle(fontSize: 18.0, color: textColor),
      ),
      onTap: () {
        setState(() {
          //This is an anonymous function
          if (isChecked) {
            _checkedWords.remove(wordPair);//Remove item in a Set
          } else {
            _checkedWords.add(wordPair);//Add item to a Set
          }
        });
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //build function returns a "Widget"
    return const MaterialApp(
      title: "Mon premier Workshop Flutter",
      home: RandomEnglishWords()
    );//Widget with "Material design"
  }
}