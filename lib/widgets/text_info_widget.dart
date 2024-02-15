import 'package:flutter/cupertino.dart';

class TextInfoWidget extends StatelessWidget {

  final String information;

  const TextInfoWidget({super.key, required this.information});

  @override
  Widget build(BuildContext context) {
    return Text(
      information,
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }

}
