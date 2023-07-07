import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'components/share_appbar.dart';
import '../classes/answer.dart';
import 'answer_screen.dart';

class StartScreen extends StatefulWidget {
  final List<Answer> answers;

  const StartScreen({Key? key, required this.answers}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void handleLanguageChanged(String languageCode) {
        setState(() {
      languageCode = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SharedAppBar(
        title: AppLocalizations.of(context).titleAppBar,
        onLanguageChanged: handleLanguageChanged,
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
