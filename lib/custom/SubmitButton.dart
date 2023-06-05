import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TextFrame.dart';

class ButtonWidget extends StatelessWidget {

  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[600],
              minimumSize: Size.fromHeight(50),
              // shape: StadiumBorder(),
            ),
            child: FittedBox(
              child: TextFrame(comment: text),
            ),
            onPressed: onClicked,
          ),
        ),
      ],
    );
  }
}
