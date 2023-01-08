import 'dart:async';

import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/CodeParain.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/verificationScreen.dart';

import 'package:trevashop_v2/providers/signIn.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:trevashop_v2/services/paySelection_services.dart';

import 'Login.dart';
import 'LoginAnimation.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  AnimationController animationControllerScreen;
  Animation animationScreen;
  var tap = 0;
  bool showPassword = false;

  /// Set AnimationController to initState
  @override
  void initState() {
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 1;
              });
            }
          });
    // TODO: implement initState
    super.initState();
  }

  /// Dispose animationController
  @override
  void dispose() {
    sanimationController.dispose();
    super.dispose();
  }

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  ///TextEditingController _txtNom,
  TextEditingController _txtPrenoms = TextEditingController();
  TextEditingController _txtNom = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();
  TextEditingController _txtpasswordConf = TextEditingController();
  List<dynamic> pays;
  RegExp exp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.height;
    mediaQueryData.size.width;
    var Sign = Provider.of<SignIn>(context);
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
          body: LoaderOverlay(
        child: Stack(
          children: <Widget>[
            Container(
              /// Set Background image in layout
              /// /*
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/img/backgroundgirl.png"),
                fit: BoxFit.cover,
              )),
              child: Container(
                /// Set gradient color in image
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0.2),
                      Color.fromRGBO(0, 0, 0, 0.3)
                    ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                  ),
                ),

                /// Set component layout
                child: ListView(
                  padding: EdgeInsets.all(0.0),
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
                                          top: mediaQueryData.padding.top +
                                              40.0)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage("assets/logo1.png"),
                                        height: 150.0,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0)),
                                      // Hero(
                                      //   tag: "Treva",
                                      //   child: Text(
                                      //     "S'inscrire",
                                      //     style: TextStyle(
                                      //         fontWeight: FontWeight.w900,
                                      //         letterSpacing: 0.6,
                                      //         fontFamily: "Sans",
                                      //         color: Colors.black,
                                      //         fontSize: 20.0),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.0)),

                                  /// TextFromField Email
                                  ///
                                  Form(
                                      key: _formkey,
                                      child: Column(
                                        children: [
                                          /**Nom */
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
                                                  controller: _txtNom,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Veuillez entrer votre nom";
                                                    } else if (value.length <
                                                        3) {
                                                      return "Au moins 3 caractères requis";
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      labelText: "Nom",
                                                      hintText: "Votre nom",
                                                      icon: Icon(
                                                        Icons.person,
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
                                          /**Prenom */
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
                                                  controller: _txtPrenoms,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Veuillez entrer votre prenom";
                                                    } else if (value.length <
                                                        3) {
                                                      return "Au moins 3 caractères requis";
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      labelText: "Prenom",
                                                      hintText: "Votre prenom",
                                                      icon: Icon(
                                                        Icons.person,
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

                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 30.0,
                                            ),
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
                                                  controller: _txtEmail,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return null;
                                                    } else {
                                                      if (!exp
                                                          .hasMatch(value)) {
                                                        return "Email invalide";
                                                      }
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      labelText:
                                                          "Email (Pas obligatoire)",
                                                      hintText: "Votre Email",
                                                      icon: Icon(
                                                        Icons.email,
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

                                          /// Button Login
                                          SizedBox(height: 30),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top:
                                                    mediaQueryData.padding.top +
                                                        50,
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
                            print("okasd");
                            if (_formkey.currentState.validate()) {
                              /* setState(() {
                                      tap = 0;
                                    }); */

                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(
                                            "Possedez vous un code de parrainnage ?"),
                                        actions: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            elevation: 0,
                                                            primary:
                                                                Colors.red),
                                                    onPressed: () {
                                                      Sign.first_validation(
                                                        _txtNom.text,
                                                        _txtPrenoms.text,
                                                        _txtEmail.text,
                                                      );
                                                      print(Sign.request.nom);
                                                      getCountries().then((value) {
                                                        setState(() {
                                                          pays = value;
                                                        });
                                                        Navigator.of(context).pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new verificationNumeroScreen()));
                                                      });
                                                      
                                                    },
                                                    child: Text("Non")),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CodeParain()),
                                                          (route) => false);
                                                    },
                                                    child: Text("Oui")),
                                              ])
                                        ],
                                      ));
                            }
                          },
                          child: buttonBlackBottom(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: const Divider(color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "J'ai déja un compte , ",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.1,
                            fontFamily: "Sans",
                            fontSize: 14.0,
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              context.loaderOverlay.show();
                              Future.delayed(const Duration(milliseconds: 2000),
                                  () {
                                context.loaderOverlay.hide();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              });
                            },
                            child: Text(
                              "Me connecter",
                              style: TextStyle(
                                letterSpacing: 0.1,
                                fontFamily: "Sans",
                                fontSize: 14.0,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
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
  Function validate;
  IconButton sufIcon;

  textFromField(
      {this.email,
      this.sufIcon,
      this.icon,
      this.inputType,
      this.password,
      this.control,
      this.validate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        alignment: AlignmentDirectional.center,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        padding:
            EdgeInsets.only(left: 20.0, right: 10.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            controller: control,
            obscureText: password,
            decoration: InputDecoration(
                suffixIcon: sufIcon,
                border: InputBorder.none,
                hintText: email,
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
          "S'inscrire",
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
