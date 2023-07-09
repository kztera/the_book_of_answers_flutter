import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/share_appbar.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  void handleLanguageChanged(String languageCode) {
    setState(() {
      languageCode = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: SharedAppBar(
        title: AppLocalizations.of(context).titleAbout,
        onLanguageChanged: handleLanguageChanged,
        nameScreen: 'about_screen',
      ),
      body: SafeArea(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Text(AppLocalizations.of(context).titleAppBar,
                style: GoogleFonts.patrickHand(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center),
          ),
          Container(
            height: 600,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  AppLocalizations.of(context).about_1,
                  style: GoogleFonts.patrickHand(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).about_2,
                  style: GoogleFonts.patrickHand(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).about_3,
                  style: GoogleFonts.patrickHand(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).about_4,
                  style: GoogleFonts.patrickHand(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).about_5,
                  style: GoogleFonts.patrickHand(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).about_6,
                  style: GoogleFonts.patrickHand(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).about_7,
                  style: GoogleFonts.patrickHand(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).about_8,
                  style: GoogleFonts.patrickHand(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).about_9,
                  style: GoogleFonts.patrickHand(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
