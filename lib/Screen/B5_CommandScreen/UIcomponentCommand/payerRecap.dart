import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../../../helper/utils.dart';
import '../../../constants/appColors.dart';
import '../../../helper/dataConnectionChecker.dart';
// import '../../../page/inApp/commandes/paygateWebview.dart';
import '../../../state/orderState.dart';

class PayerRecap extends StatefulWidget {
  final String commandeId;
  final String montantApayer;
  final String type;
  final String method;
  final String reference;
  PayerRecap({
    @required this.commandeId,
    @required this.montantApayer,
    @required this.method,
    @required this.reference,
    @required this.type,
  });
  @override
  _PayerRecapState createState() => _PayerRecapState();
}

class _PayerRecapState extends State<PayerRecap> {
  String telephone;
  String montant;
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      color: AppColors.scaffoldBackgroundYellowForWelcomePage,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.yellowAppbar),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: AppColors.redAppbar),
          title:
              Text(widget.commandeId == null ? "RECHARGE" : "RÉCAP PAIEMENT"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 2)),
                  padding: EdgeInsets.all(3.6),
                  child: Text(
                    "Vous serez dirigé vers une page sécurisée où toutes les communications sont encryptées et signées via SSL/TLS.\nSoyez donc tranquille, vos données sont sécurisées et restent confidentielles.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  widget.commandeId != null
                      ? "Paiement de " + "\"" + widget.type + "\""
                      : "Recharge du portefeuille",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.redAppbar,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  widget.commandeId == null
                      ? "Méthode de paiement :"
                      : "Montant à prélever :",
                  style: TextStyle(
                    color: AppColors.indigo,
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  widget.commandeId == null
                      ? widget.method
                      : (widget.montantApayer + " FCFA"),
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.commandeId == null
                          ? "Montant de la recharge"
                          : "Méthode de paiement :",
                      style: TextStyle(
                        color: AppColors.indigo,
                        fontSize: 15.0,
                      ),
                    ),
                    widget.commandeId == null
                        ? Theme(
                            data: new ThemeData(
                              primaryColor: AppColors.indigo,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(fontSize: 17.0),
                              decoration: InputDecoration(
                                hintText: "Montant",
                                hintStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15.0,
                                ),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "N'oubliez pas le montant!";
                                }
                                for (var i = 0; i < val.length; i++) {
                                  if (val[i] != "0" &&
                                      val[i] != "1" &&
                                      val[i] != "2" &&
                                      val[i] != "3" &&
                                      val[i] != "4" &&
                                      val[i] != "5" &&
                                      val[i] != "6" &&
                                      val[i] != "7" &&
                                      val[i] != "8" &&
                                      val[i] != "9") {
                                    return 'Montant Invalide!';
                                  }
                                }
                                if (val.contains(" ")) {
                                  return "Entrez un montant sans espace";
                                }
                                return null;
                              },
                              onSaved: (val) => montant = val,
                            ),
                          )
                        : Text(
                            widget.method,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Télephone",
                      style: TextStyle(
                        color: AppColors.indigo,
                        fontSize: 15.0,
                      ),
                    ),
                    Theme(
                      data: new ThemeData(
                        primaryColor: AppColors.indigo,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: 17.0),
                        decoration: InputDecoration(
                          hintText: "Numéro de téléphone",
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15.0,
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "N'oubliez pas le numéro!";
                          }
                          for (var i = 0; i < val.length; i++) {
                            if (val[i] != "0" &&
                                val[i] != "1" &&
                                val[i] != "2" &&
                                val[i] != "3" &&
                                val[i] != "4" &&
                                val[i] != "5" &&
                                val[i] != "6" &&
                                val[i] != "7" &&
                                val[i] != "8" &&
                                val[i] != "9") {
                              return 'Numéro Invalide!';
                            }
                          }
                          if (val.contains(" ")) {
                            return "Entrez un numéro sans espace";
                          }
                          return null;
                        },
                        onSaved: (val) => telephone = val,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (await DataConnectionChecker().hasConnection) {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              setState(() {
                                showSpinner = true;
                              });
                              OrderState orderState = Provider.of<OrderState>(
                                  context,
                                  listen: false);
                              List reponse = await (widget.commandeId == null
                                  ? (orderState.makeTransaction(
                                      context: context,
                                      methode: widget.method,
                                      montant: int.parse(montant).toString(),
                                      numero: telephone,
                                      commandeId: null,
                                      reference: null,
                                      type: null,
                                    ))
                                  : (orderState.makeTransaction(
                                      context: context,
                                      commandeId: widget.commandeId,
                                      methode: widget.method,
                                      montant: widget.montantApayer,
                                      numero: telephone,
                                      reference: widget.reference,
                                      type: widget.type)));
                              setState(() {
                                showSpinner = false;
                              });
                              if (reponse[0]) {
                                // Navigator.of(context).pushReplacement(
                                //   MaterialPageRoute(
                                //     builder: (context) => PayGateWebview(
                                //       url: reponse[1],
                                //       transactionId: reponse.length > 2
                                //           ? reponse[2]
                                //           : null,
                                //     ),
                                //   ),
                                // );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      reponse[1],
                                      textAlign: TextAlign.center,
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
                                  ),
                                );
                              }
                            } else {
                              noConnectionSnackbar(context: context);
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.green.withOpacity(0.8),
                          ),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 3.6, vertical: 7),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        child: Text(
                          "VALIDER",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
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
    );
  }
}
