import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(
      {required this.id,
      required this.flag,
      required this.name,
      required this.languageCode});

  static List<Language> languageList(BuildContext context) {
    return <Language>[
      Language(id: 1, flag: "🇺🇸", name: AppLocalizations.of(context).languageEn, languageCode: "en"),
      Language(id: 2, flag: "🇻🇳", name: AppLocalizations.of(context).languageVi, languageCode: "vi"),
    ];
  }
}
