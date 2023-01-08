import 'dart:io';

import 'package:provider/provider.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:trevashop_v2/Library/carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:trevashop_v2/Library/countdown_timer/countDownTimer.dart';
import 'package:trevashop_v2/Model/HomeGridItemRecomended.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/B1_Home/CarouselProductInfo.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/AppBar_Component/AppbarGradient.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/AppBar_Component/ChatItem.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/AppBar_Component/commandChat.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/AppBar_Component/utils.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/Detai_Productl_Screen/CategoryDetail.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/Detai_Productl_Screen/DetailProduct.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/Detai_Productl_Screen/MenuDetail.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/Detai_Productl_Screen/PromotionDetail.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/HomeUIComponent/Flash_Sale/FlashSale.dart';
import 'package:trevashop_v2/Screen/B4_ProfileScreen/AcountUIComponent/Message.dart';
import 'package:trevashop_v2/Screen/ItemSelected.dart';
import 'package:trevashop_v2/constants/appAssets.dart';
import 'package:trevashop_v2/providers/image_actualite.dart';
import 'package:trevashop_v2/Screen/AjouterProduit.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../services/shared_preferences.dart';
import '../../webview.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

/// Component all widget in home
class _MenuState extends State<Menu> with TickerProviderStateMixin {
  /// Declare class GridItem from HomeGridItemReoomended.dart in folder ListItem
  GridItem gridItem;
var token;
  bool isStarted = false;
  var whatsappURl_android = "whatsapp://send?phone=" + whatsapp + "&text=hello";
  var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

  @override
  void initState() {
     SharedPreferencesClass.restore("token").then((onValue) {
      setState(() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          Provider.of<ImageActualite>(context, listen: false).setImageActualite(onValue);
          Provider.of<ImageActualite>(context, listen: false).setImagePromo(onValue);
        } catch (e) {}
      });
      });
    });
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double size = mediaQueryData.size.height;
    double sizeWidth = mediaQueryData.size.width;

    /// Navigation to MenuDetail.dart if user Click icon in category Menu like a example camera
    var onClickMenuIcon = () {
      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new menuDetail(),
          transitionDuration: Duration(milliseconds: 750),

          /// Set animation with opacity
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          }));
    };

    /// Navigation to promoDetail.dart if user Click icon in Week Promotion
    var onClickWeekPromotion = () {
      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new promoDetail(),
          transitionDuration: Duration(milliseconds: 750),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          }));
    };

    /// Navigation to categoryDetail.dart if user Click icon in Category
    var onClickCategory = () {
      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new categoryDetail(),
          transitionDuration: Duration(milliseconds: 750),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          }));
    };

    /// Declare device Size
    var deviceSize = MediaQuery.of(context).size;
    int _current = 0;
    final List<String> ImgList = [
      "https://media.istockphoto.com/photos/abstract-blue-digital-background-picture-id1146532466?k=20&m=1146532466&s=612x612&w=0&h=NjZrRzJH4nvxVmTGTvMrMrPGQ03fDNYTmRNoEiNSeCQ=",
      "https://image.shutterstock.com/image-photo/business-woman-drawing-global-structure-260nw-1006041130.jpg",
    ];

    List<Widget> imageSliders;
    if (Provider.of<ImageActualite>(context, listen: true).getImage == null ||
        Provider.of<ImageActualite>(context, listen: true).getImage.isEmpty) {
      setState(() {
        imageSliders = ImgList.map((item) => Container(
                child: GestureDetector(
              onTap: (() {
                Navigator.of(context).push(MaterialPageRoute(
                    settings: RouteSettings(arguments: item),
                    builder: (context) => CarouselProductInfo()));
              }),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ]),
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(item),
                                    fit: BoxFit.cover,
                                    repeat: ImageRepeat.noRepeat))),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))).toList();
      });
    } else {
      setState(() {
        imageSliders = Provider.of<ImageActualite>(context, listen: true)
            .getImage
            .map((item) => Container(
                    child: GestureDetector(
                  onTap: (() => {
                        Navigator.of(context).push(MaterialPageRoute(
                            settings: RouteSettings(arguments: item),
                            builder: (context) => CarouselProductInfo()))
                      }),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2))
                        ]),
                    margin: EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.cover,
                                        repeat: ImageRepeat.noRepeat))),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                )))
            .toList();
      });
    }

    /// ImageSlider in header
    var imageSlider = Padding(
        padding: EdgeInsets.all(10),
        child: CarouselSlider(
            options: CarouselOptions(
                height: 180,
                initialPage: 0,
                aspectRatio: 1.5,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: .9,
                enlargeStrategy: CenterPageEnlargeStrategy.height),
            items: imageSliders));

    // Store components
    const IconData shopping_cart =
        IconData(0xe59c, fontFamily: 'MaterialIcons');
    var ShopsComponent = Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 10.0),
        alignment: AlignmentDirectional.centerStart,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, top: 15.0, bottom: 3.0, right: 20.0),
                  child: Text(
                    "Shop",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w700),
                  )),
            ],
          ),
          SizedBox(height: size / 90),
          Center(
            child: Container(
              // decoration: BoxDecoration(
              //     border: Border.all(
              //         width: 1,  ),
              //     borderRadius: BorderRadius.circular(10)),
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i = 0; i < shop.length; i++)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShopWebview(
                                            brand: shop[i]['link'],
                                            WebsiteName: shop[i]['name'],
                                          )),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                  shop[i]['img'],
                                  height: size * 0.08,
                                  width: sizeWidth * 0.18,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 15)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AjouterProduit(
                              productUrl: "",
                              productName: "",
                              productDescription: "",
                              productQuantite: 1)));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(shopping_cart),
                          SizedBox(width: 15),
                          Text("Ajouter un produit")
                        ]))),
          )
        ]));

    /// CategoryIcon Component
    var categoryIcon = Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20.0),
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0),
            child: Text(
              'menu',
              style: TextStyle(
                  fontSize: 13.5,
                  fontFamily: "Sans",
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),

          /// Get class CategoryIconValue
          CategoryIconValue(
            tap1: onClickMenuIcon,
            icon1: "assets/icon/camera.png",
            title1: 'camera',
            tap2: onClickMenuIcon,
            icon2: "assets/icon/food.png",
            title2: 'food',
            tap3: onClickMenuIcon,
            icon3: "assets/icon/handphone.png",
            title3: 'handphone',
            tap4: onClickMenuIcon,
            icon4: "assets/icon/game.png",
            title4: 'gamming',
          ),
          Padding(padding: EdgeInsets.only(top: 23.0)),
          CategoryIconValue(
            icon1: "assets/icon/fashion.png",
            tap1: onClickMenuIcon,
            title1: 'fashion',
            icon2: "assets/icon/health.png",
            tap2: onClickMenuIcon,
            title2: 'healthCare',
            icon3: "assets/icon/pc.png",
            tap3: onClickMenuIcon,
            title3: 'computer',
            icon4: "assets/icon/mesin.png",
            tap4: onClickMenuIcon,
            title4: 'equipment',
          ),
          Padding(padding: EdgeInsets.only(top: 23.0)),
          CategoryIconValue(
            icon1: "assets/icon/otomotif.png",
            tap1: onClickMenuIcon,
            title1: 'otomotif',
            icon2: "assets/icon/sport.png",
            tap2: onClickMenuIcon,
            title2: 'sport',
            icon3: "assets/icon/ticket.png",
            tap3: onClickMenuIcon,
            title3: 'ticketCinema',
            icon4: "assets/icon/book.png",
            tap4: onClickMenuIcon,
            title4: 'books',
          ),
          Padding(padding: EdgeInsets.only(bottom: 30.0))
        ],
      ),
    );

    /// ListView a WeekPromotion Component
    var PromoHorizontalList = Container(
      color: Colors.white,
      height: 230.0,
      padding: EdgeInsets.only(bottom: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  left: 20.0, top: 15.0, bottom: 3.0, right: 20.0),
              child: Text(
                "Besoin d'aide?",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "Sans",
                    fontWeight: FontWeight.w700),
              )),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10.0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 20.0)),
                //contacter le client
                InkWell(
                    onTap: ((){
 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>chatItem() ));
                    }),
                    child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/callcenter.png",
                              width: 70,
                              height: 70,
                            ),
                            Text(
                              "Service client",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                                fontFamily: "Sans",
                              ),
                            )
                          ],
                        ))),
                Padding(padding: EdgeInsets.only(left: 10.0)),

                InkWell(
                    onTap: () {
                         showDialog(
                            context: context,
                            barrierDismissible: true, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Devis Personnels'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Text('Veuillez envoyez un lien de produit a notre service clientele',),
                                      //Text('deuxième ligne'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Container(
                                    width:double.infinity,
                                    child: ElevatedButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>chatItem() ));
                                    }, child: Text("C'est compris")),
                                  )
                                ],
                              );
                            },
                          );
                      
                    },
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icon/creditAcount.png",
                            width: 70,
                            height: 70,
                          ),
                          Text(
                            "Devis Personnels",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.6,
                              fontFamily: "Sans",
                            ),
                          )
                        ],
                      ),
                    )),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                InkWell(
                    onTap: 
                      () async => {
                          if (Platform.isIOS)
                            {
                              // for iOS phone only
                              if (await canLaunch(whatappURL_ios))
                                {
                                  await launch(whatappURL_ios,
                                      forceSafariVC: false)
                                }
                              else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: new Text(
                                              "Whatsapp indisponible")))
                                }
                            }
                          else
                            {
                              // android , web
                              if (await canLaunch(whatsappURl_android))
                                {await launch(whatsappURl_android)}
                              else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: new Text(
                                              "Whatsapp indisponible")))
                                }
                            }
                        
                    },
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icon/setting.png",
                            width: 70,
                            height: 70,
                          ),
                          Text(
                            "Ecrire sur whatsapp",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.6,
                              fontFamily: "Sans",
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );

    /// FlashSale component
    var FlashSell = Container(
      height: 350.0,
      decoration: BoxDecoration(
        /// To set Gradient in flashSale background
        gradient: LinearGradient(colors: [
          Color(0xFF7F7FD5).withOpacity(0.8),
          Color(0xFF86A8E7),
          Color(0xFF91EAE4)
        ]),
      ),

      /// To set FlashSale Scrolling horizontal
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: mediaQueryData.padding.left + 20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/img/flashsaleicon.png",
                    height: deviceSize.height * 0.087,
                  ),
                  Text(
                    'Nos propositions',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShopWebview(
                                            brand: "https://www.geeks-house.com/",
                                            WebsiteName: "Geek House",
                                          )),
                                );
                      }, child: Text("voir plus de produit")),
                  Padding(
                    padding: EdgeInsets.only(top: 2.0),
                  ),
                  /*  CountDownTimer(
                      secondsRemaining: 86400,
                      whenTimeExpires: () {
                        setState(() {
                          //hasTimerStopped = true;
                        });
                      },
                      countDownTimerStyle: TextStyle(
                        fontFamily: "Sans",
                        fontSize: 19.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )), */
                ],
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(left: 40.0)),
          Provider.of<ImageActualite>(context, listen: true).getPromos==null || Provider.of<ImageActualite>(context, listen: true).getPromos.isEmpty ? 
          Padding(padding: EdgeInsets.zero)
          :Column(children:[
             flashSaleItem(
            image: "assets/imgItem/mackbook.jpg",
            title: 'fTitle1',
            normalprice: "\$ 2,020",
            discountprice: "\$ 1,300",
            ratingvalue: "(56)",
            place: 'fPlace1',
            stock: 'fAvailable1',
            colorLine: 0xFFFFA500,
            widthLine: 50.0,
          ),
          Padding(padding: EdgeInsets.only(left: 10.0)),
          flashSaleItem(
            image: "assets/imgItem/flashsale2.jpg",
            title: 'fTitle2',
            normalprice: "\$ 14",
            discountprice: "\$ 10",
            ratingvalue: "(16)",
            place: 'fPlace2',
            stock: 'fAvailable2',
            colorLine: 0xFF52B640,
            widthLine: 100.0,
          ),
          Padding(padding: EdgeInsets.only(left: 10.0)),
          /*  flashSaleItem(
            image: "assets/imgItem/flashsale3.jpg",
            title: 'fTitle3',
            normalprice: "\$ 1,000",
            discountprice: "\$ 950",
            ratingvalue: "(20)",
            place: 'fPlace3',
            stock: 'fAvailable3',
            colorLine: 0xFF52B640,
            widthLine: 90.0,
          ), */
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  flashSaleItem(
                    image: "assets/imgItem/flashsale4.jpg",
                    title: 'fTitle4',
                    normalprice: "\$ 25",
                    discountprice: "\$ 20",
                    ratingvalue: "(22)",
                    place: 'fPlace4',
                    stock: 'fAvailable4',
                    colorLine: 0xFFFFA500,
                    widthLine: 30.0,
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  flashSaleItem(
                    image: "assets/imgItem/flashsale5.jpg",
                    title: 'fTitle5',
                    normalprice: "\$ 50",
                    discountprice: "\$ 30",
                    ratingvalue: "(10)",
                    place: 'fPlace5',
                    stock: 'fAvailable5',
                    colorLine: 0xFF52B640,
                    widthLine: 100.0,
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                ])

          /// Get a component flashSaleItem class
        ],
      ),
    );

    /// Category Component in bottom of flash sale
    var categoryImageBottom = Container(
      height: 310.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: Text(
              'category',
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Sans"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 15.0)),
                        CategoryItemValue(
                          image: "assets/imgItem/category2.png",
                          title: 'fashionMan',
                          tap: onClickCategory,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        CategoryItemValue(
                          image: "assets/imgItem/category1.png",
                          title: 'fashionGirl',
                          tap: onClickCategory,
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      CategoryItemValue(
                        image: "assets/imgItem/category3.png",
                        title: 'smartphone',
                        tap: onClickCategory,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      CategoryItemValue(
                        image: "assets/imgItem/category4.png",
                        title: 'computer',
                        tap: onClickCategory,
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      CategoryItemValue(
                        image: "assets/imgItem/category5.png",
                        title: 'sport',
                        tap: onClickCategory,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      CategoryItemValue(
                        image: "assets/imgItem/category6.png",
                        title: 'fashionKids',
                        tap: onClickCategory,
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      CategoryItemValue(
                        image: "assets/imgItem/category7.png",
                        title: 'health',
                        tap: onClickCategory,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      CategoryItemValue(
                        image: "assets/imgItem/category8.png",
                        title: 'makeup',
                        tap: onClickCategory,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    ///  Grid item in bottom of Category
    var Grid = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: Text(
                'Vos derniers status',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                ),
              ),
            ),

            /// To set GridView item
            GridView.count(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 17.0,
                childAspectRatio: 0.545,
                crossAxisCount: 2,
                primary: false,
                children: List.generate(
                  gridItemArray.length,
                  (index) => ItemGrid(gridItemArray[index]),
                ))
          ],
        ),
      ),
    );

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        /// Use Stack to costume a appbar
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: mediaQueryData.padding.top + 58.5)),

                  /// Call var imageSlider
                  imageSlider,

                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),

                  // Call Shop container
                  ShopsComponent,

                  /// Call var categoryIcon
                  // categoryIcon,
                  // Padding(
                  //   padding: EdgeInsets.only(top: 10.0),
                  // ),

                  /// Call var PromoHorizontalList
                  PromoHorizontalList,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, top: 15.0, bottom: 3.0, right: 20.0),
                          child: Text(
                            "Nos choix pour vous",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Sans",
                                fontWeight: FontWeight.w700),
                          )),
                    ],
                  ),
                  FlashSell,
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  // categoryImageBottom,
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: 10.0),
                  // ),

                  /// Call a Grid variable, this is item list in Recomended item
                  Grid,
                ],
              ),
            ),

            /// Get a class AppbarGradient
            /// This is a Appbar in home activity
            AppbarGradient(),
          ],
        ),
      ),
    );
  }
}

/// ItemGrid in bottom item "Recomended" item
class ItemGrid extends StatelessWidget {
  /// Get data from HomeGridItem.....dart class
  GridItem gridItem;
  ItemGrid(this.gridItem);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new detailProduk(gridItem),
            transitionDuration: Duration(milliseconds: 900),

            /// Set animation Opacity in route to detailProduk layout
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 4.0,
                spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /// Set Animation image to detailProduk layout
                Hero(
                  tag: "hero-grid-${gridItem.id}",
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return new Material(
                                color: Colors.black54,
                                child: Container(
                                  padding: EdgeInsets.all(30.0),
                                  child: InkWell(
                                    child: Hero(
                                        tag: "hero-grid-${gridItem.id}",
                                        child: Image.asset(
                                          gridItem.img,
                                          width: 300.0,
                                          height: 300.0,
                                          alignment: Alignment.center,
                                          fit: BoxFit.contain,
                                        )),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                            transitionDuration: Duration(milliseconds: 500)));
                      },
                      child: Container(
                        height: mediaQueryData.size.height / 3.3,
                        width: 200.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                topRight: Radius.circular(7.0)),
                            image: DecorationImage(
                                image: AssetImage(gridItem.img),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 7.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    gridItem.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black54,
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    gridItem.price,
                    style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            gridItem.rattingValue,
                            style: TextStyle(
                                fontFamily: "Sans",
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14.0,
                          )
                        ],
                      ),
                      Text(
                        gridItem.itemSale,
                        style: TextStyle(
                            fontFamily: "Sans",
                            color: Colors.black26,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Component FlashSaleItem
class flashSaleItem extends StatelessWidget {
  final String image;
  final String title;
  final String normalprice;
  final String discountprice;
  final String ratingvalue;
  final String place;
  final String stock;
  final int colorLine;
  final double widthLine;

  flashSaleItem(
      {this.image,
      this.title,
      this.normalprice,
      this.discountprice,
      this.ratingvalue,
      this.place,
      this.stock,
      this.colorLine,
      this.widthLine});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new flashSale(),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 850)));
              },
              child: Container(
                height: 310.0,
                width: 145.0,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 140.0,
                      width: 145.0,
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
                      child: Text(title,
                          style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Sans")),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
                      child: Text(normalprice,
                          style: TextStyle(
                              fontSize: 10.5,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Sans")),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
                      child: Text(discountprice,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFF7F7FD5),
                              fontWeight: FontWeight.w800,
                              fontFamily: "Sans")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 5.0, right: 10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 11.0,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            size: 11.0,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            size: 11.0,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            size: 11.0,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star_half,
                            size: 11.0,
                            color: Colors.yellow,
                          ),
                          Text(
                            ratingvalue,
                            style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Sans",
                                color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 5.0, right: 10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 11.0,
                            color: Colors.black38,
                          ),
                          Text(
                            place,
                            style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Sans",
                                color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0),
                      child: Text(
                        stock,
                        style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Sans",
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 4.0, left: 10.0, right: 10.0),
                      child: Container(
                        height: 5.0,
                        width: widthLine,
                        decoration: BoxDecoration(
                            color: Color(colorLine),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            shape: BoxShape.rectangle),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

/// Component category item bellow FlashSale
class CategoryItemValue extends StatelessWidget {
  String image, title;
  GestureTapCallback tap;

  CategoryItemValue({
    this.image,
    this.title,
    this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        height: 105.0,
        width: 160.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            color: Colors.black.withOpacity(0.25),
          ),
          child: Center(
              child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Berlin",
              fontSize: 18.5,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w800,
            ),
          )),
        ),
      ),
    );
  }
}

/// Component item Menu icon bellow a ImageSlider
class CategoryIconValue extends StatelessWidget {
  String icon1, icon2, icon3, icon4, title1, title2, title3, title4;
  GestureTapCallback tap1, tap2, tap3, tap4;

  CategoryIconValue(
      {this.icon1,
      this.tap1,
      this.icon2,
      this.tap2,
      this.icon3,
      this.tap3,
      this.icon4,
      this.tap4,
      this.title1,
      this.title2,
      this.title3,
      this.title4});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: tap1,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon1,
                height: 19.2,
              ),
              Padding(padding: EdgeInsets.only(top: 7.0)),
              Text(
                title1,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap2,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon2,
                height: 26.2,
              ),
              Padding(padding: EdgeInsets.only(top: 0.0)),
              Text(
                title2,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap3,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon3,
                height: 22.2,
              ),
              Padding(padding: EdgeInsets.only(top: 4.0)),
              Text(
                title3,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: tap4,
          child: Column(
            children: <Widget>[
              Image.asset(
                icon4,
                height: 19.2,
              ),
              Padding(padding: EdgeInsets.only(top: 7.0)),
              Text(
                title4,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  /// Declare class GridItem from HomeGridItemReoomended.dart in folder ListItem
  GridItem gridItem;
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  bool isStarted = false;
  var whatsappURl_android = "whatsapp://send?phone=" + whatsapp + "&text=hello";
  var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

// ignore: prefer_collection_literals
  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();
  @override
  Widget build(BuildContext context) {
    int _current = 0;
  final  List<String> ImgList = [
      "assets/images/tab1.png",
      "assets/images/tab2.png",
      "assets/images/tab3.png"
    ];
    final List<Widget> imageSliders = ImgList
    .map((item) => Container(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("E-SUGU"),
        actions: [
          IconButton(
            onPressed: (){}, 
          icon: Icon(
             Icons.whatsapp_outlined,
           ),
          ),
          IconButton(
            onPressed: (){}, 
          icon: Icon(
             Icons.notifications
           ),
          )
           
        ],
      ),
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          
          Padding(
              padding: EdgeInsets.all(10),
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 180,
                    initialPage: 0,
                    aspectRatio: 1.5,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: .9,
                    enlargeStrategy: CenterPageEnlargeStrategy.height
                    ),
                    items: imageSliders
              ))
        ],
      ),
    )));
  }
}*/
