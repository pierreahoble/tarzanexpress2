import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/appAssets.dart';
// import 'package:tarzanexpress/page/inApp/accueil/suivis/DetailsuivisColis.dart';
import '../../../helper/dataConnectionChecker.dart';
import '../../../Model/order.dart';
// import '../../../page/inApp/homePage.dart';
import '../../../widgets/customWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/appColors.dart';
// import '../../../page/inApp/messages/orderConversation.dart';
import '../../../state/orderState.dart';

enum MenuOptions { Discuter, Details, Cacher }

class FilteredOrders extends StatefulWidget {
  final String title;
  final List<String> filterList;
  FilteredOrders({@required this.title, @required this.filterList});
  @override
  _FilteredOrdersState createState() => _FilteredOrdersState();
}

class _FilteredOrdersState extends State<FilteredOrders> {
  // afficher les produits
  // bool _isVisiblepro = false;
  // void showProduit() async {
  //   print("visible");
  //   setState(() {
  //     _isVisiblepro = !_isVisiblepro;
  //   });
  // }
  void _DetailSuivisColis(BuildContext context) {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => DetailSuivisColis()));
  }

// produit
  @override
  Widget CommendeProduit(BuildContext context) {
    return // offre n°1
        FittedBox(
      child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Container(
            // color: Colors.white,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  child: Image.asset(
                    AppAssets.popular1,
                    // height: 120,
                    // width: 120,
                    height: 80,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          // padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                          // transform: Matrix4.translationValues(-2, 0, 0),
                          margin: const EdgeInsets.only(right: 30.0),
                          child: Text(
                            "OANES 1102 L2 5 modes 1600",
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.0,

                              // fontWeight: FontWeight.bold,
                              // color: Colors.black
                            ),
                          ),
                        ),
                        Container(
                          // padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
                          margin: const EdgeInsets.only(right: 135.0),
                          child: Text(
                            "XOF 200",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.redAppbar),
                          ),
                        ),
                        Container(
                            // padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                            margin: const EdgeInsets.only(right: 85.0),
                            child: Row(
                              children: [
                                Text(
                                  "XOF 500",
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.cyan,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "50%",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    // decoration: TextDecoration.lineThrough
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "REMISE",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    // decoration: TextDecoration.lineThrough
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(height: 8),
                        Container(
                            // padding: EdgeInsets.fromLTRB(0, 0, 0, 100),

                            child: Row(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Text("Quantite "),
                                  //     SizedBox(width: 10),
                                  //     Text(
                                  //       "82",
                                  //       style: TextStyle(
                                  //         fontSize: 12.0,
                                  //         // fontWeight: FontWeight.bold,
                                  //         color: Colors.black,
                                  //         // decoration: TextDecoration.lineThrough
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      Text("X1 "),
                                      SizedBox(width: 10),
                                      Text(
                                        "2000",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          // decoration: TextDecoration.lineThrough
                                        ),
                                      ),
                                      Text("XOF"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 25),
                            InkWell(
                              onTap: () {
                                _DetailSuivisColis(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: AppColors.redAppbar,
                                ),
                                child: ImageIcon(
                                  AssetImage(AppAssets.suivi),
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<String> monthString = [
    "JAN",
    "FÉV",
    "MAR",
    "AVR",
    "MAI",
    "JUIN",
    "JUIL",
    "AOÛ",
    "SEP",
    "OCT",
    "NOV",
    "DÉC",
  ];

  TextStyle whiteColorTextStyle = TextStyle(color: Colors.white);
  ValueNotifier<bool> hideOrders = ValueNotifier(true);
  ValueNotifier<List<String>> hiddenOrdersId = ValueNotifier([]);
  ValueNotifier<String> filterFirstDate = ValueNotifier(
      ((DateTime.now().month - 6 > 0)
              ? "${DateTime.now().year}"
              : "${DateTime.now().year - 1}") +
          '/' +
          ((DateTime.now().month - 6 > 0)
              ? (((DateTime.now().month - 6).toString().length > 1
                  ? "${DateTime.now().month - 6}"
                  : "0${DateTime.now().month - 6}"))
              : (((DateTime.now().month + 6).toString().length > 1
                  ? "${DateTime.now().month + 6}"
                  : "0${DateTime.now().month + 6}"))) +
          '/' +
          (DateTime.now().day.toString().length > 1
              ? "${DateTime.now().day}"
              : "0${DateTime.now().day}"));
  ValueNotifier<String> filterLastDate = ValueNotifier(
      "${DateTime.now().year}" +
          '/' +
          (DateTime.now().month.toString().length > 1
              ? "${DateTime.now().month}"
              : "0${DateTime.now().month}") +
          '/' +
          (DateTime.now().day.toString().length > 1
              ? "${DateTime.now().day}"
              : "0${DateTime.now().day}"));

  Map<String, dynamic> etats = {
    //Annulé
    '0': Colors.brown,
    //EN COURS DE CÔTATION
    "1": AppColors.indigo,
    //En cours d'exécussion
    '2': AppColors.green,
    //EN ATTENTE DE PAIEMENT
    '3': AppColors.yellowAppbar,
    //En attente de livraison
    '4': Colors.teal,
    //Suspendu
    '5': AppColors.bgSecondary,
    //Refusé
    '6': Colors.black,
    //Terminé
    '7': Colors.blue,
    //En attente de livraison
    '8': Colors.teal,
    //En attente d'avis-Côtation
    '9': Colors.blueGrey,
    //En attente d'avis-Éxecution
    '10': Colors.lime,
  };

  String day = DateTime.now().day.toString();
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString();

  String reformatDate(String s) {
    String tempDate = s.substring(0, s.indexOf(' '));
    String day = tempDate.substring(0, tempDate.indexOf('/'));
    String month = tempDate.substring(
        tempDate.indexOf('/') + 1, tempDate.lastIndexOf('/'));
    String year = tempDate.substring(tempDate.lastIndexOf('/') + 1);
    return year + '-' + month + '-' + day + s.substring(s.indexOf(' '));
  }

  @override
  Widget build(BuildContext context) {
    Size dSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: AppColors.redAppbar,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: AppColors.redAppbar,
          ),
        ),
        centerTitle: true,
        actions: [
          ValueListenableBuilder(
            valueListenable: hideOrders,
            builder: (context, n, _) {
              return PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.black,
                ),
                color: Colors.white,
                onSelected: (value) async {
                  hideOrders.value = !hideOrders.value;
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      value: MenuOptions.Cacher,
                      child: Wrap(
                        children: [
                          Icon(
                            n
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.brown,
                          ),
                          Text(
                            (n ? "Afficher" : "Ne pas afficher") +
                                " les cachées",
                            style: TextStyle(
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: dSize.height * 0.0025),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(
          //       0, dSize.height * 0.01, 0, dSize.height * 0.0025),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       GestureDetector(
          //         child: ValueListenableBuilder(
          //             valueListenable: filterFirstDate,
          //             builder: (context, k, _) {
          //               return Text(
          //                 (k.substring(k.lastIndexOf('/') + 1)) +
          //                     ' ' +
          //                     monthString[int.parse(
          //                             ((k.substring(k.indexOf('/')))
          //                                     .substring(1, k.indexOf('/') - 1))
          //                                 .toString()) -
          //                         1] +
          //                     ' ' +
          //                     (k.substring(0, k.indexOf('/'))),
          //                 style: TextStyle(
          //                   fontSize: 20,
          //                   color: AppColors.indigo,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               );
          //             }),
          //         onTap: () async {
          //           DateTime tempDate;
          //           await showCupertinoModalPopup(
          //             context: context,
          //             builder: (context) => CupertinoActionSheet(
          //               actions: [
          //                 SizedBox(
          //                   height: dSize.height * 0.256,
          //                   child: CupertinoDatePicker(
          //                     minimumYear: 2019,
          //                     maximumDate: DateTime(DateTime.now().year,
          //                         DateTime.now().month, DateTime.now().day - 1),
          //                     initialDateTime: filterFirstDate.value != null
          //                         ? (DateTime(
          //                             int.parse(
          //                               filterFirstDate.value.substring(
          //                                 0,
          //                                 filterFirstDate.value.indexOf('/'),
          //                               ),
          //                             ),
          //                             int.parse(((filterFirstDate.value
          //                                         .substring(filterFirstDate
          //                                             .value
          //                                             .indexOf('/')))
          //                                     .substring(
          //                                         1,
          //                                         filterFirstDate.value
          //                                                 .indexOf('/') -
          //                                             1))
          //                                 .toString()),
          //                             int.parse(
          //                               filterFirstDate.value.substring(
          //                                   filterFirstDate.value
          //                                           .lastIndexOf('/') +
          //                                       1),
          //                             ),
          //                           ))
          //                         : DateTime(
          //                             DateTime.now().year,
          //                             DateTime.now().month,
          //                             DateTime.now().day - 1),
          //                     mode: CupertinoDatePickerMode.date,
          //                     onDateTimeChanged: (value) => tempDate = value,
          //                   ),
          //                 ),
          //               ],
          //               cancelButton: CupertinoActionSheetAction(
          //                 child: Text('OK'),
          //                 onPressed: () {
          //                   Navigator.pop(context);
          //                 },
          //               ),
          //             ),
          //           );
          //           if (tempDate != null)
          //             filterFirstDate.value = tempDate.year.toString() +
          //                 (tempDate.month.toString().length > 1
          //                     ? "/${tempDate.month}"
          //                     : "/0${tempDate.month}") +
          //                 (tempDate.day.toString().length > 1
          //                     ? "/${tempDate.day}"
          //                     : "/0${tempDate.day}");
          //         },
          //       ),
          //       Text(
          //         "À",
          //         style: TextStyle(fontSize: 20),
          //       ),
          //       GestureDetector(
          //         child: ValueListenableBuilder(
          //             valueListenable: filterLastDate,
          //             builder: (context, k, _) {
          //               return Text(
          //                 (k.substring(k.lastIndexOf('/') + 1)) +
          //                     ' ' +
          //                     monthString[int.parse(
          //                             ((k.substring(k.indexOf('/')))
          //                                     .substring(1, k.indexOf('/') - 1))
          //                                 .toString()) -
          //                         1] +
          //                     ' ' +
          //                     (k.substring(0, k.indexOf('/'))),
          //                 style: TextStyle(
          //                   fontSize: 20,
          //                   color: AppColors.indigo,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               );
          //             }),
          //         onTap: () async {
          //           DateTime tempDate;
          //           await showCupertinoModalPopup(
          //             context: context,
          //             builder: (context) => CupertinoActionSheet(
          //               actions: [
          //                 SizedBox(
          //                   height: dSize.height * 0.256,
          //                   child: CupertinoDatePicker(
          //                     minimumYear: 2019,
          //                     maximumDate: DateTime(DateTime.now().year,
          //                         DateTime.now().month, DateTime.now().day),
          //                     initialDateTime: filterLastDate.value != null
          //                         ? (DateTime(
          //                             int.parse(
          //                               filterLastDate.value.substring(
          //                                 0,
          //                                 filterLastDate.value.indexOf('/'),
          //                               ),
          //                             ),
          //                             int.parse(((filterLastDate.value
          //                                         .substring(filterLastDate
          //                                             .value
          //                                             .indexOf('/')))
          //                                     .substring(
          //                                         1,
          //                                         filterLastDate.value
          //                                                 .indexOf('/') -
          //                                             1))
          //                                 .toString()),
          //                             int.parse(
          //                               filterLastDate.value.substring(
          //                                   filterLastDate.value
          //                                           .lastIndexOf('/') +
          //                                       1),
          //                             ),
          //                           ))
          //                         : DateTime(DateTime.now().year,
          //                             DateTime.now().month, DateTime.now().day),
          //                     mode: CupertinoDatePickerMode.date,
          //                     onDateTimeChanged: (value) => tempDate = value,
          //                   ),
          //                 ),
          //               ],
          //               cancelButton: CupertinoActionSheetAction(
          //                 child: Text('OK'),
          //                 onPressed: () {
          //                   Navigator.pop(context);
          //                 },
          //               ),
          //             ),
          //           );
          //           if (tempDate != null)
          //             filterLastDate.value = tempDate.year.toString() +
          //                 (tempDate.month.toString().length > 1
          //                     ? "/${tempDate.month}"
          //                     : "/0${tempDate.month}") +
          //                 (tempDate.day.toString().length > 1
          //                     ? "/${tempDate.day}"
          //                     : "/0${tempDate.day}");
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapA) {
              if (snapA.connectionState == ConnectionState.done) {
                if (snapA.data != null) {
                  SharedPreferences uPrefs = snapA.data;
                  if (uPrefs.containsKey("hiddenOrdersId")) {
                    hiddenOrdersId =
                        ValueNotifier(uPrefs.getStringList('hiddenOrdersId'));
                  } else {
                    uPrefs.setStringList("hiddenOrdersId", []);
                  }

                  return FutureBuilder(
                      future: DataConnectionChecker().hasConnection,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data) {
                            return FutureBuilder(
                              // future: Provider.of<OrderState>(context,
                              //         listen: false)
                              //     .getOrders(context: context),
                              builder: (context, a) {
                                if (a.connectionState == ConnectionState.done) {
                                  if (!a.data[0]) {
                                    return Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.link_off),
                                                Text(
                                                  "Une erreur s'est produite. Notre équipe est en train de résoudre le problème. Veuillez réessayer plutard.",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return Flexible(
                                    child: SingleChildScrollView(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: dSize.width * 0.04166,
                                          vertical: dSize.height * 0.014245),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          if (a.data[0])
                                            ValueListenableBuilder(
                                              valueListenable: filterFirstDate,
                                              builder: (context0, l, _) {
                                                List<Order> firstFiltered = [];
                                                DateTime start = DateTime.parse(
                                                  l.replaceAll('/', '-') +
                                                      " 00:00:00",
                                                );
                                                for (var i = 0;
                                                    i < a.data[1].length;
                                                    i++) {
                                                  int result = start
                                                      .compareTo(DateTime.parse(
                                                    reformatDate(
                                                      a.data[1][i]
                                                              .detailsCommande[
                                                          "date_commande"],
                                                    ),
                                                  ));
                                                  if (result < 1 ||
                                                      result == 0) {
                                                    firstFiltered
                                                        .add(a.data[1][i]);
                                                  }
                                                }
                                                return ValueListenableBuilder(
                                                  valueListenable:
                                                      filterLastDate,
                                                  builder: (context1, m, _) {
                                                    List<Order> lastFiltered =
                                                        [];
                                                    DateTime end =
                                                        DateTime.parse(
                                                      m.replaceAll('/', '-') +
                                                          " 23:59:59",
                                                    );
                                                    for (var i = 0;
                                                        i <
                                                            firstFiltered
                                                                .length;
                                                        i++) {
                                                      int result =
                                                          end.compareTo(
                                                              DateTime.parse(
                                                        reformatDate(
                                                          firstFiltered[i]
                                                                  .detailsCommande[
                                                              "date_commande"],
                                                        ),
                                                      ));
                                                      if (result > -1 ||
                                                          result == 0) {
                                                        if (widget.filterList !=
                                                            null) {
                                                          if (widget.filterList
                                                              .contains(
                                                                  firstFiltered[
                                                                              i]
                                                                          .statut[
                                                                      "param2"])) {
                                                            lastFiltered.add(
                                                                firstFiltered[
                                                                    i]);
                                                          }
                                                        } else {
                                                          lastFiltered.add(
                                                              firstFiltered[i]);
                                                        }
                                                      }
                                                    }
                                                    if (lastFiltered.length ==
                                                        0)
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Column(
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                "AUCUNE COMMANDE TROUVÉE",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        19),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: fullHeight(
                                                                      context) *
                                                                  2 /
                                                                  3,
                                                              width: fullWidth(
                                                                  context),
                                                              child: Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              String _url = "https://www.youtube.com/watch?v=mHnvbWu-Ujo";
                                                                              await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
                                                                            },
                                                                            child:
                                                                                Card(
                                                                              elevation: 4,
                                                                              child: Container(
                                                                                height: dSize.height * 0.21,
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Center(
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.info_outline,
                                                                                        color: AppColors.redAppbar,
                                                                                      ),
                                                                                      SizedBox(height: 5),
                                                                                      Text(
                                                                                        "AIDE",
                                                                                        textAlign: TextAlign.center,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              while (Navigator.canPop(context)) {
                                                                                Navigator.pop(context);
                                                                              }
                                                                              // Navigator.pushReplacement(
                                                                              //   context,
                                                                              //   MaterialPageRoute(
                                                                              //     builder: (context) => HomePage(
                                                                              //       index: 2,
                                                                              //     ),
                                                                              //   ),
                                                                              // );
                                                                            },
                                                                            child:
                                                                                Card(
                                                                              elevation: 4,
                                                                              child: Container(
                                                                                height: dSize.height * 0.21,
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Center(
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.shopping_cart_outlined,
                                                                                        color: AppColors.redAppbar,
                                                                                      ),
                                                                                      SizedBox(height: 5),
                                                                                      Text(
                                                                                        "ALLER AU PANIER",
                                                                                        textAlign: TextAlign.center,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
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
                                                          ],
                                                        ),
                                                      );

                                                    return Column(
                                                      children: [
                                                        for (var i = 0;
                                                            i <
                                                                lastFiltered
                                                                    .length;
                                                            i++)
                                                          ValueListenableBuilder(
                                                            valueListenable:
                                                                hideOrders,
                                                            builder: (context,
                                                                n, _) {
                                                              return ValueListenableBuilder(
                                                                valueListenable:
                                                                    hiddenOrdersId,
                                                                builder:
                                                                    (context, o,
                                                                        _) {
                                                                  return (!n ||
                                                                          (!o.contains(
                                                                              lastFiltered[i].id)))
                                                                      ? GestureDetector(
                                                                          // onTap:
                                                                          //     () async {
                                                                          //   bool
                                                                          //       reloadPage =
                                                                          //       await Navigator.push(
                                                                          //     context,
                                                                          //     MaterialPageRoute(
                                                                          //       builder: (context) => OrderDetails(
                                                                          //         id: lastFiltered[i].id,
                                                                          //       ),
                                                                          //     ),
                                                                          //   );
                                                                          //   if ((reloadPage != null) &&
                                                                          //       reloadPage)
                                                                          //     setState(() {});
                                                                          // },
                                                                          child:
                                                                              Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                5,
                                                                                0,
                                                                                5),
                                                                            child: Container(
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.black12),
                                                                                child: Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Row(
                                                                                            children: [
                                                                                              Text(
                                                                                                "Réference commande",
                                                                                                style: TextStyle(
                                                                                                  // fontWeight: FontWeight.w600,
                                                                                                  fontSize: 12,
                                                                                                  // color: Colors.white,
                                                                                                ),
                                                                                              ),
                                                                                              // IconButton(
                                                                                              //   icon: Icon(Icons.arrow_drop_down),
                                                                                              //   iconSize: 20,
                                                                                              //   onPressed: () {
                                                                                              //     showProduit();
                                                                                              //   },
                                                                                              // ),
                                                                                            ],
                                                                                          ),
                                                                                          FittedBox(
                                                                                            child: Text(
                                                                                              lastFiltered[i].detailsCommande["date_commande"].toString(),
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              style: whiteColorTextStyle.copyWith(fontSize: 10, color: Colors.black),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(10.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Column(
                                                                                            children: [
                                                                                              Row(
                                                                                                children: [
                                                                                                  Text(
                                                                                                    "Etat: ",
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    lastFiltered[i].statut["param1"].toString(),
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    style: whiteColorTextStyle.copyWith(fontSize: 12, color: Colors.black),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              Row(
                                                                                                children: [
                                                                                                  Text("Montant: "),
                                                                                                  Text(
                                                                                                    lastFiltered[i].montantCommande == "null" ? ".." : lastFiltered[i].montantCommande ?? "..",
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    style: whiteColorTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                                                                                  ),
                                                                                                  Text(" XOF"),
                                                                                                ],
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          ElevatedButton(
                                                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.redAppbar), elevation: MaterialStateProperty.all(7)),
                                                                                            onPressed: () async {
                                                                                              // bool reloadPage = await Navigator.push(
                                                                                              //   context,
                                                                                              //   MaterialPageRoute(
                                                                                              //     builder: (context) => OrderDetails(
                                                                                              //       id: lastFiltered[i].id,
                                                                                              //     ),
                                                                                              //   ),
                                                                                              // );
                                                                                              // if ((reloadPage != null) && reloadPage) setState(() {});
                                                                                            },
                                                                                            child: Text(
                                                                                              "Détail",
                                                                                              style: TextStyle(
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 12,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    FittedBox(
                                                                                      child: Container(
                                                                                        child: Column(
                                                                                          children: [
                                                                                            CommendeProduit(context),
                                                                                            // CommendeProduit(context),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                          ),
                                                                          //             Container(
                                                                          //           margin:
                                                                          //               EdgeInsets.symmetric(vertical: dSize.height * 0.007122),
                                                                          //           padding: EdgeInsets.fromLTRB(
                                                                          //               dSize.width * 0.0694,
                                                                          //               dSize.height * 0.0356125,
                                                                          //               dSize.width * 0.0138,
                                                                          //               dSize.height * 0.0356125),
                                                                          //           decoration:
                                                                          //               BoxDecoration(
                                                                          //             color: etats[lastFiltered[i].statut["param2"]],
                                                                          //             borderRadius: BorderRadius.all(
                                                                          //               Radius.circular(12),
                                                                          //             ),
                                                                          //           ),
                                                                          //           child:
                                                                          //               Row(
                                                                          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          //             crossAxisAlignment: CrossAxisAlignment.start,
                                                                          //             children: [
                                                                          //               Flexible(
                                                                          //                 child: Column(
                                                                          //                   crossAxisAlignment: CrossAxisAlignment.start,
                                                                          //                   children: [
                                                                          //                     Text(
                                                                          //                       lastFiltered[i].reference,
                                                                          //                       overflow: TextOverflow.ellipsis,
                                                                          //                       style: whiteColorTextStyle.copyWith(
                                                                          //                         fontSize: 17,
                                                                          //                       ),
                                                                          //                     ),
                                                                          //                     SizedBox(height: dSize.height * 0.0099715),
                                                                          //                     Text(
                                                                          //                       lastFiltered[i].detailsCommande["date_commande"].toString(),
                                                                          //                       overflow: TextOverflow.ellipsis,
                                                                          //                       style: whiteColorTextStyle.copyWith(
                                                                          //                         fontSize: 17,
                                                                          //                       ),
                                                                          //                     ),
                                                                          //                     SizedBox(height: dSize.height * 0.009971),
                                                                          //                     Wrap(
                                                                          //                       /*mainAxisSize:
                                                                          // MainAxisSize.min,*/
                                                                          //                       children: [
                                                                          //                         Text(
                                                                          //                           "MONTANT: ",
                                                                          //                           style: whiteColorTextStyle.copyWith(
                                                                          //                             fontSize: 17,
                                                                          //                           ),
                                                                          //                         ),
                                                                          //                         Text(
                                                                          //                           lastFiltered[i].montantCommande == "null" ? ".." : lastFiltered[i].montantCommande ?? "..",
                                                                          //                           overflow: TextOverflow.ellipsis,
                                                                          //                           style: whiteColorTextStyle.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                                                                          //                         ),
                                                                          //                       ],
                                                                          //                     ),
                                                                          //                     SizedBox(height: dSize.height * 0.009971),
                                                                          //                     Wrap(
                                                                          //                       /*mainAxisSize:
                                                                          // MainAxisSize.min,*/
                                                                          //                       children: [
                                                                          //                         Text(
                                                                          //                           "ETAT: ",
                                                                          //                           style: whiteColorTextStyle.copyWith(
                                                                          //                             fontSize: 17,
                                                                          //                           ),
                                                                          //                         ),
                                                                          //                         Text(
                                                                          //                           lastFiltered[i].statut["param1"].toString(),
                                                                          //                           overflow: TextOverflow.ellipsis,
                                                                          //                           style: whiteColorTextStyle.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                                                                          //                         ),
                                                                          //                       ],
                                                                          //                     ),
                                                                          //                     lastFiltered[i].detailsCommande["date_livraison"] != null
                                                                          //                         ? Text(
                                                                          //                             "DATE LIVRAISON: " + lastFiltered[i].detailsCommande["date_livraison"].toString(),
                                                                          //                             overflow: TextOverflow.ellipsis,
                                                                          //                             style: whiteColorTextStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                                                                          //                           )
                                                                          //                         : Container(),
                                                                          //                   ],
                                                                          //                 ),
                                                                          //               ),
                                                                          //               PopupMenuButton(
                                                                          //                 icon: Icon(
                                                                          //                   Icons.more_vert_rounded,
                                                                          //                   color: Colors.white,
                                                                          //                 ),
                                                                          //                 color: Colors.white,
                                                                          //                 onSelected: (value) async {
                                                                          //                   if (value != MenuOptions.Cacher) {
                                                                          //                     bool reloadPage = await Navigator.push(
                                                                          //                       context,
                                                                          //                       MaterialPageRoute(
                                                                          //                         builder: (context) => value == MenuOptions.Discuter
                                                                          //                             ? OrderConversation(
                                                                          //                                 id: lastFiltered[i].id,
                                                                          //                                 reference: lastFiltered[i].reference,
                                                                          //                               )
                                                                          //                             : OrderDetails(
                                                                          //                                 id: lastFiltered[i].id,
                                                                          //                               ),
                                                                          //                       ),
                                                                          //                     );
                                                                          //                     if ((reloadPage != null) && reloadPage && (value != MenuOptions.Discuter)) setState(() {});
                                                                          //                   } else {
                                                                          //                     SharedPreferences uPrefs = await SharedPreferences.getInstance();
                                                                          //                     if (uPrefs != null) {
                                                                          //                       if (uPrefs.containsKey("hiddenOrdersId")) {
                                                                          //                         if (uPrefs.getStringList("hiddenOrdersId").contains(lastFiltered[i].id)) {
                                                                          //                           List<String> newList = uPrefs.getStringList("hiddenOrdersId");
                                                                          //                           newList.remove(lastFiltered[i].id);
                                                                          //                           uPrefs.setStringList("hiddenOrdersId", newList);
                                                                          //                           hiddenOrdersId.value = newList;
                                                                          //                         } else {
                                                                          //                           List<String> tempH = uPrefs.getStringList("hiddenOrdersId") + [lastFiltered[i].id];
                                                                          //                           uPrefs.setStringList(
                                                                          //                             "hiddenOrdersId",
                                                                          //                             tempH,
                                                                          //                           );
                                                                          //                           hiddenOrdersId.value = tempH;
                                                                          //                         }
                                                                          //                       } else {
                                                                          //                         uPrefs.setStringList(
                                                                          //                           "hiddenOrdersId",
                                                                          //                           [
                                                                          //                             lastFiltered[i].id
                                                                          //                           ],
                                                                          //                         );
                                                                          //                         hiddenOrdersId.value = [
                                                                          //                           lastFiltered[i].id
                                                                          //                         ];
                                                                          //                       }
                                                                          //                     } else {
                                                                          //                       ScaffoldMessenger.of(context).showSnackBar(
                                                                          //                         SnackBar(
                                                                          //                           content: Text(
                                                                          //                             "L'application a rencontré une erreur. Veuillez réessayer svp.",
                                                                          //                             textAlign: TextAlign.center,
                                                                          //                           ),
                                                                          //                           behavior: SnackBarBehavior.floating,
                                                                          //                           margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
                                                                          //                         ),
                                                                          //                       );
                                                                          //                     }
                                                                          //                   }
                                                                          //                 },
                                                                          //                 itemBuilder: (BuildContext context) {
                                                                          //                   return <PopupMenuEntry>[
                                                                          //                     PopupMenuItem(
                                                                          //                       value: MenuOptions.Discuter,
                                                                          //                       child: Row(
                                                                          //                         mainAxisSize: MainAxisSize.min,
                                                                          //                         children: [
                                                                          //                           Icon(Icons.mail_outline),
                                                                          //                           Text("Discuter"),
                                                                          //                         ],
                                                                          //                       ),
                                                                          //                     ),
                                                                          //                     PopupMenuItem(
                                                                          //                       value: MenuOptions.Details,
                                                                          //                       child: Row(
                                                                          //                         mainAxisSize: MainAxisSize.min,
                                                                          //                         children: [
                                                                          //                           Icon(Icons.arrow_circle_up_outlined),
                                                                          //                           Text("Détails"),
                                                                          //                         ],
                                                                          //                       ),
                                                                          //                     ),
                                                                          //                     PopupMenuItem(
                                                                          //                       value: MenuOptions.Cacher,
                                                                          //                       child: FutureBuilder(
                                                                          //                         future: SharedPreferences.getInstance(),
                                                                          //                         builder: (context, snapj) {
                                                                          //                           if (snapj.connectionState == ConnectionState.done && (snapj.data != null)) {
                                                                          //                             String jTitle = "Cacher";
                                                                          //                             if (snapj.data.getStringList("hiddenOrdersId").contains(lastFiltered[i].id)) {
                                                                          //                               jTitle = "Ne pas cacher";
                                                                          //                             }
                                                                          //                             return Row(
                                                                          //                               mainAxisSize: MainAxisSize.min,
                                                                          //                               children: [
                                                                          //                                 Icon(Icons.visibility),
                                                                          //                                 Text(jTitle),
                                                                          //                               ],
                                                                          //                             );
                                                                          //                           }
                                                                          //                           return Container();
                                                                          //                         },
                                                                          //                       ),
                                                                          //                     ),
                                                                          //                   ];
                                                                          //                 },
                                                                          //               ),
                                                                          //             ],
                                                                          //           ),
                                                                          //         ),
                                                                        )
                                                                      : Container();
                                                                },
                                                              );
                                                            },
                                                          ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return Expanded(
                                  child: Center(
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
                                  ),
                                );
                              },
                            );
                          }
                          return Expanded(
                            child: Container(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.wifi_off),
                                      Text(
                                        "Connection internet faible ou inexistante.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => setState(() {}),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.blue,
                                          ),
                                        ),
                                        child: Text(
                                          "RÉESSAYER",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return Expanded(
                          child: Center(
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
                          ),
                        );
                      });
                }
                return Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              "L'application a rencontré un problème. Veuillez réessayer svp !"),
                          SizedBox(height: 15),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: Text(
                                "RÉESSAYER",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 10),
                        Text("Initialisation..")
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
