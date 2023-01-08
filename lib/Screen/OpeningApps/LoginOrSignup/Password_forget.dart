import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/Login.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/Otp.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/Signup.dart';
import 'package:trevashop_v2/constants/Api.dart';

class PasswordForget extends StatefulWidget {
  const PasswordForget({Key key}) : super(key: key);

  @override
  State<PasswordForget> createState() => _PasswordForgetState();
}

class _PasswordForgetState extends State<PasswordForget> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool isload = false;
  String numero;
  TextEditingController _phonenumber = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'TG');
  String initialCountry = 'TG';
  bool load = false;
  Map checkphone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/girl.png'), fit: BoxFit.cover)),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 0, 0, .6),
                    Color.fromRGBO(0, 0, 0, 8)
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
            ),
            child: Center(
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/logo1.png",
                      height: 150,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    Text("Recupérer",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.6,
                            fontFamily: "Sans",
                            color: Colors.white,
                            fontSize: 30.0)),
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            constraints: BoxConstraints(minHeight: 50),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 2))
                                ]),
                            child: InternationalPhoneNumberInput(
                              textFieldController: _phonenumber,
                              countries: ['TG', 'CI'],
                              formatInput: true,
                              inputDecoration:
                                  InputDecoration(border: InputBorder.none),
                              selectorConfig: SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              initialValue: number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Vueillez remplir le champ svp";
                                }
                                return null;
                              },
                              onInputChanged: (value) {
                                setState(() {
                                  number = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          /* ,*/
                          load
                              ? CircularProgressIndicator(color: Colors.white)
                              : Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black38,
                                            blurRadius: 15.0)
                                      ],
                                      borderRadius: BorderRadius.circular(30.0),
                                      gradient: LinearGradient(colors: <Color>[
                                        Color(0xFF121940),
                                        Color(0xFF6E48AA)
                                      ])),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        load = true;
                                      });
                                      print(initialCountry);

                                      if (formkey.currentState.validate()) {
                                        Api.checkNumber(
                                                _phonenumber.text
                                                    .replaceAll(' ', ''),
                                                1)
                                            .then((value) {
                                          setState(() {
                                            checkphone = value;
                                            load = false;
                                            if (checkphone['state'] == true) {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OtpScreen(
                                                    mobileNumber:
                                                        number.phoneNumber,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          super.widget));
                                            }
                                          });
                                        });
                                      }
                                    },
                                    child: Text(
                                      "Suivant",
                                      style: TextStyle(
                                          letterSpacing: 0.2,
                                          fontFamily: "Sans",
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      elevation: 0,
                                      onPrimary: Colors.white,
                                      minimumSize: Size(double.infinity, 50),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Text(
                                    "Se connecter",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Sans",
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Signup()));
                                  },
                                  child: Text(
                                    "Creer un compte",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Sans",
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            )),
      ),
    );
  }
}
