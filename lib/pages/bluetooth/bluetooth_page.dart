import 'dart:async';

import 'package:automatic_vsat_v1/common/utils.dart';
import 'package:automatic_vsat_v1/pages/bluetooth/bluetooth_list.dart';
import 'package:automatic_vsat_v1/pages/bluetooth/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothPage extends StatefulWidget {
  static const routeName = '/blueetoothPage';

  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  bool? isBleOn = false;
  var _bleStatus = BleStatus.unknown;
  final flutterReactiveBle = FlutterReactiveBle();

  @override
  void initState() {
    super.initState();
    //cek bluetooth sudah nyala atau belum
    flutterReactiveBle.statusStream.listen((event) {
      if (!mounted) return;
      setState(() {
        _bleStatus = event;
      });

      if (_bleStatus == BleStatus.ready) {
        setState(() {
          isBleOn = true;
        });
      }
    });
    _requestPermission();
  }

  //meminta izin perangkat handphone untuk acsess
  Future<void> _requestPermission() async {
    final result = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location
    ].request();

    result[Permission.bluetoothScan];
    result[Permission.bluetoothConnect];
    result[Permission.location];
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: TopBar(),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: screenHeight * 0.28,
        decoration: BoxDecoration(
          color: kMainColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              blurRadius: 50,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  'GET CONNECTED',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  'Tap on a bluetooth device to connect or scan to find other device nearby',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.5, // Sesuaikan faktor lebar sesuai kebutuhan
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isBleOn == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BluetoothScreen(),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.white,
                              title: Text(
                                'Bluetooth belum aktif',
                                // style: AppTextStyle.title2,
                              ),
                              content: Container(
                                child: Text(
                                  'Aktifkan bluetooth anda',
                                  // style: AppTextStyle.title5,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Ok',
                                    style: GoogleFonts.montserrat(
                                      color: kButtonColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kButtonColor,
                      minimumSize: Size(
                        double.infinity,
                        screenHeight * 0.05,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      'Start',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
