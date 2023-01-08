import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trevashop_v2/Model/api_response.dart';
import 'package:trevashop_v2/Model/user.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/B1_Home/Home.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/Password_forget.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/Signup.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:trevashop_v2/services/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _password = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  bool showPassword = true;

  PhoneNumber number = PhoneNumber(isoCode: 'TG');
  String initialCountry = 'TG';
  bool isload = false;
  void _login() async {
    //
    String numero = _phoneNumber.text.replaceAll(' ', '');
    print(number.phoneNumber);
    ApiResponse response = await login(numero, _password.text);
    if (response.message == null) {
      _loginAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        isload = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.message}')));
    }
  }

  void _loginAndRedirectToHome(User user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString('nom', user.nom ?? '');
    await preferences.setString('prenoms', user.prenoms ?? '');
    await preferences.setString('mail', user.email ?? '');
    await preferences.setString('number', user.phone_number ?? '');
    await preferences.setString('code', user.code ?? '');
    await preferences.setInt('id', user.id);

    await preferences.setString('token', user.access_token ?? '0');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoaderOverlay(
      child: Container(
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
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo1.png",
                        height: 150,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      Text("Connectez vous",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.6,
                              fontFamily: "Sans",
                              color: Colors.white,
                              fontSize: 35.0)),
                      SizedBox(
                        height: 60,
                      ),
                      Form(
                          key: formkey,
                          child: Column(
                            children: [
                              Container(
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
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: InternationalPhoneNumberInput(
                                        autoFocus: true,
                                        textFieldController: _phoneNumber,
                                        countries: ['TG', 'CI'],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Vueillez remplir le champ svp";
                                          }
                                          return null;
                                        },
                                        formatInput: true,
                                        inputDecoration: InputDecoration(
                                            border: InputBorder.none),
                                        selectorConfig: SelectorConfig(
                                          selectorType: PhoneInputSelectorType
                                              .BOTTOM_SHEET,
                                        ),
                                        initialValue: number,
                                        onSaved: (value) {
                                          setState(() {
                                            number = value;
                                          });
                                        },
                                      ),
                                    ),
                                  )),
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
                                child: TextFormField(
                                  controller: _password,
                                  obscureText: showPassword,
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return "Vueillez remplir le champ";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        },
                                        icon: Icon(Icons.remove_red_eye)),
                                    icon: Icon(Icons.vpn_key),
                                    border: InputBorder.none,
                                    hintText: "Entrer votre mot de passe",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              /* ,*/
                              isload
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black38,
                                                blurRadius: 15.0)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: LinearGradient(
                                              colors: <Color>[
                                                Color(0xFF121940),
                                                Color(0xFF6E48AA)
                                              ])),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (formkey.currentState.validate()) {
                                            setState(() {
                                              isload = true;

                                              //_phoneNumber.dispose();
                                            });
                                            _login();
                                          }
                                        },
                                        child: Text(
                                          "Me connecter",
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
                                          minimumSize:
                                              Size(double.infinity, 50),
                                        ),
                                      )),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      context.loaderOverlay.show();
                                      Future.delayed(
                                          const Duration(milliseconds: 2000),
                                          () {
                                        context.loaderOverlay.hide();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Signup()));
                                      });
                                    },
                                    child: Text(
                                      "Créer un compte",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Sans",
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      context.loaderOverlay.show();
                                      Future.delayed(
                                          const Duration(milliseconds: 2000),
                                          () {
                                        context.loaderOverlay.hide();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PasswordForget()));
                                      });
                                    },
                                    child: Text(
                                      "Mot de passe oublié",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Sans",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ],
                  )),
            )),
          )),
    ));
  }
}
