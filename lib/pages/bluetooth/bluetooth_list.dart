import 'dart:async';

import 'package:automatic_vsat_v1/pages/bluetooth/ble_tile.dart';
import 'package:automatic_vsat_v1/pages/fitur/fitur_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothScreen extends StatefulWidget {
  static const routeName = '/blueetoothScreen';

  // const BluetoothScreen({super.key, required this.devices});

  // final List<DiscoveredDevice> devices;

  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  String? conectedDevice = '';
  Map<String, DiscoveredDevice>? devices = {};
  final flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<DiscoveredDevice> _scanStream;
  StreamSubscription<ConnectionStateUpdate>? _connection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestPermission();
    _startScan();
  }

  //memninta izin perangkat handphone untuk acsess
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

  //memulai scan bluetooth yang ada
  void _startScan() async {
    _scanStream =
        flutterReactiveBle.scanForDevices(withServices: []).listen((device) {
      if (device.name != '') {
        setState(() {
          devices![device.id] = device;
        });
      }
      print(devices!.length);
    });
  }

  //connect perangkat ke bluetooth
  Future<void> connect(String deviceId) async {
    if (_connection != null) {
      _connection!.cancel();
    }
    print('BleDeviceConnector, connect to device: ${deviceId}');
    _connection = flutterReactiveBle
        .connectToDevice(
      id: deviceId,
      connectionTimeout: Duration(seconds: 10),
    )
        .listen(
      (update) {
        print(
            'BleDeviceConnector, connection state for ${deviceId}: ${update.connectionState}');
      },
      onError: (Object e) => print(
          'BleDeviceConnector, connecting to device ${deviceId} resulted in error $e'),
    );
  }

  Future<void> disconnect() async {
    await _connection!.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _scanStream.cancel();
    _connection?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'asset/Background.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                Expanded(
                  child: Container(
                    child: ListView(
                        children: devices!.entries.map((e) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: BleTile(
                              e: e,
                              onTap: () async {
                                await connect(e.key);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      FiturPage(deviceId: e.key),
                                ));
                              },
                            )),
                      );
                    }).toList()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.stop,
          color: Colors.white,
        ),
        onPressed: () {
          _scanStream.cancel();
        },
      ),
    );
  }
}
