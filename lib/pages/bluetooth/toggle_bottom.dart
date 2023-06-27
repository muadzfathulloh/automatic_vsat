import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isToggled,
      activeColor: Colors.green, // Warna saat status true
      inactiveTrackColor: Colors.white, // Warna saat status false
      onChanged: (value) {
        setState(() {
          _isToggled = value;
        });
      },
    );
  }
}
