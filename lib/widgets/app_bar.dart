import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {},
    ),
    centerTitle: true,
    title: const Text(
      "강남스팟",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    ),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    actions: [
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          // Implement burger icon functionality
        },
      ),
    ],
  );
}
