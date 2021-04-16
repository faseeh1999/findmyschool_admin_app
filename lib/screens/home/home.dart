import 'package:findmyschool_admin/services/auth.dart';

import 'package:findmyschool_admin/theme/text.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget logoutButton = FlatButton(
      child: Text("Logout"),
      onPressed: () async {
        Navigator.of(context).pop();
        await _auth.signOut();
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog logoutAlert = AlertDialog(
        title: Text("Confirm Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          cancelButton,
          logoutButton,
        ]);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        actions: [
          FlatButton.icon(
              onPressed: () {
                // set up the AlertDialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return logoutAlert;
                  },
                );
              },
              icon: Icon(
                Icons.login_outlined,
                color: Colors.white,
              ),
              label: Text(
                "Logout",
                style: ButtonTextStyle,
              ))
        ],
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
