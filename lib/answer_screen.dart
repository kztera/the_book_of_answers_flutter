import 'package:flutter/material.dart';
import 'answer.dart';
import 'package:the_book_of_answers_flutter/start_screen.dart';
import 'dart:math';

class AnswerScreen extends StatefulWidget {
  final List<Answer> answers;

  const AnswerScreen({Key? key, required this.answers}) : super(key: key);

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  Answer? randomAnswer;

  @override
  void initState() {
    super.initState();
    randomAnswer = getRandomAnswer();
  }

  Answer getRandomAnswer() {
    final random = Random();
    final index = random.nextInt(widget.answers.length);
    return widget.answers[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "This book will give you the answers when you have something unsolvable...",
              textAlign: TextAlign.center,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      randomAnswer = getRandomAnswer();
                    });
                  },
                  child: Text(
                    randomAnswer!.answer,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StartScreen(answers: widget.answers),
                  ),
                );
              },
              child: const Text("Get Other Answer"),
            ),
          ],
        ),
      ),
    );
  }
}
