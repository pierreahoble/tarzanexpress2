import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/appColors.dart';
import '../../../providers/authentification_provider.dart';
import '../../../services/shared_preferences.dart';
import '../../../state/authState.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String token;
  var result;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    SharedPreferencesClass.restore('token').then((value) {
      setState(() {
        token = value;
        print(token);
      });
    });
  }

  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Changer Mot de Passe",
      //     style: TextStyle(color: AppColors.redAppbar),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      appBar: AppBar(
        backgroundColor: Color(0xFF020D1F),
        centerTitle: true,
        title: Text('Changer Mot de Passe'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: AppColors.scaffoldBackgroundYellowForWelcomePage,
        dismissible: true,
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.yellowAppbar),
        ),
        child: Builder(
          builder: (context) => SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.4, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 150,
                      height: 100,
                      child: Image.asset("assets/padlock.png"),
                      // decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     // border: Border.all(color: Colors.red, width: 5),
                      //     image: DecorationImage(
                      //       fit: BoxFit.cover,
                      //       image: AssetImage("assets/padlock.png"),
                      //     )),
                    ),
                    // Text(
                    //   "Mot de Passe Actuel",
                    //   style: TextStyle(
                    //       fontSize: 15.0,
                    //       color: Colors.grey,
                    //       fontWeight: FontWeight.w800),
                    // ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: oldPassword,
                      decoration: InputDecoration(
                          labelText: "Mot de Passe Actuel",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2))),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      // onSaved: (newValue) => oldPassword.toString() = newValue,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Entrer le mot de passe!";
                        }
                        if (value.length < 8) {
                          return "Au moins 8 caractères requis";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Text(
                    //   "Nouveau Mot de Passe",
                    //   style: TextStyle(
                    //       fontSize: 15.0,
                    //       color: Colors.grey,
                    //       fontWeight: FontWeight.w800),
                    // ),
                    TextFormField(
                      controller: newPassword,
                      decoration: InputDecoration(
                        labelText: "Nouveau Mot de Passe",
                        labelStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      // onSaved: (newValue) => newPassword.text = newValue,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Entrer le mot de passe!";
                        }
                        if (value.length < 8) {
                          return "Au moins 8 caractères requis";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 21),
                    // Text(
                    //   "Répeter le nouveau Mot de Passe",
                    //   style: TextStyle(
                    //       fontSize: 15.0,
                    //       color: Colors.grey,
                    //       fontWeight: FontWeight.w800),
                    // ),
                    TextFormField(
                      controller: confirmNewPassword,
                      decoration: InputDecoration(
                          labelText: "Répeter le nouveau Mot de Passe",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2))),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => confirmNewPassword.text = newValue,
                      validator: (value) {
                        if (identical(newPassword.toString(), value)) {
                          return "Les mots de passes ne correspondent pas";
                        }
                        if (value == null || value.isEmpty) {
                          return "Entrer le mot de passe!";
                        }
                        if (value.length < 8) {
                          return "Au moins 8 caractères requis";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 35),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFF020D1F),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                print('bienvenu');
                                if (newPassword.text ==
                                    confirmNewPassword.text) {
                                  print('Entrer');
                                  showSpinner = true;
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  await Provider.of<AuthentificationProvider>(
                                          context,
                                          listen: false)
                                      .changePassword(token, oldPassword.text,
                                          newPassword.text)
                                      .then((value) {
                                    result = value;
                                    print(value['message']);
                                    print("ici");
                                  });
                                  if (result != null &&
                                      result['status'] == 200) {
                                    showSpinner = false;
                                    // print(result);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        backgroundColor: AppColors.green,
                                        content: Text(
                                          "Opération éffectuée avec succès !",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        margin:
                                            EdgeInsets.fromLTRB(18, 0, 18, 49),
                                      ),
                                    );
                                    await Future.delayed(Duration(seconds: 2));
                                    Navigator.pop(context);
                                  } else if (result != null &&
                                      result['status'] == 400) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.grey,
                                        content: Text(
                                          result['message'].toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        margin:
                                            EdgeInsets.fromLTRB(18, 0, 18, 49),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.grey,
                                        content: Text(
                                          "Réessayer s'il vous plait",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        margin:
                                            EdgeInsets.fromLTRB(18, 0, 18, 49),
                                      ),
                                    );
                                  }
                                } else {
                                  showSpinner = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.grey,
                                      content: Text(
                                        "Veuillez réessayer les mots de passe ne correspondent pas.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      margin:
                                          EdgeInsets.fromLTRB(18, 0, 18, 49),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text(
                              "MODIFIER",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
