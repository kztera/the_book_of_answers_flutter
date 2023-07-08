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

  const AnswerScreen({Key? key, required this.answers}) : super(key: key);

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen>
    with WidgetsBindingObserver {
  final ScreenshotController screenshotController = ScreenshotController();

  Answer? currentAnswer;
  Answer? previousAnswer;
  String languageCode = 'vi'; // Default language code, e.g., 'en' for English

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

  Future<void> takeScreenshot() async {
    final uint8List = await screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/screenshot.png');
    await file.writeAsBytes(uint8List?.toList() ?? []);
    await Share.shareXFiles(
      [XFile(file.path)],
    );
    // ScreenshotController()
    //     .capture(delay: const Duration(milliseconds: 10))
    //     .then((Uint8List bytes) async {
    //   final Directory dir = await getApplicationDocumentsDirectory();
    //   final String ts = DateTime.now().millisecondsSinceEpoch.toString();

    //   final String filePath = '${dir.path}/$ts.png';
    //   await XFile.fromData(bytes).saveTo(filePath);

    //   await Share.shareXFiles([XFile(filePath)], text: 'Share answer');
    // });
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
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(fontSize: 18, color: Colors.black),
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
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: getAnswerText()));
                        developer.log(
                            'Text copied to clipboard: ${getAnswerText()}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Answer copied to clipboard')),
                        );
                      },
                      child: Text(
                        getAnswerText().capitalize(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.newsreader(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
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
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 14,
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
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 14,
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
