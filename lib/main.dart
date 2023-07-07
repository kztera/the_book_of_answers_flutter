import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'answer.dart';
import 'screens/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<Answer> answers = await readJsonFile();
  runApp(Main(answers: answers));
}

Future<List<Answer>> readJsonFile() async {
  try {
    String jsonString =
        await rootBundle.loadString('assets/data/answers_2.json');
    final data = jsonDecode(jsonString);

    List<Answer> answerList = [];
    for (var item in data['answer']) {
      Map<String, String> answerTexts =
          Map<String, String>.from(item['answerTexts']);
      Answer answer = Answer(id: item['id'], answerTexts: answerTexts);
      answerList.add(answer);
    }

    return answerList;
  } catch (e) {
    log('Error reading JSON file: $e');
    return []; // Return an empty list in case of an error
  }
}

class Main extends StatelessWidget {
  final List<Answer> answers;

  const Main({Key? key, required this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StartScreen(answers: answers),
      ),
    );
  }
}
