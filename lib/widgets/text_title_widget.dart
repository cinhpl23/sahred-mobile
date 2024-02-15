import 'package:flutter/material.dart';

class TextTitleWidget extends StatelessWidget {

  final String title;

  const TextTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white
      ),
    );
  }

}