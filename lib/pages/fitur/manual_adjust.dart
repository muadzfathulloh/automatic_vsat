// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Scene extends StatefulWidget {
  final String satelit;
  final double? azimuth;
  final double? elevasi;

  const Scene({super.key, required this.satelit, this.azimuth, this.elevasi});

  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> {
  late double valueAzimuth;
  late double valueElevasi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valueElevasi = widget.elevasi!;
    valueAzimuth = widget.azimuth!;
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Container(
          // androidlarge1hcJ (14:167)
          padding:
              EdgeInsets.fromLTRB(6 * fem, 31 * fem, 8.59 * fem, 36.59 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, -1),
              end: Alignment(0, 1),
              colors: <Color>[Color(0xfffffdfd), Color(0xff7438a8)],
              stops: <double>[0, 1],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // autogrouperttjYz (XfbarikPoVbAYx8mMhERtt)
                margin: EdgeInsets.fromLTRB(
                    111 * fem, 0 * fem, 116.16 * fem, 34 * fem),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // text672sfC (49:4)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 20 * fem, 0 * fem),
                      child: DefaultTextStyle(
                        style: GoogleFonts.inter(
                          // 'Inter',
                          fontSize: 10.9301996231 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.2125 * ffem / fem,
                          color: Color(0xff2d2d2d),
                        ),
                        child: Text(
                          'Informasi Sinyal',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      // path674AeJ (49:5)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 1 * fem, 0 * fem, 0 * fem),
                      width: 12.26 * fem,
                      height: 7.75 * fem,
                      child: Image.asset(
                        'asset/informasi-manual-adjust/images/path674.png',
                        width: 12.26 * fem,
                        height: 7.75 * fem,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // azimuthfqx (26:80)
                margin:
                    EdgeInsets.fromLTRB(17 * fem, 0 * fem, 0 * fem, 26 * fem),
                child: DefaultTextStyle(
                  style: GoogleFonts.poppins(
                    // 'Poppins',
                    fontSize: 10.9301996231 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.5 * ffem / fem,
                    color: Color(0xff2d2d2d),
                  ),
                  child: Text('Azimuth\t: $valueAzimuthº'),
                ),
              ),
              Container(
                // elevasiBZQ (26:78)
                margin:
                    EdgeInsets.fromLTRB(17 * fem, 0 * fem, 0 * fem, 29 * fem),
                child: DefaultTextStyle(
                  style: GoogleFonts.poppins(
                    // 'Poppins',
                    fontSize: 10.9301996231 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.5 * ffem / fem,
                    color: Color(0xff2d2d2d),
                  ),
                  child: Text('Elevasi\t: $valueElevasiº'),
                ),
              ),
              Container(
                // satelit7hx (26:76)
                margin:
                    EdgeInsets.fromLTRB(17 * fem, 0 * fem, 0 * fem, 30 * fem),
                child: DefaultTextStyle(
                  style: GoogleFonts.poppins(
                    // 'Poppins',
                    fontSize: 10.9301996231 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.5 * ffem / fem,
                    color: Color(0xff2d2d2d),
                  ),
                  child: Text('Satelit\t: ${widget.satelit}'),
                ),
              ),
              Container(
                // signalstrength47Q (26:74)
                margin:
                    EdgeInsets.fromLTRB(16 * fem, 0 * fem, 0 * fem, 4 * fem),
                child: DefaultTextStyle(
                  style: GoogleFonts.poppins(
                    // 'Poppins',
                    fontSize: 10.9301996231 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.5 * ffem / fem,
                    color: Color(0xff2d2d2d),
                  ),
                  child: Text(
                    'Signal Strength',
                  ),
                ),
              ),
              SizedBox(height: 5),
              // Container(
              //   // autogroup4krnAAS (XfbazJN6dFaHYX9xND4kRN)
              //   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 43 * fem),
              //   width: 343 * fem,
              //   height: 136 * fem,
              //   child: Image.asset(
              //     'asset/informasi-manual-adjust/images/auto-group-4krn.png',
              //     width: 343 * fem,
              //     height: 136 * fem,
              //   ),
              // ),
              Container(
                // autogroupkgk2fcz (Xfbb6xqfKxnu1Yn4DjkgK2)
                margin: EdgeInsets.fromLTRB(5 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: 340.41 * fem,
                height: 348.41 * fem,
                child: Stack(
                  children: [
                    Positioned(
                      // group3Q4n (26:51)
                      left: 116 * fem,
                      top: 231 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 117.41 * fem,
                          height: 117.41 * fem,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                valueElevasi -= 1.0;
                              });
                            },
                            child: Image.asset(
                              'asset/informasi-manual-adjust/images/group-3.png',
                              width: 117.41 * fem,
                              height: 117.41 * fem,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // group4WtW (26:56)
                      left: 113 * fem,
                      top: 0 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 117.41 * fem,
                          height: 117.41 * fem,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                valueElevasi += 1.0;
                              });
                            },
                            child: Image.asset(
                              'asset/informasi-manual-adjust/images/group-4.png',
                              width: 117.41 * fem,
                              height: 117.41 * fem,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // group2cRk (26:61)
                      left: 0 * fem,
                      top: 116.9999847412 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 117.41 * fem,
                          height: 117.41 * fem,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                valueAzimuth -= 1.0;
                              });
                            },
                            child: Image.asset(
                              'asset/informasi-manual-adjust/images/group-2.png',
                              width: 117.41 * fem,
                              height: 117.41 * fem,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // group189C (26:66)
                      left: 223 * fem,
                      top: 112.9999847412 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 117.41 * fem,
                          height: 117.41 * fem,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                valueAzimuth += 1.0;
                              });
                            },
                            child: Image.asset(
                              'asset/informasi-manual-adjust/images/group-1.png',
                              width: 117.41 * fem,
                              height: 117.41 * fem,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // manualadjustQMc (26:72)
                      left: 130 * fem,
                      top: 165.9999847412 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 77 * fem,
                          height: 14 * fem,
                          child: DefaultTextStyle(
                            style: GoogleFonts.inter(
                              // 'Inter',
                              fontSize: 10.9301996231 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2125 * ffem / fem,
                              color: Color(0xff2d2d2d),
                            ),
                            child: Text(
                              'Manual Adjust',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
