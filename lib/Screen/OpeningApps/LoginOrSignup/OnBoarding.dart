import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trevashop_v2/Library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:trevashop_v2/Library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';
import 'package:trevashop_v2/Screen/OpeningApps/LoginOrSignup/ChoseLoginOrSignup.dart';

class onBoarding extends StatefulWidget {
  @override
  _onBoardingState createState() => _onBoardingState();
}

var _fontHeaderStyle = TextStyle(
    fontFamily: "Popins",
    fontSize: 21.0,
    fontWeight: FontWeight.w800,
    color: Colors.orange.shade900,
    letterSpacing: 1.5);

var _fontDescriptionStyle = TextStyle(
    fontFamily: "Sans",
    fontSize: 15.0,
    color: Colors.black26,
    fontWeight: FontWeight.w400);

///
/// Page View Model for on boarding
///
final pages = [
  new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.orange,
      title: Text(
        'TARZAN EXPRESS',
        style: _fontHeaderStyle,
      ),
      body: Container(
        height:
            10, /*        child: Text(
            'E commerce application template \nbuy this code template in codecanyon',
            textAlign: TextAlign.center,
            style: _fontDescriptionStyle),*/
      ),
      mainImage: Image.asset('assets/imgOnboard/intro0.png',
          height: 285.0, width: 285.0, fit: BoxFit.cover)),
  new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.orange,
      title: Text(
        'Suivi et Livraison',
        style: _fontHeaderStyle,
      ),
      body: Container(
        height: 10,
        /*
        child: Text(
            'Choose Items wherever you are with this application to make life easier',
            textAlign: TextAlign.center,
            style: _fontDescriptionStyle),*/
      ),
      mainImage: Image.asset('assets/imgOnboard/intro1.png',
          height: 285.0, width: 285.0, fit: BoxFit.cover)),
  new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.orange,
      title: Text(
        'Discussion instantane',
        style: _fontHeaderStyle,
      ),
      body: Container(
        height: 10,
        /*
        child: Text(
            'Shop from thousand brands in the world \n in one application at throwaway \nprices ',
            textAlign: TextAlign.center,
            style: _fontDescriptionStyle),*/
      ),
      mainImage: Image.asset('assets/imgOnboard/intro2.png',
          height: 400.0, width: 400.0, fit: BoxFit.cover)),
];

class _onBoardingState extends State<onBoarding> {
  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      pageButtonsColor: Colors.black45,
      skipText: Text(
        "SKIP",
        style: _fontDescriptionStyle.copyWith(
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      doneText: Text(
        "DONE",
        style: _fontDescriptionStyle.copyWith(
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      onTapDoneButton: () async {
        SharedPreferences prefs;
        prefs = await SharedPreferences.getInstance();
        prefs.setString("username", "Login");
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new ChoseLogin(),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget widget) {
            return Opacity(
              opacity: animation.value,
              child: widget,
            );
          },
          transitionDuration: Duration(milliseconds: 1500),
        ));
      },
    );
  }
}
