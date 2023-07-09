import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/share_appbar.dart';
import 'components/navbar.dart';
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
      drawer: const NavBar(),
      extendBodyBehindAppBar: false,
      appBar: SharedAppBar(
        title: AppLocalizations.of(context).titleAppBar,
        onLanguageChanged: handleLanguageChanged,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                AppLocalizations.of(context).introduction,
                style: GoogleFonts.patrickHand(
                  fontSize: 18,
                  color: Colors.black,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () {
                String languageCode =
                    Localizations.localeOf(context).languageCode;
                log("Book is tapped.");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnswerScreen(
                      answers: widget.answers,
                      currentLanguageCode: languageCode,
                    ),
                  ),
                );
              },
              child: const Image(
                image: AssetImage('assets/images/book_cover.jpg'),
                width: 300,
              ),
            ),
            Text(
              AppLocalizations.of(context).instruct,
              style: GoogleFonts.patrickHand(
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
