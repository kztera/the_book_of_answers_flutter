import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:the_book_of_answers_flutter/screens/instruct_screen.dart';
import 'package:the_book_of_answers_flutter/screens/about_screen.dart';
import 'package:the_book_of_answers_flutter/screens/faqs_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  Future _launchURL(url) async {
    url = Uri.parse(url);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future launchEmail({
    required String toEmail,
    required String subject,
  }) async {
    Uri mail = Uri.parse('mailto:$toEmail?subject=$subject');
    if (await canLaunchUrl(mail)) {
      await launchUrl(mail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 240,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 100,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(AppLocalizations.of(context).menuHowToUse),
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InstructScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(AppLocalizations.of(context).menuHistory),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.question_answer),
                  title: Text(AppLocalizations.of(context).menuFAQ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FAQsScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.share),
                  title: Text(AppLocalizations.of(context).menuShare),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: Text(AppLocalizations.of(context).menuFeedback),
                  onTap: () {
                    String email = "ngkhoa247@gmail.com";
                    String subject =
                        AppLocalizations.of(context).feedbackSubject;
                    launchEmail(toEmail: email, subject: subject);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(AppLocalizations.of(context).menuSettings),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(AppLocalizations.of(context).menuAbout),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            title: const Text('© kztera'),
            onTap: () {
              String url = "https://github.com/kztera";
              _launchURL(url);
            },
          ),
        ],
      ),
    );
  }
}
