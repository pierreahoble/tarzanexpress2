import 'dart:async';

import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';

import 'LoginAnimation.dart';
import 'Signup.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

/// Component Widget this layout UI
class _loginScreenState extends State<loginScreen>
    with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;

  var tap = 0;

  @override

  /// set state animation controller
  void initState() {
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });
    // TODO: implement initState
    super.initState();
  }

  /// Dispose animation controller
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

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;

    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          /// Set Background image in layout (Click to open code)
          
          child: Container(
            /// Set gradient color in image (Click to open code)
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.0),
                  Color.fromRGBO(0, 0, 0, 0.3)
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
                                  Image(
                                    image: AssetImage("assets/img/Logo.png"),
                                    height: 70.0,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0)),

                                  /// Animation text treva shop accept from signup layout (Click to open code)
                                  Hero(
                                    tag: "Treva",
                                    child: Text("Login",
                                     
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

                              /// ButtonCustomFacebook
                              

                              /// Set Text
                             
                              /// TextFromField Email
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),
                              textFromField(
                                icon: Icons.email,
                                password: false,
                                email: "Email",
                                inputType: TextInputType.emailAddress,
                              ),

                              /// TextFromField Password
                              

                              /// Button Signup
                              FlatButton(
                                  padding: EdgeInsets.only(top: 20.0),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new Signup()));
                                  },
                                  child: Text(
                                    " Pas de compte? S'inscrire",
                                    style: TextStyle(
                                        color: Colors.orange.shade900,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Sans"),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: mediaQueryData.padding.top + 100.0,
                                    bottom: 0.0),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// Set Animaion after user click buttonLogin
                    tap == 0
                        ? InkWell(
                            splashColor: Colors.yellow,
                            onTap: () {
                              setState(() {
                                tap = 1;
                              });
                              new LoginAnimation(
                                animationController: sanimationController.view,
                              );
                              _PlayAnimation();
                              return tap;
                            },
                            child: buttonBlackBottom(),
                          )
                        : new LoginAnimation(
                            animationController: sanimationController.view,
                          ) , 
                          FlatButton(
                                  padding: EdgeInsets.only(top: 20.0),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new Signup()));
                                  },
                                  child: Text(
                                    " Mot de passe oublie?",
                                    style: TextStyle(
                                        color: Colors.orange.shade900,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Sans"),
                                  )),
                  ],
                ),
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

  textFromField({this.email, this.icon, this.inputType, this.password});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
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
          "Se connecter",
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
