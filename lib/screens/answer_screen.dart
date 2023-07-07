import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'components/share_appbar.dart';
import 'package:the_book_of_answers_flutter/screens/start_screen.dart';
import '../classes/answer.dart';

class AnswerScreen extends StatefulWidget {
  final List<Answer> answers;

  const AnswerScreen({Key? key, required this.answers}) : super(key: key);

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen>
    with WidgetsBindingObserver {
  Answer? currentAnswer;
  Answer? previousAnswer;
  String languageCode = 'en'; // Default language code, e.g., 'en' for English

  @override
  void initState() {
    super.initState();
    currentAnswer = getRandomAnswer();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Answer getRandomAnswer() {
    final random = Random();
    Answer randomAnswer;

    do {
      randomAnswer = widget.answers[random.nextInt(widget.answers.length)];
    } while (randomAnswer == previousAnswer);

    return randomAnswer;
  }

  void updateRandomAnswer() {
    setState(() {
      previousAnswer = currentAnswer;
      currentAnswer = getRandomAnswer();
    });
  }

  void changeLanguage(String newLanguageCode) {
    setState(() {
      languageCode = newLanguageCode;
    });
  }

  String getAnswerText() {
    return currentAnswer!.answerTexts[languageCode] ?? '';
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    if (locales != null && locales.isNotEmpty) {
      final newLanguageCode = locales.first.languageCode;
      changeLanguage(newLanguageCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SharedAppBar(
        title: AppLocalizations.of(context).titleAppBar,
        onLanguageChanged: changeLanguage,
      ),
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
                    Clipboard.setData(ClipboardData(text: getAnswerText()));
                    developer
                        .log('Text copied to clipboard: ${getAnswerText()}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Answer copied to clipboard')),
                    );
                  },
                  child: Text(
                    getAnswerText(),
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
                updateRandomAnswer();
              },
              child: const Text("Get Other Answer"),
            ),
          ],
        ),
      ),
    );
  }
}
