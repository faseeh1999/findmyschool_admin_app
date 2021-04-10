import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findmyschool_admin/screens/dashboard.dart';
import 'package:findmyschool_admin/theme/colors.dart';
import 'package:findmyschool_admin/theme/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;


  bool _validate() {
    return _form.currentState.validate();
  }
  final validatePassword =
  ValidationBuilder().required().minLength(6).maxLength(20).build();
  final validateEmail = ValidationBuilder()
      .required("This Field is Required")
      .email()
      .maxLength(50)
      .build();

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();


  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  void logInEmail() async {
    //Sharing Email State
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.setString('email', _email.text);

    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseFirestore.instance
          .doc("user/${_email.text}")
          .get()
          .then((doc) async {
        if (doc.exists) {
          try {
            // ignore: unused_local_variable
            UserCredential user = await _auth.signInWithEmailAndPassword(
                email: _email.text, password: _pass.text);
            setState(() {
              isLoading = false;
            });

            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 500),
                    child: DashboardScreen()),
                    (route) => false);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              setState(() {
                isLoading = false;
              });
              print("User not found");
            } else if (e.code == 'wrong-password') {
              setState(() {
                isLoading = false;
              });

              print("Wrong Password");

              Widget okButton = FlatButton(
                child: Text("Try Again"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );

              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("Wrong Password"),
                content: Text("The Password You Entered is Incorrect."),
                actions: [
                  okButton,
                ],
              );
              // show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }
          } catch (e) {
            setState(() {
              isLoading = false;
            });
            print("Error: " + e);
          }
        } else {
          setState(() {
            isLoading = false;
          });
          print("User Not Found");

          Widget okButton = FlatButton(
            child: Text("Try Again"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );

          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: Text("Invalid Email"),
            content: Text("The Email You Entered is Incorrect."),
            actions: [
              okButton,
            ],
          );
          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;

        Widget okButton = FlatButton(
          child: Text("Try Again"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Connection Error"),
          content: Text("Kindly Check Your Connection & Try Again"),
          actions: [
            okButton,
          ],
        );
        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      });

      print(e);
    }
  }













  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(

        inAsyncCall: isLoading,


        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontFamily: 'ss', fontSize: 20),
                  ),
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: validateEmail,
                            decoration: InputDecoration(
                                labelText: "Email", border: OutlineInputBorder()),
                          ),
                          SizedBox(height: size.height * 0.04),
                          TextFormField(
                            controller: _pass,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            onPressed: () {
                              if (_validate() == true) {
                                null;
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(18.0))),
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
                            padding: EdgeInsets.only(left: 35.0, right: 35.0, top: 10.0, bottom: 10.0),
                          ),
                          SizedBox(height: size.height * 0.01),

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
        ),






    );



  }
}
