import 'package:automatic_vsat_v1/common/utils.dart';
import 'package:automatic_vsat_v1/pages/bluetooth/bluetooth_page.dart';
import 'package:automatic_vsat_v1/pages/fitur/manual_adjust.dart';
import 'package:automatic_vsat_v1/pages/fitur/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailSatelite extends StatefulWidget {
  const DetailSatelite({super.key, required this.deviceId});
  static const routeName = '/detailsatelite';

  final String deviceId;

  @override
  State<DetailSatelite> createState() => _DetailSateliteState();
}

class _DetailSateliteState extends State<DetailSatelite> {
  final flutterReactiveBle = FlutterReactiveBle();

  QualifiedCharacteristic? resultDiscover;
  String serviceId = '0000FFE0-0000-1000-8000-00805F9B34FB';
  String characteristicId = '0000FFF3-0000-1000-8000-00805F9B34FB';

  bool? isLoading = false;
  int counter = 0;

  //untuk menampilkan list discover sevice dari device
  Future<List<DiscoveredService>> discoverServices(String deviceId) async {
    print("BleDeviceInteractor, Start discover service");
    try {
      final result = await flutterReactiveBle
          .discoverServices(deviceId)
          .timeout(Duration(milliseconds: 5500));
      print(result);

      return result;
    } on Exception catch (e) {
      print("BleDeviceInteractor, $e");
      counter += 1;
      print(counter);
      if (counter < 5) {
        discoverServices(widget.deviceId);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              'Connect ulang bluetooth',
              style: GoogleFonts.montserrat(
                color: kDefaultIconDarkColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            content: Container(
              child: Text(
                'Acces bluetooth ada error, mohon buka ulang aplikasi / kembali untuk pergi ke acces bluetooth',
                style: GoogleFonts.montserrat(
                  color: kDefaultIconDarkColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.montserrat(
                    color: kDefaultIconDarkColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => BluetoothPage(),
                    ),
                  );
                },
                child: Text(
                  'Confirm',
                  style: GoogleFonts.montserrat(
                    color: kButtonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        );
      }
      rethrow;
    }
  }

  //mengirim data ke bluetooth
  Future<void> writeCharacteristicWithResponse(
      QualifiedCharacteristic characteristic, List<int> value) async {
    try {
      // value adalah apa yang akan dikirim ke arduino nya. dalam bentuk List<int>
      await flutterReactiveBle.writeCharacteristicWithResponse(characteristic,
          value: value);
      print('Finish');
    } on Exception {
      rethrow;
    }
  }

  // Future<void> writeCharacteristicWithoutResponse(
  //     QualifiedCharacteristic characteristic, List<int> value) async {
  //   try {
  //     await flutterReactiveBle
  //         .writeCharacteristicWithoutResponse(characteristic, value: value);
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  // Stream<List<int>> subscribeToCharacteristic(
  //     QualifiedCharacteristic characteristic) {
  //   print("BleDeviceInteractor, Start subscribe to characteristic");
  //   return flutterReactiveBle
  //       .subscribeToCharacteristic(characteristic)
  //       .timeout(Duration(seconds: 5));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: TopBar(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Image.asset(
                      'asset/5.png',
                      height: 150,
                      color: kSecondaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Pilihan Satelit',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ListView(
                    shrinkWrap: true,
                    controller: ScrollController(keepScrollOffset: true),
                    children: [
                      InkWell(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await discoverServices(widget.deviceId);
                          setState(() {
                            isLoading = false;
                          });
                          QualifiedCharacteristic arduinoCharacter =
                              QualifiedCharacteristic(
                                  characteristicId:
                                      Uuid.parse(characteristicId),
                                  serviceId: Uuid.parse(serviceId),
                                  deviceId: widget.deviceId);
                          // Kirim data ke bluetooth didalam [] yang ada dibawah sini
                          await writeCharacteristicWithResponse(
                              arduinoCharacter, [1]);
                          Future.delayed(
                            Duration(seconds: 1),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Scene(
                                    satelit: 'BRISat',
                                    azimuth: 80.73,
                                    elevasi: 45.64),
                              ),
                            ),
                          );
                        },
                        child: PhysicalModel(
                          color: Colors.transparent,
                          elevation: 4,
                          borderRadius: BorderRadius.circular(25.0),
                          shadowColor: Colors.grey.withOpacity(0.5),
                          child: Card(
                            color: kSecondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Image.asset(
                                    'asset/5.png',
                                    height: 50,
                                    color: kMainColor,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'BRISat',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        color: kMainColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await discoverServices(widget.deviceId);
                          setState(() {
                            isLoading = false;
                          });
                          QualifiedCharacteristic arduinoCharacter =
                              QualifiedCharacteristic(
                                  characteristicId:
                                      Uuid.parse(characteristicId),
                                  serviceId: Uuid.parse(serviceId),
                                  deviceId: widget.deviceId);
                          // Kirim data ke bluetooth didalam [] yang ada dibawah sini
                          await writeCharacteristicWithResponse(
                              arduinoCharacter, [2]);
                          Future.delayed(
                            Duration(seconds: 1),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Scene(
                                    satelit: 'Palapa D',
                                    azimuth: 1.63,
                                    elevasi: 81.43),
                              ),
                            ),
                          );
                        },
                        child: PhysicalModel(
                          color: Colors.transparent,
                          elevation: 4,
                          borderRadius: BorderRadius.circular(25.0),
                          shadowColor: Colors.grey.withOpacity(0.5),
                          child: Card(
                            color: kSecondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Image.asset(
                                    'asset/5.png',
                                    height: 50,
                                    color: kMainColor,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Palapa D',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        color: kMainColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await discoverServices(widget.deviceId);
                          setState(() {
                            isLoading = false;
                          });
                          QualifiedCharacteristic arduinoCharacter =
                              QualifiedCharacteristic(
                                  characteristicId:
                                      Uuid.parse(characteristicId),
                                  serviceId: Uuid.parse(serviceId),
                                  deviceId: widget.deviceId);
                          // Kirim data ke bluetooth didalam [] yang ada dibawah sini
                          await writeCharacteristicWithResponse(
                              arduinoCharacter, [3]);
                          Future.delayed(
                            Duration(seconds: 1),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Scene(
                                    satelit: 'Telkom 3S',
                                    azimuth: 35.72,
                                    elevasi: 79.48),
                              ),
                            ),
                          );
                        },
                        child: PhysicalModel(
                          color: Colors.transparent,
                          elevation: 4,
                          borderRadius: BorderRadius.circular(25.0),
                          shadowColor: Colors.grey.withOpacity(0.5),
                          child: Card(
                            color: kSecondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Image.asset(
                                    'asset/5.png',
                                    height: 50,
                                    color: kMainColor,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Telkom 3S',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        color: kMainColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          isLoading == false
              ? SizedBox()
              : Positioned(
                  child: AlertDialog(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        Container(
                            margin: EdgeInsets.only(left: 7),
                            child: Text("Loading...")),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
