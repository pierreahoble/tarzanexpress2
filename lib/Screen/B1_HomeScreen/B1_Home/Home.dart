import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/B1_Home/B1_Home_Screen.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/AppBar_Component/model/product.dart';
import 'package:trevashop_v2/providers/commande_provider.dart';
import '../../B5_CommandScreen/B5_CommandScreen.dart';

import '../../B3_CartScreen/B3_Cart/B3_Cart_Screen.dart';
import '../../B4_ProfileScreen/B4_Profile/B4_Profile_Screen.dart';
import 'package:badges/badges.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final tabs = [
    Menu(),
    Cart(),
    Commande(),
    Profil(),
  ];
  List<Product> products;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
              Provider.of<CommandeProvider>(context, listen: false)
              .getProducts()
              .then((value) {
            setState(() {
              products = value;
            });
          });
        } catch (e) {}
      });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var CommandProv = Provider.of<CommandeProvider>(context,listen: true);
    
    return SafeArea(
      child: Scaffold(
        body: tabs.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon:CommandProv.getBadge == 0?Icon(Icons.shopping_cart):Badge(
                badgeContent: Text(""+CommandProv.getBadge.toString(),style:TextStyle(color:Colors.white)),
                child: Icon(Icons.shopping_cart),
              ),
              label: 'Panier',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Commandes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
