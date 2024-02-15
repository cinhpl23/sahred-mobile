import 'package:flutter/cupertino.dart';
import 'package:tp_interactive_widgets/widgets/text_info_widget.dart';

class TextInfoIconWidget extends StatelessWidget {

  final IconData iconData;
  final String information;

  const TextInfoIconWidget({super.key, required this.iconData, required this.information});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Icon(iconData),
          ),
          TextInfoWidget(information: information),
        ],
      ),
    );
  }
}