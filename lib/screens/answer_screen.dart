import 'dart:developer' as developer;
import 'dart:math';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:screenshot/screenshot.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'components/share_appbar.dart';
import '../classes/answer.dart';
import '../extensions/string_extension.dart';

class AnswerScreen extends StatefulWidget {
  final List<Answer> answers;
  final String currentLanguageCode;

  const AnswerScreen(
      {Key? key, required this.answers, required this.currentLanguageCode})
      : super(key: key);

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen>
    with WidgetsBindingObserver {
  final ScreenshotController screenshotController = ScreenshotController();

  Answer? currentAnswer;
  Answer? previousAnswer;
  String languageCode = 'en'; // Default language code, e.g., 'en' for English

  @override
  void initState() {
    super.initState();
    currentAnswer = getRandomAnswer();
    languageCode = widget.currentLanguageCode;
    changeLanguage(languageCode);
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

  Future<void> takeScreenshot() async {
    final uint8List = await screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/screenshot.png');
    await file.writeAsBytes(uint8List?.toList() ?? []);
    await Share.shareXFiles(
      [XFile(file.path)],
    );
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
        nameScreen: "AnswerScreen",
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalizations.of(context).answerScreen,
                textAlign: TextAlign.center,
                style: GoogleFonts.patrickHand(
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Screenshot(
                  controller: screenshotController,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: getAnswerText()));
                            developer.log(
                                'Text copied to clipboard: ${getAnswerText()}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Answer copied to clipboard')),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Text(
                                getAnswerText().capitalize(),
                                // getAnswerText(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.newsreader(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text('@theBookOfAnswers',
                            // style:
                            //     TextStyle(color: Color.fromRGBO(0, 0, 0, 0.375)),
                            style: GoogleFonts.newsreader(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.375),
                                fontSize: 14,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    updateRandomAnswer();
                  },
                  child: Text(
                    AppLocalizations.of(context).getOtherAnswer,
                    style: GoogleFonts.patrickHand(
                      textStyle: const TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                    onPressed: () {
                      takeScreenshot();
                    },
                    child: Text(
                      AppLocalizations.of(context).shareAnswer,
                      style: GoogleFonts.patrickHand(
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
