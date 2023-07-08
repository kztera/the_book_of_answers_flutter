import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../../classes/language.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function(String) onLanguageChanged;
  final String? nameScreen;

  const SharedAppBar(
      {Key? key,
      required this.title,
      required this.onLanguageChanged,
      this.nameScreen})
      : super(key: key);

  void setLocale(BuildContext context, String languageCode) {
    Locale locale = Locale(languageCode);
    Main.setLocale(context, locale);
    onLanguageChanged(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: true,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: GoogleFonts.dancingScript().fontFamily,
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        // if nameScreen is null, then it is the start screen use the menu icon instead of the back icon
        icon: nameScreen == null
            ? const Icon(Icons.menu)
            : const Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () {
          if (nameScreen == null) {
            Scaffold.of(context).openDrawer();
          } else {
            Navigator.pop(context);
          }
        },
      ),
      actions: <Widget>[
        PopupMenuButton<Language>(
          icon: const Icon(
            Icons.language,
            color: Colors.black,
          ),
          itemBuilder: (BuildContext context) {
            return Language.languageList().map((Language language) {
              return PopupMenuItem<Language>(
                value: language,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      language.flag,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(language.name),
                  ],
                ),
              );
            }).toList();
          },
          onSelected: (Language? language) async {
            if (language != null) {
              setLocale(context, language.languageCode);
            }
          },
        ),
      ],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
