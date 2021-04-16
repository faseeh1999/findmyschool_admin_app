import 'package:findmyschool_admin/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../theme/colors.dart';
import '../wrapper.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 2500), () {
    //   Navigator.pushReplacement(
    //       context,
    //       PageTransition(
    //           type: PageTransitionType.fade,
    //           duration: Duration(milliseconds: 300),
    //           child: Wrapper()));
    // });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    //
    //

    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/welcome.png',
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Text(
                  "Welcome To",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'ss',
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  "Find My School",
                  style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'ss',
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Admin",
                  style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'ss',
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: height * 0.55,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 300),
                            child: Wrapper()));
                  },
                  child: Text(
                    "Get Started",
                    style: ButtonTextStyle,
                  ),
                  elevation: 2.0,
                  highlightElevation: 8.0,
                  color: primaryColor,
                  textColor: Colors.white,
                  splashColor: Colors.blue[200],
                  hoverElevation: 8.0,
                  hoverColor: Colors.green,
                  padding: EdgeInsets.only(
                      left: 35.0, right: 35.0, top: 10.0, bottom: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
