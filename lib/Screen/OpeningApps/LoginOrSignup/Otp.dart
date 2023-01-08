import 'dart:async';

import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/verificationScreen.dart';
import '../../../providers/signIn.dart';
import '../../B1_HomeScreen/B1_Home/Home.dart';
import 'LoginAnimation.dart';
import 'Signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trevashop_v2/services/user_service.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String password;
  final String passwordConf;

  const OtpScreen(
      {@required this.mobileNumber,
      @required this.password,
      @required this.passwordConf});
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

/// Component Widget this layout UI
class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController codeOtp = new TextEditingController();
  var tap = 0;
  bool isCodeSent = false;
  String _verificationId;

  void showToast(message, Color color) {
    print(message);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) {
        if (value.user != null) {
          // Handle loogged in state
          //  print("----------------"+value.user.phoneNumber+"----------------------------------");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false);
        } else {
          showToast("Code incorrect...veuillez le ressaisir", Colors.red);
        }
      }).catchError((error) {
        showToast("Try again in sometime", Colors.red);
      });
    };
    final PhoneVerificationFailed verificationFailed = (authException) {
      showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: widget.mobileNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted(SignIn Sign) async {
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: codeOtp.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((UserCredential value) async {
      if (value.user != null) {
        print(widget.password);
        // Sign.second_validation(
        //     widget.mobileNumber, widget.password, widget.passwordConf);
        await Sign.register().then((value) {
          if (value['success']) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false);
          } else {
            print("pas bon");
          }
        });
        // Handle loogged in state
        print(value.user.phoneNumber);
      } else {
        showToast("Error validating OTP, try again", Colors.red);
      }
    }).catchError((error) {
      showToast(error.toString(), Colors.red);
    });
  }

  @override

  /// set state animation controller
  void initState() {
    // print("number" + widget.mobileNumber);
    /*   sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          }); */
    // TODO: implement initState
    super.initState();
    _onVerifyCode();
  }

  /// Dispose animation controller
  @override
  void dispose() {
    // sanimationController.dispose();
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
    var Sign = Provider.of<SignIn>(context, listen: true);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;
    PhoneNumber number = PhoneNumber(isoCode: 'TG');
    String initialCountry = 'TG';

    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
               
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => verificationNumeroScreen()),
                    (route) => false);
              },
              icon: Icon(Icons.arrow_back)),
          automaticallyImplyLeading: true,
        ),
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
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0)),

                                  /// Animation text treva shop accept from signup layout (Click to open code)
                                  Hero(
                                    tag: "e-SUGU",
                                    child: Text(
                                      "Validation Numero",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.6,
                                          color: Colors.black,
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
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                child: Container(
                                  height: 80.0,
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10.0,
                                            color: Colors.black12)
                                      ]),
                                  padding: EdgeInsets.only(
                                      left: 5.0,
                                      right: 10.0,
                                      top: 0.0,
                                      bottom: 0.0),
                                  child: Theme(
                                    data: ThemeData(
                                      hintColor: Colors.transparent,
                                    ),
                                    child: TextFormField(
                                      controller: codeOtp,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: "code de verification",
                                          labelStyle: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'Sans',
                                              letterSpacing: 0.3,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w600)),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 15),

                              /// TextFromField Password

                              /// Button Signup

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
                    InkWell(
                      splashColor: Colors.yellow,
                      onTap: () {
                        if (codeOtp.text.length == 6) {
                          _onFormSubmitted(Sign);
                        } else {
                          showToast("Invalid code", Colors.red);
                        }
                      },
                      child: buttonBlackBottom(),
                    ),
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
            onChanged: ((value) {
              email = value;
            }),
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
