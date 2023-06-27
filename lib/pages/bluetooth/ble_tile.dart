import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
// import 'package:flutter_reactive_ble/flutter_reactive_blwidget.e.dart';

class BleTile extends StatefulWidget {
  const BleTile({super.key, required this.e, required this.onTap});
  final MapEntry<String, DiscoveredDevice> e;
  final Function() onTap;

  @override
  State<BleTile> createState() => _BleTileState();
}

class _BleTileState extends State<BleTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.bluetooth,
              color: Colors.white,
              size: 50,
            ),
            SizedBox(width: 20),
            Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.e.value.name == ''
                      ? '(Unknown device)'
                      : widget.e.value.name),
                  Text(widget.e.key)
                ],
              ),
            ),
          ],
        ),
        InkWell(onTap: widget.onTap, child: Icon(Icons.connected_tv))
      ],
    );
  }
}
