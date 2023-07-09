import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/share_appbar.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
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
        title: AppLocalizations.of(context).titleFAQ,
        onLanguageChanged: handleLanguageChanged,
        nameScreen: 'faqs_screen',
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    Text(
                      AppLocalizations.of(context).faq_q1,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.patrickHand(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        // height: 2
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context).faq_a1,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    Text(
                      AppLocalizations.of(context).faq_q2,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.patrickHand(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        // height: 2
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context).faq_a2,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    Text(
                      AppLocalizations.of(context).faq_q3,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.patrickHand(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        // height: 2
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context).faq_a3,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    Text(
                      AppLocalizations.of(context).faq_q4,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.patrickHand(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        // height: 2
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context).faq_a4,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ]),
            ),
            const Expanded(
              child: Image(
                image: AssetImage('assets/images/flork-like.png'),
                height: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
