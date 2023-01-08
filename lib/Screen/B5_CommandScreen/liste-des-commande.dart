import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:trevashop_v2/providers/transaction_provider.dart';

import '../../services/shared_preferences.dart';

class ListeDesCommnade extends StatefulWidget {
  const ListeDesCommnade({Key key}) : super(key: key);

  @override
  State<ListeDesCommnade> createState() => _ListeDesCommnadeState();
}

class _ListeDesCommnadeState extends State<ListeDesCommnade> {
  String token;
  var resultats;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getToken();
    });
  }

//Recuperer le token
  void getToken() {
    SharedPreferencesClass.restore('token').then((value) {
      setState(() {
        token = value;
        recupererData(value);
        // print(token);
      });
    });
  }

  //recuperer les datas
  void recupererData(token) {
    // TransactionProvider().commandeResteAPayer(token).then((value) {
    //   resultats = value['data'];
    //   print(resultats);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Liste de vos commandes"),
      ),
      body: resultats != null
          ? Text(resultats.toString())
          : Center(child: CircularProgressIndicator(color: Colors.red)),
    );
  }
}
