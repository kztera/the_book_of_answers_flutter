import 'dart:developer';
import 'answer.dart';
import 'package:flutter/material.dart';
import 'answer_screen.dart';

class StartScreen extends StatefulWidget {
  final List<Answer> answers;

  const StartScreen({Key? key, required this.answers}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8172FF),
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            'The Book of Answers',
            textAlign: TextAlign.start,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'This book will give you the answers when you have something unsolvable...',
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () {
                log("Book is tapped.");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnswerScreen(answers: widget.answers),
                  ),
                );
              },
              child: const Image(
                image: AssetImage('assets/images/book_cover.jpg'),
                width: 300,
              ),
            ),
            const Text(
              'Concentrate on a question and tap the book',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
