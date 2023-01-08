import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../../../helper/utils.dart';
import '../../../constants/appColors.dart';
import '../../../helper/dataConnectionChecker.dart';
import '../../../helper/inputValidator.dart';
import '../../../providers/authentification_provider.dart';
import '../../../services/shared_preferences.dart';
import '../../../services/user_service.dart';
import 'PageProfile.dart';
import '../../../state/authState.dart';

class EditProfile extends StatefulWidget {
  final String nom;
  final String prenoms;
  final String telephone;
  final String email;

  EditProfile({
    @required this.nom,
    @required this.prenoms,
    @required this.telephone,
    @required this.email,
  });
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int id;
  String token;

  final _formKey = GlobalKey<FormState>();
  String nom, prenoms, telephone, email;
  bool showSpinner = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    SharedPreferencesClass.restore('id').then((value) {
      setState(() {
        id = value;
        print(id);
      });
    });
    getToken().then((value) {
      setState(() {
        token = value;
        print(token);
      });
    });

    print(token);
  }

  saveinSharedPreferencesClass(dynamic reponse) async {
    // print("moi ici====");
    // print(reponse['user']['nom']);
    await SharedPreferencesClass.save("nom", reponse['user']['nom']);
    // .then(print(reponse['user']['nom']));
    await SharedPreferencesClass.save("prenoms", reponse['user']['prenoms']);
    await SharedPreferencesClass.save("mail", reponse['user']['email']);
    await SharedPreferencesClass.save("number", reponse['user']['phone_number']);
  }

  @override
  Widget build(BuildContext context) {
    var providerAuth = Provider.of<AuthentificationProvider>(context);

    void ShowMessage() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: AppColors.green,
          content: Text(
            "Profil Modifié avec succès",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.fromLTRB(18, 0, 18, 49),
        ),
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text("Édition"),
      // ),
      appBar: AppBar(
        backgroundColor: Color(0xFF020D1F),
        centerTitle: true,
        title: Text('Éditer Votre Profil'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: AppColors.scaffoldBackgroundYellowForWelcomePage,
        dismissible: true,
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.yellowAppbar),
        ),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 90,
                    child: Image.asset("assets/edit.png"),
                  ),
                  SizedBox(height: 10),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     SizedBox(height: 10),
                  //     // Text(
                  //     //   "Nom",
                  //     //   style: TextStyle(color: AppColors.indigo),
                  //     // ),
                  //     Theme(
                  //       data: new ThemeData(
                  //         primaryColor: AppColors.indigo,
                  //       ),
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.all(Radius.circular(7)),
                  //           border: Border.all(color: Colors.black12),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(10.0),
                  //           child: new TextField(
                  //             onChanged: (String txt) {},
                  //             decoration: new InputDecoration(
                  //                 border: InputBorder.none,
                  //                 hintText: 'Votre nom',
                  //                 hintStyle: TextStyle(
                  //                     fontFamily: "Sans",
                  //                     fontSize: 15.0,
                  //                     color: Colors.black26)),
                  //           ),
                  //         ),
                  //       ),
                  //       //  TextFormField(
                  //       //   keyboardType: TextInputType.name,
                  //       //   textInputAction: TextInputAction.done,
                  //       //   maxLength: 20,
                  //       //   initialValue: widget.nom,
                  //       //   validator: (val) => validateNom(val),
                  //       //   onSaved: (val) => nom = val,
                  //       // ),
                  //     ),
                  //     SizedBox(height: 10),
                  //   ],
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     SizedBox(height: 10),
                  //     Theme(
                  //       data: new ThemeData(
                  //         primaryColor: AppColors.red,
                  //       ),
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.all(Radius.circular(7)),
                  //           border: Border.all(color: Colors.black12),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(10.0),
                  //           child: new TextField(
                  //             onChanged: (String txt) {},
                  //             decoration: new InputDecoration(
                  //                 border: InputBorder.none,
                  //                 hintText: 'Prénom(s)',
                  //                 hintStyle: TextStyle(
                  //                     fontFamily: "Sans",
                  //                     fontSize: 15.0,
                  //                     color: Colors.black26)),
                  //           ),
                  //         ),
                  //       ),
                  //       //  TextFormField(
                  //       //   keyboardType: TextInputType.name,
                  //       //   textInputAction: TextInputAction.done,
                  //       //   maxLength: 20,
                  //       //   initialValue: widget.nom,
                  //       //   validator: (val) => validateNom(val),
                  //       //   onSaved: (val) => nom = val,
                  //       // ),
                  //     ),
                  //     SizedBox(height: 10),
                  //   ],
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     SizedBox(height: 10),
                  //     Theme(
                  //       data: new ThemeData(
                  //         primaryColor: AppColors.indigo,
                  //       ),
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           border: Border.all(color: Colors.black12),
                  //           borderRadius: BorderRadius.all(Radius.circular(7)),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(12.0),
                  //           child: new TextField(
                  //             onChanged: (String txt) {},
                  //             decoration: new InputDecoration(
                  //                 border: InputBorder.none,
                  //                 hintText: 'Télephone',
                  //                 hintStyle: TextStyle(
                  //                     fontFamily: "Sans",
                  //                     fontSize: 15.0,
                  //                     color: Colors.black26)),
                  //           ),
                  //         ),
                  //       ),
                  //       //  TextFormField(
                  //       //   keyboardType: TextInputType.name,
                  //       //   textInputAction: TextInputAction.done,
                  //       //   maxLength: 20,
                  //       //   initialValue: widget.nom,
                  //       //   validator: (val) => validateNom(val),
                  //       //   onSaved: (val) => nom = val,
                  //       // ),
                  //     ),
                  //     SizedBox(height: 10),
                  //   ],
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        initialValue: widget.nom,
                        decoration: InputDecoration(
                          labelText: "Nom",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        onSaved: (newValue) {
                          nom = newValue;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer Votre Nom";
                          }
                          // if (value.length < 8) {
                          //   return "Au moins 8 caractères requis";
                          // }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),

                      TextFormField(
                        initialValue: widget.prenoms,
                        decoration: InputDecoration(
                            labelText: "Prénom(s)",
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
                        keyboardType: TextInputType.text,
                        onSaved: (newValue) {
                          prenoms = newValue;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer Votre Prénom(s)";
                          }
                          // if (value.length < 8) {
                          //   return "Au moins 8 caractères requis";
                          // }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                       enabled: false,
                        readOnly: true,
                        initialValue: widget.telephone,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Télephone",
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
                        keyboardType: TextInputType.phone,
                        onSaved: (newValue) {
                          telephone = newValue;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer le numero de Telephone";
                          }
                          if (value.length < 8) {
                            return "Au moins 8 caractères requis";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        initialValue: widget.email,
                        decoration: InputDecoration(
                            labelText: "Adresse Email",
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
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (newValue) {
                          email = newValue;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer votre Adresse";
                          }
                          // if (value.length < 8) {
                          //   return "Au moins 8 caractères requis";
                          // }
                          return null;
                        },
                      ),
                      // Theme(
                      //   data: new ThemeData(
                      //     primaryColor: AppColors.red,
                      //   ),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.all(Radius.circular(7)),
                      //       border: Border.all(color: Colors.black12),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(12.0),
                      //       child: new TextField(
                      //         onChanged: (String txt) {},
                      //         decoration: new InputDecoration(
                      //             border: InputBorder.none,
                      //             hintText: 'Adresse Email',
                      //             hintStyle: TextStyle(
                      //                 fontFamily: "Sans",
                      //                 fontSize: 15.0,
                      //                 color: Colors.black26)),
                      //       ),
                      //     ),
                      //   ),
                      //   //  TextFormField(
                      //   //   keyboardType: TextInputType.name,
                      //   //   textInputAction: TextInputAction.done,
                      //   //   maxLength: 20,
                      //   //   initialValue: widget.nom,
                      //   //   validator: (val) => validateNom(val),
                      //   //   onSaved: (val) => nom = val,
                      //   // ),
                      // ),
                      // SizedBox(height: 10),
                    ],
                  ),
                  // SizedBox(height: 15),

                  ///VALIDATION BUTTON
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 25, 5, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              print(token);
                              if (await DataConnectionChecker().hasConnection) {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  setState(() {
                                    showSpinner = true;
                                    print(nom);
                                  });
                                  var reponse =
                                      await providerAuth.updateUserInfo(
                                          id.toString(),
                                          nom,
                                          telephone,
                                          token.toString(),
                                          prenoms,
                                          email);
                                  setState(() {
                                    showSpinner = false;
                                    // print(reponse);
                                  });

                                  if (reponse['status'] == 200) {
                                    print(reponse);
                                    await saveinSharedPreferencesClass(reponse);
                                    await getNewToken(context: context);
                                    // Navigator.of(context);
                                    ShowMessage();
                                    NavigatorState navigator =
                                        Navigator.of(context);
                                    Route route = ModalRoute.of(context);
                                    navigator.removeRouteBelow(route);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfilePage(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          // reponse.toString(),
                                          reponse['message'].toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        margin:
                                            EdgeInsets.fromLTRB(15, 0, 15, 30),
                                      ),
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ProfilInformation()));
                                  }
                                } else {
                                  noConnectionSnackbar(context: context);
                                }
                              }
                            },
                            style: ButtonStyle(
                              visualDensity: VisualDensity.standard,
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFF020D1F),
                              ),
                            ),
                            child: Text(
                              "Modifier",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
