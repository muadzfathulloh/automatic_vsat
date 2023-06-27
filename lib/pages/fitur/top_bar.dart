import 'package:automatic_vsat_v1/common/utils.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: kSecondaryColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.end, // Mengubah posisi ikon ke pojok kanan
          children: [
            IconButton(
              onPressed: () {
                // Handle notification button tap
              },
              icon: const Icon(
                Icons.bluetooth,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
