import 'package:flutter/material.dart';
import 'package:nthiendev_flutter_tiktok/utils/tik_tok_icons_icons.dart';

class MessagesScreen extends StatefulWidget {
  MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12))),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "All activity",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                const Icon(Icons.send)
              ],
            ),
          ),
          const SizedBox(
            height: 250,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                TikTokIcons.messages,
                size: 80,
                color: Colors.black45,
              )
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            "All activity",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          const Text(
            "Notifications about your account will appear here",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
          ),
        ]),
      ),
    );
  }
}
