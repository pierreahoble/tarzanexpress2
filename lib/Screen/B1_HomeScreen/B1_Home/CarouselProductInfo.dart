import 'package:flutter/material.dart';
import 'package:trevashop_v2/Screen/B1_HomeScreen/B1_Home/Home.dart';

class CarouselProductInfo extends StatefulWidget {
  const CarouselProductInfo({Key key}) : super(key: key);

  @override
  State<CarouselProductInfo> createState() => _CarouselProductInfoState();
}

class _CarouselProductInfoState extends State<CarouselProductInfo> {
  
  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2 +
                        MediaQuery.of(context).size.height / 8,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(item),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 0, 0, .2),
                              Color.fromRGBO(0, 0, 0, 5)
                            ],
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                              top: 30,
                              left: 15,
                              right: 15,
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
                                    },
                                    child: Icon(Icons.arrow_back),
                                    style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                        primary: Colors.white,
                                        onPrimary: Colors.black),
                                  )
                                ],
                              ))
                        ],
                      ),
                    )),
                Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height / 2 +
                              MediaQuery.of(context).size.height / 8),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: Stack(
                          children: [
                            Positioned(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product",
                                    style: TextStyle(
                                        letterSpacing: 0.2,
                                        fontFamily: "Sans",
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s . been the industry's standard dummy text ever since the 1500s",
                                    style: TextStyle(
                                        letterSpacing: 0.2,
                                        fontFamily: "Sans",
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: 10,
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: Text("Commander")),
                                  ],
                                )),
                            Positioned(
                                bottom: 10,
                                right: 0,
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                        ),
                                        onPressed: () {},
                                        child: Text("Voir plus")),
                                  ],
                                ))
                          ],
                        )))
              ],
            ))));
  }
}
