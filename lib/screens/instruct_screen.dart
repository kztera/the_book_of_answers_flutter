import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'components/share_appbar.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: SharedAppBar(
        title: AppLocalizations.of(context).titleAppBar,
        onLanguageChanged: handleLanguageChanged,
      ),
    );
  }
}
