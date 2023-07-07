import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'answer.dart';
import 'start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<Answer> answers = await readJsonFile();
  runApp(Main(answers: answers));
}

Future<List<Answer>> readJsonFile() async {
  try {
    String jsonPath = 'assets/data/answers.json';
    String jsonString = await rootBundle.loadString(jsonPath);
    List<dynamic> jsonList = json.decode(jsonString)['answer'];

    List<Answer> answers = [];
    for (var jsonObject in jsonList) {
      Answer answer = Answer(
        answer: jsonObject['answer'],
        id: jsonObject['id'],
      );
      answers.add(answer);
      log('Answer: ${answer.answer} (${answer.id})');
    }

    return answers;
  } catch (e) {
    log('Error reading JSON file: $e');
    return [];
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
