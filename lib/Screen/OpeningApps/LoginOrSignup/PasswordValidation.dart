import 'dart:async';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:flutter/material.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/B1_Home/Home.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/Login.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/Otp.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/verificationScreen.dart';
import 'package:trevashop_v2/providers/signIn.dart';

import 'LoginAnimation.dart';
import 'Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordValidation extends StatefulWidget {
  @override
  _PasswordValidationState createState() => _PasswordValidationState();
}

/// Component Widget this layout UI
class _PasswordValidationState extends State<PasswordValidation>
    with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;

  var tap = 0;
  String verificationCode = "";
  PhoneNumber number = PhoneNumber(isoCode: 'TG');
  String initialCountry = 'TG';

  TextEditingController _txtPassword = TextEditingController();
  TextEditingController _txtpasswordConf = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();
  
  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;

    var data = EasyLocalizationProvider.of(context).data;
    var Sign = Provider.of<SignIn>(context, listen: true);

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          /// Set Background image in layout (Click to open code)
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/backgroundgirl.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            /// Set gradient color in image (Click to open code)
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.3),
                  Color.fromRGBO(0, 0, 0, 0.6)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),

            /// Set component layout
            child: ListView(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.topCenter,
                          child: Column(
                            children: <Widget>[
                              /// padding logo
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: mediaQueryData.padding.top + 100.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0)),

                                  /// Animation text treva shop accept from signup layout (Click to open code)
                                  Hero(
                                    tag: "Treva",
                                    child: Text(
                                      "Choisir un mot de passe",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.6,
                                          color: Colors.white,
                                          fontFamily: "Sans",
                                          fontSize: 20.0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),

                              /// ButtonCustomFacebook

                              /// Set Text

                              /// TextFromField Email
                              Form(
                                  key: formkey,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 15),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: Container(
                                          alignment:
                                              AlignmentDirectional.center,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 6,
                                                    offset: Offset(0, 2))
                                              ]),
                                          padding: EdgeInsets.only(
                                              left: 20.0,
                                              right: 30.0,
                                              top: 0.0,
                                              bottom: 0.0),
                                          child: Theme(
                                            data: ThemeData(
                                              hintColor: Colors.transparent,
                                            ),
                                            child: TextFormField(
                                              obscureText: true,
                                              controller: _txtPassword,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "le mot de passe";
                                                } else if (value.length < 6) {
                                                  return "Au moins 6 caractères requis";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Mot de passe",
                                                  hintText: "Le mot de passe",
                                                  icon: Icon(
                                                    Icons.vpn_key,
                                                    color: Colors.black38,
                                                  ),
                                                  labelStyle: TextStyle(
                                                      fontSize: 15.0,
                                                      fontFamily: 'Sans',
                                                      letterSpacing: 0.3,
                                                      color: Colors.black38,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0)),

                                      /// TextFromField Password
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: Container(
                                          alignment:
                                              AlignmentDirectional.center,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 6,
                                                    offset: Offset(0, 2))
                                              ]),
                                          padding: EdgeInsets.only(
                                              left: 20.0,
                                              right: 30.0,
                                              top: 0.0,
                                              bottom: 0.0),
                                          child: Theme(
                                            data: ThemeData(
                                              hintColor: Colors.transparent,
                                            ),
                                            child: TextFormField(
                                              obscureText: true,
                                              controller: _txtpasswordConf,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "confirmer le mot de passe";
                                                } else if (value.length < 6) {
                                                  return "Au moins 6 caractères requis";
                                                } else if (value !=
                                                    _txtPassword.text) {
                                                  return "le mot de passe ne correspond pas";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Confirmer",
                                                  border: InputBorder.none,
                                                  hintText:
                                                      "Confirmer le mot de passe",
                                                  icon: Icon(
                                                    Icons.vpn_key,
                                                    color: Colors.black38,
                                                  ),
                                                  labelStyle: TextStyle(
                                                      fontSize: 15.0,
                                                      fontFamily: 'Sans',
                                                      letterSpacing: 0.3,
                                                      color: Colors.black38,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),

                                      /// TextFromField Password

                                      /// Button Signup

                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: mediaQueryData.padding.top +
                                                100.0,
                                            bottom: 0.0),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// Set Animaion after user click buttonLogin
                    InkWell(
                      splashColor: Colors.yellow,
                      onTap: () {
                        if (formkey.currentState.validate()) {
                          Sign.third_validation(
                              _txtPassword.text, _txtpasswordConf.text);
                          Sign.register();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home()));
                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             new OtpScreen(
                          //               mobileNumber:
                          //                   Sign.request.phone_number,
                          //               password: _txtPassword.text,
                          //               passwordConf:
                          //                   _txtpasswordConf.text,
                          //             )));
                        } else {
                          print("validation failed");
                        }
                      },
                      child: buttonBlackBottom(),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => verificationNumeroScreen()),
                          (route) => false);
                    },
                    child: Text(
                      "page précédente",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Sans",
                          letterSpacing: 0.6),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// textfromfield custom class
class textFromField extends StatelessWidget {
  bool password;
  String email;
  IconData icon;
  TextInputType inputType;
  TextEditingController control;

  textFromField(
      {this.email, this.icon, this.inputType, this.password, this.control});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 80.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding: EdgeInsets.only(left: 5.0, right: 10.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            controller: control,
            obscureText: password,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: email,
                icon: Icon(
                  icon,
                  color: Colors.black38,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}

///ButtonBlack class
class buttonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          "Verifier",
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 0.2,
              fontFamily: "Sans",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: <Color>[Color(0xFF121940), Color(0xFF6E48AA)])),
      ),
    );
  }
}
