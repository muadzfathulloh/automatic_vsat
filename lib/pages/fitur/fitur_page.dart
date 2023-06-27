import 'package:automatic_vsat_v1/common/utils.dart';
import 'package:automatic_vsat_v1/pages/fitur/detail_satelite.dart';
import 'package:automatic_vsat_v1/pages/fitur/manual_adjust.dart';
import 'package:automatic_vsat_v1/pages/fitur/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FiturPage extends StatefulWidget {
  static const routeName = '/fiturpage';

  const FiturPage({super.key, required this.deviceId});

  final String deviceId;

  @override
  State<FiturPage> createState() => _FiturPageState();
}

class _FiturPageState extends State<FiturPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: TopBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: ListView(
            shrinkWrap: true,
            controller: ScrollController(keepScrollOffset: true),
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailSatelite(deviceId: widget.deviceId),
                    ),
                  );
                },
                child: PhysicalModel(
                  color: Colors.transparent,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(25.0),
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: Card(
                    color: kMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'asset/5.png',
                            height: 100,
                            color: kSecondaryColor,
                          ),
                          const SizedBox(
                            height: 20,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scene(
                          satelit: 'Informasi sinyal', azimuth: 0, elevasi: 0),
                    ),
                  );
                },
                child: PhysicalModel(
                  color: Colors.transparent,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(25.0),
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: Card(
                    color: kMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'asset/3.png',
                            color: kSecondaryColor,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Informasi Sinyal',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
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
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scene(
                          satelit: 'Manual adjust', azimuth: 0, elevasi: 0),
                    ),
                  );
                },
                child: PhysicalModel(
                  color: Colors.transparent,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(25.0),
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: Card(
                    color: kMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'asset/2.png',
                            color: kSecondaryColor,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Manual adjust',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
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
          ),
        ),
      ),
    );
  }
}
