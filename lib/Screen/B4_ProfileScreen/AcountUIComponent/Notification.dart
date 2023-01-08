import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trevashop_v2/providers/notification_provider.dart';
import 'package:trevashop_v2/services/shared_preferences.dart';
import '../../../helper/dataConnectionChecker.dart';
//import '../../../model/notification.dart';
// import '../../../page/inApp/commandes/orderDetails.dart';
// import '../../../page/inApp/messages/orderConversation.dart';
import '../../../state/notificationState.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var token;

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferencesClass.restore("token").then((onValue) {
      setState(() {
        token = onValue;
      });
      print(token);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          Provider.of<NotificationProvider>(context, listen: false)
              .setNotifications(token);
        } catch (e) {}
      });
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    //final List items = ['2', '27'];

    //var a = Provider.of<NotificationState>(context);
    var showMore = ValueNotifier(10);
    var notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF020D1F),
          title: Text("Vos notifications".toUpperCase()),
          centerTitle: true,
        ),
        body: notificationProvider.getNotifications == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : notificationProvider.getNotifications.length == 0
                ? Center(
                    child: Image.asset(
                      "assets/imgIllustration/IlustrasiMessage.png",
                      height: 220.0,
                    ),
                  )
                : ListView.builder(
                    itemCount: notificationProvider.getNotifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = notificationProvider.getNotifications[index];
                      return Dismissible(
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            color: Colors.blue,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            // Remove the item from the data source.
                            var item =
                                notificationProvider.getNotifications[index];
                            notificationProvider.deleteNotification(index);

                            // Then show a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Notification supprimée'),
                              action: SnackBarAction(
                                  label: 'Annuler',
                                  onPressed: () {
                                    notificationProvider.insertNotification(
                                        index, item);
                                  }),
                            ));
                          },
                          child: GestureDetector(
                              onTap: () {
                                print(item['id']);
                              },
                              child: Card(
                                  elevation: 10,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: ElevatedButton(
                                            onPressed: null,
                                            child: Icon(Icons.notifications),
                                            style: ElevatedButton.styleFrom(
                                              shape: CircleBorder(),
                                            ),
                                          ),
                                          title: Text(item['type']),
                                          subtitle:
                                              // Row(
                                              //   children: [
                                              //     Container(
                                              //       width: 3 *
                                              //           MediaQuery.of(context).size.width /
                                              //           5,
                                              //       child:
                                              Text(
                                                  "Commande receptionnée avec succès"),
                                          //     )
                                          //   ],
                                          // ),
                                        )
                                      ],
                                    ),
                                  ))));
                    })
        // body: FutureBuilder(
        //     future: DataConnectionChecker().hasConnection,
        //     builder: (context, snapshot) {
        //       if ((snapshot.connectionState == ConnectionState.done) &&
        //           snapshot.data) {
        //         return FutureBuilder(
        //           // future: a.getNotifications(context: context),
        //           builder: (context, snap) {
        //             if (snap.connectionState == ConnectionState.done) {
        //               return Text("BONJOUR");
        //               // if (a.notifications == null) {
        //               // return Center(
        //               //   child: Padding(
        //               //     padding: const EdgeInsets.all(10.0),
        //               //     child: Column(
        //               //       mainAxisAlignment: MainAxisAlignment.center,
        //               //       children: [
        //               //         Icon(Icons.link_off),
        //               //         Text(
        //               //           "Une erreur s'est produite. Notre équipe est en train de résoudre le problème.Veuillez réessayer plutard.",
        //               //           textAlign: TextAlign.center,
        //               //           style: TextStyle(fontSize: 20),
        //               //         ),
        //               //       ],
        //               //     ),
        //               //   ),
        //               // );
        //               // } else {
        //               // if (a.notifications.length != 0) {
        //               //   return SingleChildScrollView(
        //               //     child: Column(
        //               //       crossAxisAlignment: CrossAxisAlignment.center,
        //               //       children: [
        //               //         ValueListenableBuilder(
        //               //           valueListenable: showMore,
        //               //           builder: (context, n, _) {
        //               //             List<NotificationModel> uNotifs =
        //               //                 a.notifications.sublist(
        //               //                     0,
        //               //                     (a.notifications.length - n > 0)
        //               //                         ? n
        //               //                         : a.notifications.length);
        //               //             return Column(
        //               //               children: [
        //               //                 for (var i = 0; i < uNotifs.length; i++)
        //               //                   Card(
        //               //                     elevation: 3,
        //               //                     margin: EdgeInsets.symmetric(
        //               //                         horizontal: 10.0, vertical: 3.5),
        //               //                     color: uNotifs[i]
        //               //                                 .etatLecture
        //               //                                 .toString() ==
        //               //                             "0"
        //               //                         ? Colors.grey.shade200
        //               //                         : Colors.white,
        //               //                     child: ListTile(
        //               //                       onTap: () async {
        //               //                         await Provider.of<
        //               //                                     NotificationState>(
        //               //                                 context,
        //               //                                 listen: false)
        //               //                             .notificationIsRead(
        //               //                                 context: context,
        //               //                                 notificationId: a
        //               //                                     .notifications[i].id);
        //               //                         Navigator.push(
        //               //                           context,
        //               //                           MaterialPageRoute(
        //               //                             builder: (context) => (a
        //               //                                         .notifications[i]
        //               //                                         .type ==
        //               //                                     "ETAT_COMMANDE")
        //               //                                 ? OrderDetails(
        //               //                                     id: a.notifications[i]
        //               //                                         .commandeId)
        //               //                                 : OrderConversation(
        //               //                                     id: a.notifications[i]
        //               //                                         .commandeId,
        //               //                                     reference: a
        //               //                                         .notifications[i]
        //               //                                         .commande[
        //               //                                             "reference"]
        //               //                                         .toString()),
        //               //                           ),
        //               //                         );
        //               //                       },
        //               //                       leading: uNotifs[i]
        //               //                                   .etatLecture
        //               //                                   .toString() ==
        //               //                               "0"
        //               //                           ? Container(
        //               //                               decoration: BoxDecoration(
        //               //                                 color:
        //               //                                     Colors.red.shade400,
        //               //                                 shape: BoxShape.circle,
        //               //                               ),
        //               //                               height: 10,
        //               //                               width: 10,
        //               //                             )
        //               //                           : Container(
        //               //                               decoration: BoxDecoration(
        //               //                                 color:
        //               //                                     Colors.grey.shade400,
        //               //                                 shape: BoxShape.circle,
        //               //                               ),
        //               //                               height: 10,
        //               //                               width: 10,
        //               //                             ),
        //               //                       title: Text(
        //               //                         (uNotifs[i].type ==
        //               //                                 "ETAT_COMMANDE")
        //               //                             ? "La commande ${uNotifs[i].commande["reference"]} est passée à l'état \"${uNotifs[i].commandeStatut["param1"]}\""
        //               //                             : ("Nouveau message à propos de la commande ${uNotifs[i].commande["reference"].toString()}"),
        //               //                         style: TextStyle(fontSize: 13.0),
        //               //                       ),
        //               //                       subtitle: Text(uNotifs[i].date),
        //               //                     ),
        //               //                   ),
        //               //                 if ((uNotifs.length > 10) &&
        //               //                     (a.notifications.length - n > 0))
        //               //                   Center(
        //               //                     child: ElevatedButton(
        //               //                       onPressed: () {
        //               //                         showMore.value += 10;
        //               //                       },
        //               //                       child: Text("Montrer plus"),
        //               //                     ),
        //               //                   ),
        //               //               ],
        //               //             );
        //               //           },
        //               //         ),
        //               //       ],
        //               //     ),
        //               //   );
        //               // } else {
        //               return Padding(
        //                 padding: const EdgeInsets.symmetric(vertical: 20),
        //                 child: Center(
        //                   child: Text(
        //                     "AUCUNE INFO DISPONIBLE ",
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                       fontWeight: FontWeight.w500,
        //                       //color: AppColors.scaffoldBackground,
        //                       fontSize: 16,
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             }
        //             // }
        //             // }
        //             return Center(
        //               child: Container(
        //                 padding: EdgeInsets.all(10),
        //                 color: Colors.white,
        //                 child: Row(
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     CircularProgressIndicator(),
        //                     SizedBox(width: 10),
        //                     Text("Récupération des données ..")
        //                   ],
        //                 ),
        //               ),
        //             );
        //           },
        //         );
        //       }
        //       return Center(
        //         child: Container(
        //           padding: EdgeInsets.all(10),
        //           color: Colors.white,
        //           child: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               CircularProgressIndicator(),
        //               SizedBox(width: 10),
        //               Text("Récupération des données..")
        //             ],
        //           ),
        //         ),
        //       );
        //     }),
        );
  }
}
