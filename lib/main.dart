import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'classes/answer.dart';
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

class Main extends StatefulWidget {
  final List<Answer> answers;

  const Main({Key? key, required this.answers}) : super(key: key);

  @override
  State<Main> createState() => _MainState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MainState? state = context.findAncestorStateOfType<_MainState>();
    String currentLocale = AppLocalizations.of(context).localeName;
    if (currentLocale != newLocale.languageCode) {
      state?.setLocale(newLocale);
    } else {
      log('Locale is already $newLocale');
    }
  }
}

class _MainState extends State<Main> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('vi'),
      ],
      home: Scaffold(
        body: StartScreen(answers: widget.answers),
      ),
    );
  }
}
