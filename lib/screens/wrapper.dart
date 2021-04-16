import 'package:findmyschool_admin/models/user.dart';
import 'package:findmyschool_admin/screens/authenticate/login.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return either home or Welcome Screen widget
    final user = Provider.of<User>(context);

    if (user == null) {
      return LoginScreen();
    } else {
      return Home();
    }
  }
}
