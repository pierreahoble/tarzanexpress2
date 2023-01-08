import 'dart:convert';

import 'package:trevashop_v2/Screen/B3_CartScreen/B3_Cart/finalisation_comand.dart';
import 'package:trevashop_v2/services/notificationService.dart';

import 'Screen/B3_CartScreen/B3_Cart/B3_Cart_Screen.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/B1_Home/Home.dart';
import 'package:trevashop_v2/Screen/B3_CartScreen/B3_Cart/livraison.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/Notification.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/Login.dart';
import 'package:trevashop_v2/providers/commandExecution_provider.dart';
import 'package:trevashop_v2/providers/authentification_provider.dart';
import 'package:trevashop_v2/providers/commande_provider.dart';
import 'package:trevashop_v2/providers/image_actualite.dart';
import 'package:trevashop_v2/providers/messageCommande_provider.dart';

import 'package:trevashop_v2/providers/signIn.dart';
import 'package:trevashop_v2/services/pusher_service.dart';
import 'package:trevashop_v2/state/panierState.dart';

import 'Library/Language_Library/lib/easy_localization_provider.dart';
import 'Screen/OpeningApps/LoginOrSignup/ChoseLoginOrSignup.dart';
import 'Screen/OpeningApps/OnBoarding/OnBoarding.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

import 'services/shared_preferences.dart';
import 'state/authState.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'providers/notification_provider.dart';

/// Run first apps open
///
final navKey = GlobalKey<NavigatorState>();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp();

  runApp(EasyLocalization(child: myApp()));
}

/// Set orienttation
///

class myApp extends StatefulWidget {
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  String presentation;
  PusherService pusher_services = new PusherService();

  void initState() {
    tz.initializeTimeZones();
    super.initState();
    instancePusher();
    SharedPreferencesClass.restore("token").then((onValue) {
      if (onValue != null && onValue != false) {
        setState(() {
          presentation = onValue;
        });
      }
    // NotificationService().showNotification(1, "title"," body", 5);
    });
  }

  void instancePusher() {
    pusher_services.initPusher();
    pusher_services.connectPusher();
    pusher_services.subscribePusher("esugu-app").then((channel) {
      channel.bind("esugu-push", (last) {
        var data = jsonDecode(last.data);
        print(data["contenu"]);
        if (data["event-source"] == "MESSAGERIE") {
          MessageCommandsProvider()
              .addMessages(0, {'contenu': data["contenu"], 'is-admin': 1});
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   try {
          //     Provider.of<MessageCommandsProvider>(context, listen: true)
          //         .addMessages(0, {'contenu': data["contenu"], 'is-admin': 1});
          //     print("contenu" +
          //         Provider.of<MessageCommandsProvider>(context, listen: true)
          //             .getMessages[0]['contenu']);
          //   } catch (e) {
          //     print("toto :" + e.toString());
          //   }
          // });
        } else if (data["event-source"] == "MESSAGERIE_CLIENT") {
          MessageCommandsProvider().addClientMessages(
              0, {'contenu': data["contenu"], 'is-admin': 1});
        }
        //_inEventData.add(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));

    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
        ChangeNotifierProvider<SignIn>(create: (context) => SignIn()),
        ChangeNotifierProvider<PanierState>(create: (context) => PanierState()),
        ChangeNotifierProvider<CommandExecution>(
            create: (context) => CommandExecution()),
        ChangeNotifierProvider<AuthentificationProvider>(
            create: (context) => AuthentificationProvider()),
        ChangeNotifierProvider<CommandeProvider>(
            create: (context) => CommandeProvider()),
        ChangeNotifierProvider<ImageActualite>(
            create: (context) => ImageActualite()),
        ChangeNotifierProvider<MessageCommandsProvider>(
            create: (context) => MessageCommandsProvider()),
        ChangeNotifierProvider<NotificationProvider>(
            create: ((context) => NotificationProvider()))
      ],
      child: new MaterialApp(
        title: "e-SUGU",
        theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Color.fromARGB(255, 228, 120, 120),
          primaryColorLight: Colors.white,
          // ignore: deprecated_member_use
          primaryColorBrightness: Brightness.light,
          primaryColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: presentation == null ? SplashScreen() : Home(),
        routes: {
          /*  screens.PhoneVerification.routeName: (context) =>screens.PhoneVerification(),
              screens.Registration.routeName: (context) => screens.Registration(),
              screens.Login.routeName: (context) => screens.Login(),
              screens.MonCompte.routeName: (context) => screens.MonCompte(),
              screens.Home.routeName: (context) => screens.Home(),
              screens.Profile.routeName: (context) => screens.Profile(),
              screens.UpdateProfile.routeName: (context) =>screens.UpdateProfile(),
              screens.Settings.routeName: (context) => screens.Settings(),
              screens.Transaction.routeName: (context) => screens.Transaction(),
              screens.Abonnement.routeName: (context) => screens.Abonnement(),
              screens.Service.routeName: (context) => screens.Service(),
              screens.Reclamer.routeName: (context) => screens.Reclamer(),
              screens.Recharger.routeName: (context) => screens.Recharger(),
              screens.Retrait.routeName: (context) => screens.Retrait(),
              screens.Envoie.routeName: (context) => screens.Envoie(),
              screens.Consulter.routeName: (context) => screens.Consulter(),
              screens.AccessibilityPage.routeName: (context) =>screens.AccessibilityPage(), */
        },
      ),
    );

    /// To set orientation always portrait
  }
}

/// Component UI
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {
  /// Check user
  bool _checkUser = false;

  SharedPreferences prefs;

  Future<Null> _function() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    this.setState(() {
      if (prefs.getString("username") != null) {
        print('false');
        _checkUser = false;
      } else {
        print('true');
        _checkUser = true;
      }
    });
  }

  /// Setting duration in splash screen
  startTime() async {
    return new Timer(Duration(milliseconds: 5000), NavigatorPage);
  }

  /// To navigate layout change
  void NavigatorPage() {
    if (!_checkUser) {
      /// if userhas never been login
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(pageBuilder: (_, __, ___) => onBoarding()));
    } else {
      /// if userhas ever been login
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(pageBuilder: (_, __, ___) => ChoseLogin()));
    }
  }

  /// Declare startTime to InitState
  @override
  void initState() {
    super.initState();
    startTime();
    _function();
  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: MediaQuery.of(context).size.height,
            color: Color.fromARGB(255, 48, 47, 47),
            child: Center(
              child: Image.asset(
                "assets/logo1.png",
                height: 150,
                width: MediaQuery.of(context).size.width / 2,
              ),
            )),
      ),
    );
  }
}
