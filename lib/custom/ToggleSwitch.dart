import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

const Color drop_black = Colors.black;

class ToggleController extends StatefulWidget {

  final OnToggle? onToggle;

  const ToggleController({Key? key, this.onToggle}) : super(key: key);

  @override
  State<ToggleController> createState() => _Toggle_ControllerState();
}

class _Toggle_ControllerState extends State<ToggleController> {
  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 40.0,
      minHeight: 25.0,
      fontSize: 15.0,
      totalSwitches: 3,
      initialLabelIndex: null,
      doubleTapDisable: true,
      activeBgColor: [Colors.grey.shade600],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey[200],
      inactiveFgColor: drop_black,
      customIcons: [
        const Icon(
          Icons.keyboard_double_arrow_right,
          color: drop_black,
          size: 20.0,
        ),
        const Icon(
          Icons.settings,
          size: 20.0,
        ),
        const Icon(
          Icons.keyboard_double_arrow_left,
          color: drop_black,
          size: 20.0,
        ),
      ],
      onToggle: widget.onToggle,
    );
  }
}