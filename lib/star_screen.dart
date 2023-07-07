import 'dart:developer';

import 'package:flutter/material.dart';
import 'answer_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF8172FF),
            automaticallyImplyLeading: false,
            title: const Align(
              alignment: AlignmentDirectional(0, 0),
              child: Text(
                'The Book of Answers',
                textAlign: TextAlign.start,
              ),
            ),
            actions: [
              PopupMenuButton(
                  // add icon, by default "3 dot" icon
                  // icon: Icon(Icons.book)
                  itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("My Account"),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Settings"),
                  ),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text("Logout"),
                  ),
                ];
              }, onSelected: (value) {
                if (value == 0) {
                  log("My account menu is selected.");
                } else if (value == 1) {
                  log("Settings menu is selected.");
                } else if (value == 2) {
                  log("Logout menu is selected.");
                }
              }),
            ],
            centerTitle: false,
            elevation: 2,
          ),
          body: SafeArea(
            top: true,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'This book will give you the answers when you have something unsolvable...',
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () {
                      log("Book is tapped.");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnswerScreen()),
                      );
                    },
                    child: const Image(
                      image: AssetImage('assets/images/book_cover.jpg'),
                      width: 300,
                    ),
                  ),
                  const Text(
                    'Concentrate on a question and tap the book',
                    textAlign: TextAlign.center,
                  )
                ]),
          )),
    );
  }
}
