import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/appColors.dart';
import '../../../helper/dataConnectionChecker.dart';
import '../../../state/transactionState.dart';
import '../../../widgets/customWidgets.dart';

TextStyle zStyle = TextStyle(fontSize: 14.0);

class DebtDetails extends StatefulWidget {
  @override
  _DebtDetailsState createState() => _DebtDetailsState();
}

class _DebtDetailsState extends State<DebtDetails> {
  List<String> monthString = [
    "JANVIER",
    "FÉVRIER",
    "MARS",
    "AVRIL",
    "MAI",
    "JUIN",
    "JUILLET",
    "AOÛT",
    "SEPTEMBRE",
    "OCTOBRE",
    "NOVEMBRE",
    "DÉCEMBRE",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     "Reste à payer",
      //     style: TextStyle(
      //       fontSize: 14,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      appBar: AppBar(
        backgroundColor: AppColors.redAppbar,
        centerTitle: true,
        title: Text('Reste à payer'),
      ),
      body: FutureBuilder(
          future: DataConnectionChecker().hasConnection,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              if (snap.data) {
                return FutureBuilder(
                  future: Provider.of<TransactionState>(context, listen: false)
                      .debtsDetails(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data[0]) {
                        if (snapshot.data[1] != null &&
                            snapshot.data[1].length != 0) {
                          List<Widget> elements = [];
                          for (var i = 0; i < snapshot.data[1].length; i++) {
                            Map d = Map.from(snapshot.data[1][i]);
                            elements.add(
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => OrderDetails(
                                  //       id: d['commande_id'].toString(),
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Card(
                                  elevation: 3,
                                  margin: EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${d['commande_ref']}",
                                              style: zStyle,
                                            ),
                                            Text(
                                              "${d['date_commande']}"
                                              /* (d['date'].substring(
                                                  0, d['date'].indexOf('/'))) +
                                              ' ' +
                                              monthString[int.parse(d['date']
                                                      .substring(
                                                          d['date'].indexOf('/') + 1)
                                                      .substring(0, 2)) -
                                                  1] +
                                              ' ' +
                                              (d['date']
                                                  .substring(
                                                      d['date'].indexOf('/') + 1)
                                                  .substring(3)) */
                                              ,
                                              style: zStyle,
                                            ),
                                            Text(
                                              "À régler à la livraison : " +
                                                  "${d['reste_a_payer']}",
                                              style: zStyle,
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
                          return ListView.builder(
                            itemBuilder: (context, index) => elements[index],
                            itemCount: elements.length,
                          );
                        } else {
                          return Container(
                            height: fullHeight(context),
                            width: fullWidth(context),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.hourglass_empty),
                                    Text(
                                      "Aucune transaction restante trouvée.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        return Container(
                          height: fullHeight(context),
                          width: fullWidth(context),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.link_off),
                                  Text(
                                    "Une erreur s'est produite. Notre équipe est en train de résoudre le problème.Veuillez réessayer plutard.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
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
                );
              }
              return Container(
                height: fullHeight(context),
                width: fullWidth(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off),
                        Text(
                          "Connection internet faible ou inexistante.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
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
          }),
    );
  }
}
