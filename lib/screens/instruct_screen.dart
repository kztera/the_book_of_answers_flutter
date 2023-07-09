import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/share_appbar.dart';

class InstructScreen extends StatefulWidget {
  const InstructScreen({super.key});

  @override
  State<InstructScreen> createState() => _InstructScreenState();
}

class _InstructScreenState extends State<InstructScreen> {
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
        title: AppLocalizations.of(context).titleHowToUse,
        onLanguageChanged: handleLanguageChanged,
        nameScreen: "instruct_screen",
      ),
      body: SafeArea(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // verticalDirection: VerticalDirection.down,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: Text(AppLocalizations.of(context).instruct_0,
                    style: GoogleFonts.patrickHand(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center),
              ),
              Container(
                height: 450,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context).instruct_1,
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context).instruct_2,
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context).instruct_3,
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context).instruct_4,
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context).instruct_5,
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Expanded(
                child: Image(image: AssetImage('assets/images/flork-love.png')),
              )
            ]),
      ),
    );
  }
}
