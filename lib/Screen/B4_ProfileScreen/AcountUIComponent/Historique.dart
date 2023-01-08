import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/appColors.dart';
import '../../../helper/dataConnectionChecker.dart';
import '../../../state/transactionState.dart';
import '../../../widgets/customWidgets.dart';

TextStyle zStyle = TextStyle(fontSize: 14.0);

class HistoriquePortefeuille extends StatefulWidget {
  @override
  _HistoriquePortefeuilleState createState() => _HistoriquePortefeuilleState();
}

class _HistoriquePortefeuilleState extends State<HistoriquePortefeuille> {
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

  void showCustomModal({
    @required BuildContext context,
    @required List<Widget> jData,
  }) {
    showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.0356,
                horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: jData,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size dSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     "TRANSACTIONS",
      //     style: TextStyle(
      //       //color: Colors.orange,
      //       fontSize: 14,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      appBar: AppBar(
        backgroundColor: AppColors.redAppbar,
        centerTitle: true,
        title: Text('TRANSACTIONS'),
      ),
      body: FutureBuilder(
          future: DataConnectionChecker().hasConnection,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              if (snap.data) {
                return FutureBuilder(
                  // future: Provider.of<TransactionState>(context, listen: false)
                  //     .getTransacts(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data[0]) {
                        if (snapshot.data[1] != null &&
                            snapshot.data[1].length != 0) {
                          List<Widget> elements = [];
                          for (var i = 0; i < snapshot.data[1].length; i++) {
                            Map d = Map.from(snapshot.data[1][i]);
                            int montantCreditPortefeuille =
                                d['montantCreditPorteFeuille'] == null
                                    ? 0
                                    : (d['montantCreditPorteFeuille'] as int);
                            String modePaiement =
                                (Map.from(d["mode_paiement"])["param1"])
                                    .toString();
                            String etatPaiement =
                                (Map.from(d["etat_paiement"])["param1"])
                                    .toString();
                            String cmdConcernee = "..";
                            if (d["details_commande"] != null &&
                                !(montantCreditPortefeuille > 0)) {
                              final rt = Map.from(d["details_commande"]);
                              final ze = Map.from(rt["commande"]);
                              cmdConcernee = ze['reference'].toString();
                            }
                            //if (etatPaiement == "Effectué")
                            elements.add(
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(7.2, 3.5, 3.6, 3.5),
                                child: ListTile(
                                  onTap: () {
                                    showCustomModal(
                                      context: context,
                                      jData: [
                                        Center(
                                          child: Text(
                                            "TRANSACTION",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(height: dSize.height * 0.0142),
                                        Text(
                                          "Etat: " + etatPaiement,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(height: dSize.height * 0.0142),
                                        //DATE
                                        Text(
                                          "Date: " + d['date'].toString()
                                          /* (d['date'].substring(
                                                  0, d['date'].indexOf('/'))) +
                                              ' ' +
                                              monthString[int.parse(d['date']
                                                      .substring(d['date']
                                                              .indexOf('/') +
                                                          1)
                                                      .substring(0, 2)) -
                                                  1] +
                                              ' ' +
                                              (d['date']
                                                  .substring(
                                                      d['date'].indexOf('/') +
                                                          1)
                                                  .substring(3)) */
                                          ,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(height: dSize.height * 0.0142),
                                        Text(
                                          "Montant: " +
                                              ((montantCreditPortefeuille > 0
                                                      ? montantCreditPortefeuille
                                                          .toString()
                                                      : d['montant']) +
                                                  " XOF"),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(height: dSize.height * 0.0142),
                                        Text(
                                          "Type: " +
                                              (montantCreditPortefeuille > 0
                                                  ? "Recharge"
                                                  : "Paiement de commande"),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        if (!(montantCreditPortefeuille > 0))
                                          SizedBox(height: 10),
                                        if (!(montantCreditPortefeuille > 0))
                                          Text(
                                            "Réf. Cmd: " + cmdConcernee,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        SizedBox(height: dSize.height * 0.0142),
                                        Text(
                                          "Moyen de paiement: $modePaiement",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    );
                                  },
                                  leading: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blueGrey[50],
                                    ),
                                    child: Icon(
                                      /* montantCreditPortefeuille > 0 */
                                      etatPaiement == "Effectué"
                                          ? Icons.check_outlined
                                          : Icons.close_outlined,
                                      color: etatPaiement == "Effectué"
                                          ? Colors.green.shade400
                                          : Colors.red.shade400,
                                    ),
                                  ),
                                  title: Text(
                                    montantCreditPortefeuille > 0
                                        ? "Recharge"
                                        : "Paiement",
                                    /*  par $modePaiement de la commande $cmdConcernee" */
                                    style: zStyle,
                                  ),
                                  subtitle: Text(
                                    "${d['date']}"
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
                                  trailing: Text(
                                    (montantCreditPortefeuille > 0
                                            ? montantCreditPortefeuille
                                                .toString()
                                            : d['montant']) +
                                        " XOF",
                                    style: zStyle.copyWith(
                                        fontWeight: FontWeight.w600),
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
                                      "Aucune transaction trouvée.",
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
