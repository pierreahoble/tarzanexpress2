import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/B1_Home/B1_Home_Screen.dart';
import 'package:trevashop_v2/Screen/B2_BrandScreen/BrandUIComponent/BrandLayout.dart';
import 'package:trevashop_v2/Screen/B3_CartScreen/B3_Cart/B3_Cart_Screen.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/B4_Profile/B4_Profile_Screen.dart';

class bottomNavigationBar extends StatefulWidget {
  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int currentIndex = 0;

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new Menu();
      case 1:
        return new brand();
      case 2:
        return new Cart();
      case 3:
        return new Profil();
        break;
      default:
        return Menu();
    }
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: callPage(currentIndex),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: TextStyle(color: Colors.black12))),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              fixedColor: Color(0xFF6991C7),
              unselectedItemColor: Colors.black12,
              onTap: (value) {
                currentIndex = value;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 23.0,
                    ),
                    label: AppLocalizations.of(context).tr('home')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shop),
                    label: AppLocalizations.of(context).tr('brand')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: AppLocalizations.of(context).tr('cart')),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      size: 24.0,
                    ),
                    label: AppLocalizations.of(context).tr('account')),
              ],
            )),
      ),
    );
  }
}
