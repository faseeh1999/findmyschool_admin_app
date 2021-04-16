import 'package:findmyschool_admin/services/auth.dart';
import 'package:findmyschool_admin/shared/constants.dart';
import 'package:findmyschool_admin/shared/laoder.dart';
import 'package:findmyschool_admin/theme/colors.dart';
import 'package:findmyschool_admin/theme/text.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  AuthService _auth = AuthService();

  bool _validate() {
    return _form.currentState.validate();
  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget tryAgainButton = FlatButton(
      child: Text("Try Again"),
      onPressed: () async {
        Navigator.of(context).pop();
      },
    );

    AlertDialog tryAgainAlert = AlertDialog(
        title: Text("Invalid Credentials"),
        content: Text("Try again with valid credentials."),
        actions: [
          tryAgainButton,
        ]);

    Size size = MediaQuery.of(context).size;
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: Text(
                "Login",
                style: appbarText,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(
                    //   "Login",
                    //   style: TextStyle(fontFamily: 'ss', fontSize: 20),
                    // ),

                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200].withOpacity(0.8),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock,
                        color: iconColor,
                        size: 50.0,
                      ),
                    ),
                    // Login Form Starts from here.
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _email,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: validateEmail,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(height: size.height * 0.04),
                            TextFormField(
                              controller: _pass,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: validatePassword,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.remove_red_eye),
                                    onPressed: _toggle,
                                  ),
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(height: size.height * 0.04),
                            RaisedButton.icon(
                              elevation: 3.0,
                              onPressed: () async {
                                if (_validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          _email.text, _pass.text);
                                  print(result);

                                  if (result == null) {
                                    setState(() {
                                      isLoading = false;
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return tryAgainAlert;
                                        },
                                      );
                                    });
                                  }
                                }
                              },
                              shape: buttonShape,
                              label: Text(
                                'Login to Dashboard',
                                style: ButtonTextStyle,
                              ),
                              icon: Icon(
                                Icons.login_outlined,
                                color: Colors.white,
                              ),
                              textColor: Colors.white,
                              splashColor: Colors.blueAccent,
                              color: buttonColor,
                              padding: buttonPadding,
                            ),
                            SizedBox(height: size.height * 0.03),

                            // RaisedButton.icon(
                            //   elevation: 3.0,
                            //   onPressed: () async {
                            //     setState(() {
                            //       isLoading = true;
                            //     });
                            //     dynamic result = await _auth.signInAnon();
                            //     if (result == null) {
                            //       setState(() {
                            //         isLoading = false;
                            //       });
                            //     }
                            //   },
                            //   shape: buttonShape,
                            //   label: Text(
                            //     'Login Anonymously',
                            //     style: ButtonTextStyle,
                            //   ),
                            //   icon: Icon(
                            //     Icons.login_outlined,
                            //     color: Colors.white,
                            //   ),
                            //   textColor: Colors.white,
                            //   splashColor: Colors.blueAccent,
                            //   color: buttonColor,
                            //   padding: buttonPadding,
                            // ),
                            SizedBox(height: size.height * 0.01),
                            SizedBox(height: size.height * 0.03),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
