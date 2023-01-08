import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trevashop_v2/Screen/B3_CartScreen/B3_Cart/B3_Cart_Screen.dart';
import '../Model/product.dart';
import '../constants/appColors.dart';
import '../state/panierState.dart';

class ItemSelected extends StatefulWidget {
  final String productUrl;

  final String productName;

  final String productDescription;

  final int productQuantite;

  ItemSelected(
      {key,
      @required this.productUrl,
      @required this.productName,
      @required this.productDescription,
      @required this.productQuantite})
      : super(key: key);

  @override
  State<ItemSelected> createState() => _ItemSelectedState();
}

class _ItemSelectedState extends State<ItemSelected> {
  final _formKey = GlobalKey<FormState>();
  String produitNom;
  String produitDescription;
  String produitQuantite;
  File image;
  ImagePicker imagePicker = ImagePicker();

  handleChooseFromGallery() async {
    File tempFile =
        File((await imagePicker.getImage(source: ImageSource.gallery)).path);
    if (tempFile != null) {
      setState(() {
        image = tempFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("Modification des informations"),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///
                      ///NOM DU PRODUIT
                      ///
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nom",
                                    style: TextStyle(
                                        color: Colors.indigo, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.name,
                                    maxLines: 1,
                                    textInputAction: TextInputAction.next,
                                    initialValue: widget.productName,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(
                                            color: Colors.blueGrey, width: 0.3),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Veuillez entrer le nom";
                                      }
                                      if (val.length < 3) {
                                        return "Entrez un nom valide";
                                      }
                                      return null;
                                    },
                                    onSaved: (val) {
                                      produitNom = val;
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      ///
                      ///DESCRIPTION
                      ///

                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Carctéristiques",
                              style:
                                  TextStyle(color: Colors.indigo, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              maxLines: 5,
                              initialValue: widget.productDescription,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText:
                                    "Précisez les caractéristiques exactes !!\n(Couleur, Taille, Modèle...)",
                                hintStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 10, 10, 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey, width: 0.3),
                                ),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "N'oubliez pas la description";
                                }
                                if (val.length < 4) {
                                  return "Entrez au moins quatre lettres";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                produitDescription = val;
                              },
                            ),
                          ],
                        ),
                      ),

                      ///
                      ///QUANTITE
                      ///
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Quantité",
                              style:
                                  TextStyle(color: Colors.indigo, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              initialValue:widget.productQuantite.toString(),
                              decoration: InputDecoration(
                                hintText: "Quantité",
                                hintStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 10, 10, 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey, width: 0.3),
                                ),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Veuillez entrer la quantité";
                                }
                                if (val.contains('-') ||
                                    val.contains(',') ||
                                    val.contains(' ') ||
                                    val.contains('.')) {
                                  return "Entrez un nombre sans espaces ni <, . ->";
                                }
                                if (int.parse(val) == 0) {
                                  return "La quantité ne doit pas être nulle.";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                produitQuantite = val;
                              },
                            ),
                          ],
                        ),
                      ),

                      ///
                      ///IMAGE
                      ///
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Image",
                              style: TextStyle(color: Colors.indigo),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                           
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                handleChooseFromGallery();
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.imageUploadBackground
                                          .withOpacity(0.2),
                                      border: Border.all(
                                          color: AppColors
                                              .imageUploadBackgroundBorder),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child:image != null
                                          ? Image.file(
                                              image,
                                              fit: BoxFit.cover,
                                            )
                                          : Center(
                                              child: Icon(Icons.arrow_circle_up),
                                            ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Flexible(
                                    child: image != null
                                        ? Text("Image ajoutée")
                                        : Text("Ajouter une image du produit"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              if (id != null) {
                                await Provider.of<PanierState>(context,
                                        listen: false)
                                    .modifyContentPanierElement(
                                  index: id,
                                  nom: produitNom,
                                  description: produitDescription,
                                  quantite: int.parse(produitQuantite),
                                  image: (image != null)
                                      ? base64Encode(image.readAsBytesSync())
                                      : null,
                                );

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Cart()),
                                    (route) => false);
                              } else {
                                await Provider.of<PanierState>(context,
                                        listen: false)
                                    .contentPanierAdd(
                                  Product(
                                    nom: produitNom,
                                    lien: widget.productUrl,
                                    description: produitDescription,
                                    quantite: int.parse(produitQuantite),
                                    prix: 630,
                                    images: (image != null)
                                        ? base64Encode(image.readAsBytesSync())
                                        : null,
                                  ),
                                )
                                    .then((value) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.lightBlue,
                                      content: Text(
                                        "Article modifié",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.fromLTRB(15, 0, 15, 25),
                                    ),
                                  );
                                });
                              }
                            }
                           
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "Modifier le produit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
