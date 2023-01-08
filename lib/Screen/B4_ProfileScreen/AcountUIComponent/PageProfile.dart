import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/ChangePassword.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/EditProfile.dart';
import '../../../helper/dataConnectionChecker.dart';
import '../../../services/localDatabase.dart';
import '../../../services/shared_preferences.dart';
import '../../../state/appState.dart';
import '../../../state/articleState.dart';
import '../../../state/authState.dart';
import '../../../state/insertFromPanierState.dart';
import '../../../state/messageState.dart';
import '../../../state/newOrderState.dart';
import '../../../state/notificationState.dart';
import '../../../state/orderState.dart';
import '../../../state/panierState.dart';

import '../../../constants/appColors.dart';

String nomprofil, prenomProfil, telephoneprofil, emailprofil;

Widget customRow(String titlePart1, String titlePart2,
    {int flex1 = 3, int flex2 = 1}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
    child: Row(
      children: [
        Flexible(
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titlePart1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.5,
                ),
              ),
              Flexible(
                child: Text(
                  titlePart2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class ProfilInformation extends StatelessWidget {
  final String nom, telephone, codeParrainage, fileuls, email, prenom;
  ProfilInformation(
      {Key key,
      this.nom,
      this.telephone,
      this.codeParrainage,
      this.prenom,
      this.fileuls,
      this.email})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // double defautlsize = SizeConfig;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 500,
            child: Stack(
              children: [
                ClipPath(
                  clipper: customShape(),
                  child: Container(
                    height: 140,
                    color: Color(0xFF020D1F),
                  ),
                ),
                Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/user-avatar.png"),
                            )),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       nom.toString().toUpperCase(),
                      //       style: TextStyle(fontSize: 20, color: Colors.black),
                      //     ),
                      //     SizedBox(width: 2),
                      //     Text(
                      //       prenom.toString(),
                      //       style: TextStyle(fontSize: 20, color: Colors.black),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      // Text(
                      //   email ?? 'esugu_user@gmail.com',
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w400, color: Colors.grey),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      LineInfo(
                        title: "Nom:",
                        libelle: nom.toString().toUpperCase() ?? 'Esugu-User',
                      ),
                      LineInfo(
                        title: "Prénoms:",
                        libelle: prenom.toString() ?? 'Esugu-User',
                      ),
                      LineInfo(
                        title: "Email:",
                        libelle: email.toString() ?? 'Esugu-User@gmail.com',
                      ),
                      LineInfo(
                        title: "Téléphone :",
                        libelle: telephone ?? 'Entrer votre num.',
                      ),
                      LineInfo(
                        title: "Code de Parrainage :",
                        libelle: codeParrainage.toString() ?? '',
                      ),
                      // LineInfo(
                      //   title: "Adresse :",
                      //   libelle: "Agoe Demakpoe",
                      // ),
                      // LineInfo(
                      //   title: "Pays :",
                      //   libelle: "Togo",
                      // ),
                      // LineInfo(
                      //   title: "Fileuls :",
                      //   libelle: "34",
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                        nom: nom ?? 'Esugu User',
                                        prenoms: prenom ?? "Usugu User",
                                        telephone:
                                            telephone ?? "Entrer votre numero",
                                        email: email ?? 'visiondd@gmail.com'),
                                  ),
                                );
                              },
                              child: Text('MODIFIER VOS INFORMATIONS'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF020D1F)),
                              onPressed: () {
                                // print(nom);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePassword(),
                                  ),
                                );
                              },
                              child: Text(
                                'MODIFIER MOT DE PASSE',
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey),
                              onPressed: () {
                                Clipboard.setData(
                                  new ClipboardData(
                                      text: codeParrainage.toString()),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Code de parrainage copie avec succes',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
                                  ),
                                );
                              },
                              child: Text(
                                'COPIER LE CODE DE PARRAINAGE',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LineInfo extends StatelessWidget {
  final String title, libelle;
  final Function onLongPress;
  const LineInfo(
      {Key key,
      this.title = "Titre",
      this.libelle = "Libelle",
      this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size dSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          Text(
            libelle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )
          // Text('Email@gmail.com'),
        ],
      ),
    );
  }
}

class customShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text("Informations"),
      // ),
      appBar: AppBar(
        backgroundColor: Color(0xFF020D1F),
        centerTitle: true,
        elevation: 0,
        title: Text('Informations'),
      ),
      body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            SharedPreferences prefs = snap.data;
            String nom = prefs.getString("nom");
            String prenoms = prefs.getString("prenoms");
            String nomComplet = prefs.getString("nomComplet");
            String indicatif = prefs.getString('indicatif');
            String telephone = prefs.getString("number");
            String email = prefs.getString("mail");
            String codeParrainage = prefs.getString("code");
            final List _profiledata = [
              {
                "type": "Nom: ",
                "title": nomComplet ?? "Nador Mike",
                // "trailing": "Editer",
              },
              {
                "type": "Téléphone: ",
                "title": '$telephone' != 'null'
                    ? ('+' + '$indicatif' + ' ' + telephone)
                    : " +228 90000990",
                // "trailing": "Editer",
              },
              {
                "type": "Email: ",
                "title": email ?? "esugu@gmail.tg",
                // "trailing": "Editer",
              },
              /* {
                "type": "Code parrainage: ",
                "title": codeParrainage ?? "..",
                "trailing": "Copier",
              }, */
            ];
            return SingleChildScrollView(
              // padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: ProfilInformation(
                nom: nom,
                telephone: telephone,
                codeParrainage: codeParrainage,
                fileuls: prenoms,
                email: email,
                prenom: prenoms,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     // Center(
              //     //   child: Container(
              //     //     padding: EdgeInsets.all(7.2),
              //     //     decoration: BoxDecoration(
              //     //         shape: BoxShape.circle,
              //     //         color: AppColors.indigo,
              //     //         border: Border.all(color: Colors.black, width: 1)),
              //     //     child: Icon(
              //     //       Icons.person,
              //     //       size: 43,
              //     //       color: Colors.white,
              //     //     ),
              //     //   ),
              //     // ),
              //     Container(
              //       margin: EdgeInsets.only(top: 8),
              //       padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.all(Radius.circular(20))),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           for (var i = 0; i < _profiledata.length; i++)
              //             Column(
              //               children: [
              //                 customRow(
              //                   _profiledata[i]["type"],
              //                   _profiledata[i]["title"],
              //                   // _profiledata[i]["trailing"],
              //                 ),
              //                 (i != 3) ? Divider() : Container(),
              //               ],
              //             ),
              //           customRow("Code parrainage", "...."),
              //           Divider(),
              //           customRow("Filleuls :", "..."),
              //           Divider()
              //           // Text(
              //           //   "Code parrainage: ",
              //           //   style: TextStyle(
              //           //     color: Colors.black,
              //           //     fontSize: 18.5,
              //           //   ),
              //           // ),
              //           // Row(
              //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           //   children: [
              //           //     Text(
              //           //       codeParrainage ?? "..",
              //           //       overflow: TextOverflow.ellipsis,
              //           //       style: TextStyle(
              //           //         color: Colors.black,
              //           //         fontSize: 18.5,
              //           //         fontWeight: FontWeight.w500,
              //           //       ),
              //           //     ),
              //           //     // OutlinedButton(
              //           //     //   style: ButtonStyle(
              //           //     //     backgroundColor:
              //           //     //         MaterialStateProperty.resolveWith<Color>(
              //           //     //       (Set<MaterialState> states) => Colors.blue,
              //           //     //     ),
              //           //     //   ),
              //           //     //   onPressed: () {
              //           //     //     Clipboard.setData(
              //           //     //       new ClipboardData(text: codeParrainage ?? ""),
              //           //     //     );
              //           //     //     ScaffoldMessenger.of(context).showSnackBar(
              //           //     //       SnackBar(
              //           //     //         content: Text(
              //           //     //           "Le code a été copié.",
              //           //     //           textAlign: TextAlign.center,
              //           //     //         ),
              //           //     //         behavior: SnackBarBehavior.floating,
              //           //     //         margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
              //           //     //       ),
              //           //     //     );
              //           //     //   },
              //           //     //   child: Text(
              //           //     //     "Copier",
              //           //     //     style: TextStyle(
              //           //     //       color: Colors.white,
              //           //     //       fontSize: 13.5,
              //           //     //     ),
              //           //     //   ),
              //           //     // ),
              //           //   ],
              //           // ),
              //           // Row(
              //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           //   children: [
              //           //     Row(
              //           //       mainAxisSize: MainAxisSize.min,
              //           //       children: [
              //           //         Text(
              //           //           "Filleuls :",
              //           //           style: TextStyle(
              //           //               color: Colors.black, fontSize: 16.0),
              //           //         ),
              //           //         SizedBox(
              //           //           width: 18,
              //           //         ),
              //           //         FutureBuilder(
              //           //             future:
              //           //                 DataConnectionChecker().hasConnection,
              //           //             builder: (context, snaps) {
              //           //               if ((snaps.connectionState ==
              //           //                       ConnectionState.done) &&
              //           //                   snaps.data) {
              //           //                 return FutureBuilder(
              //           //                   future: Provider.of<AuthState>(
              //           //                           context,
              //           //                           listen: false)
              //           //                       .countFilleul(context: context),
              //           //                   builder: (context, snapshot) {
              //           //                     if (snapshot.connectionState ==
              //           //                         ConnectionState.done) {
              //           //                       return Text(
              //           //                         (snapshot.data[0]
              //           //                             ? snapshot.data[1]
              //           //                                 .toString()
              //           //                             : ".."),
              //           //                         style: TextStyle(
              //           //                           color: Colors.black,
              //           //                           fontSize: 16.0,
              //           //                           fontWeight: FontWeight.bold,
              //           //                         ),
              //           //                       );
              //           //                     }
              //           //                     return CircularProgressIndicator();
              //           //                   },
              //           //                 );
              //           //               }
              //           //               return Text(
              //           //                 "..",
              //           //                 style: TextStyle(
              //           //                   color: Colors.black,
              //           //                   fontSize: 16.0,
              //           //                   fontWeight: FontWeight.bold,
              //           //                 ),
              //           //               );
              //           //             }),
              //           //       ],
              //           //     ),
              //           //     // OutlinedButton(
              //           //     //   style: ButtonStyle(
              //           //     //     backgroundColor: MaterialStateProperty.all(
              //           //     //       Colors.yellowAccent,
              //           //     //     ),
              //           //     //   ),
              //           //     //   onPressed: () {
              //           //     //     setState(() {});
              //           //     //   },
              //           //     //   child: Text(
              //           //     //     "ACTUALISER",
              //           //     //     style: TextStyle(
              //           //     //       color: AppColors.indigo,
              //           //     //     ),
              //           //     //   ),
              //           //     // ),
              //           //   ],
              //           // ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(height: 35),
              //     Center(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               GestureDetector(
              //                 onTap: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                       builder: (context) => EditProfile(
              //                         nom: nom,
              //                         prenoms: prenoms,
              //                         telephone: telephone,
              //                         email: email,
              //                       ),
              //                     ),
              //                   );
              //                 },
              //                 child: OutlinedButton(
              //                   style: ButtonStyle(
              //                     backgroundColor: MaterialStateProperty.all(
              //                       Colors.blueAccent,
              //                     ),
              //                   ),
              //                   onPressed: () {
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(
              //                         builder: (context) => EditProfile(
              //                           nom: nom,
              //                           prenoms: prenoms,
              //                           telephone: telephone,
              //                           email: email,
              //                         ),
              //                       ),
              //                     );
              //                     // setState(() {});
              //                   },
              //                   child: Text(
              //                     "Éditer le profil",
              //                     style: TextStyle(
              //                       fontSize: 15,
              //                       color: Colors.white,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(width: 10),
              //               GestureDetector(
              //                   onTap: () => Navigator.push(
              //                       context,
              //                       MaterialPageRoute(
              //                         builder: (context) => ChangePassword(),
              //                       )),
              //                   child: OutlinedButton(
              //                     style: ButtonStyle(
              //                       backgroundColor: MaterialStateProperty.all(
              //                         Colors.greenAccent,
              //                       ),
              //                     ),
              //                     onPressed: () {
              //                       Navigator.push(
              //                           context,
              //                           MaterialPageRoute(
              //                             builder: (context) =>
              //                                 ChangePassword(),
              //                           ));
              //                     },
              //                     child: Text(
              //                       "Mot de passe",
              //                       style: TextStyle(
              //                         fontSize: 15,
              //                         color: Colors.white,
              //                       ),
              //                     ),
              //                   )),
              //             ],
              //           ),

              //           SizedBox(height: 15),
              //           // GestureDetector(
              //           //   onTap: () async {
              //           //     SharedPreferences sPref =
              //           //         await SharedPreferences.getInstance();
              //           //     await sPref.clear();
              //           //     await LocalDatabaseManager.database
              //           //         .delete('panier', where: '1');
              //           //     Provider.of<AppState>(
              //           //       context,
              //           //       listen: false,
              //           //     ).clear();
              //           //     Provider.of<ArticleState>(
              //           //       context,
              //           //       listen: false,
              //           //     ).clear();
              //           //     Provider.of<AuthState>(
              //           //       context,
              //           //       listen: false,
              //           //     ).clear();
              //           //     Provider.of<InsertFromPanierState>(
              //           //       context,
              //           //       listen: false,
              //           //     ).clear();
              //           //     Provider.of<MessageState>(
              //           //       context,
              //           //       listen: false,
              //           //     ).clear();
              //           //     Provider.of<NewOrderState>(
              //           //       context,
              //           //       listen: false,
              //           //     ).clear();
              //           //     Provider.of<NotificationState>(
              //           //       context,
              //           //       listen: false,
              //           //     ).clear();

              //           //     Provider.of<OrderState>(
              //           //       context,
              //           //       listen: false,
              //           //     ).clear();
              //           //     Provider.of<PanierState>(
              //           //       context,
              //           //       listen: false,
              //           //     ).clear();
              //           //     Provider.of<MessageState>(
              //           //       context,
              //           //       listen: false,
              //           //     ).clearSAV();
              //           //     /* Provider.of<TransactionState>(
              //           //       context,
              //           //       listen: false,
              //           //     ).clear(); */
              //           //     await sPref.setBool("isFreshlyInstalled", false);
              //           //     await sPref.setBool("isLoggedIn", false);
              //           //     // Navigator.of(context).pushAndRemoveUntil(
              //           //     //     MaterialPageRoute(
              //           //     //       builder: (context) => WelcomePage(),
              //           //     //     ),
              //           //     //     (Route<dynamic> route) => false);
              //           //   },
              //           //   child: Text(
              //           //     "Déconneter ce compte",
              //           //     style: TextStyle(
              //           //       fontSize: 20,
              //           //       color: AppColors.red,
              //           //     ),
              //           //   ),
              //           // ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(height: 30),
              //   ],
              // ),
            );
          }
          return Center(
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 10),
                  Text("Récupération des données ..")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
