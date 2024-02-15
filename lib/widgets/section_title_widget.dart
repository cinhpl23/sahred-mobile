import 'package:flutter/cupertino.dart';

class SectionTitleWidget extends StatelessWidget {
  final double width;
  final String label;

  const SectionTitleWidget({super.key, required this.width, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: width,
        child: Text(
          label,
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

}