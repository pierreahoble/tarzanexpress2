import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:trevashop_v2/Screen/webviewOptions.dart';
import '../../../constants/appColors.dart';
import '../../../constants/appNames.dart';

import '../../../Model/product.dart';

import '../../../state/panierState.dart';
import '../../../widgets/customWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ItemSelected.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class ShopWebview extends StatefulWidget {
  final String brand;
  final String WebsiteName;
  ShopWebview({@required this.brand, @required this.WebsiteName});
  @override
  _ShopWebviewState createState() => _ShopWebviewState();
}

class _ShopWebviewState extends State<ShopWebview> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );
  PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();
  bool errorOccured = false;
  bool webviewCreated = false;
  bool showSpinner = false;
  File image;
  String productUrl = "";
  String productName = "";
  String productDescription = "";
  String productQuantite = "";
  bool isProductPage = false;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool showAddButton = false;

  getProductDetails() async {
    setState(() {
      showSpinner = true;
    });
    if (widget.brand == AppNames.amazonFr || widget.brand == AppNames.sheinFr) {
      try {
        var resp = await webViewController.evaluateJavascript(
            source: widget.brand == AppNames.amazonFr
                ? "document.querySelectorAll('#productTitleGroupAnchor').length;"
                : "document.querySelectorAll('#detail-view').length;");
        isProductPage = ("$resp" == "1");
      } catch (e) {
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.black,
            content: Text(
              "Nous avons rencontré un problème, veuillez ressayer svp!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
          ),
        );
      }
    } else {
      isProductPage = true;
    }

    if (isProductPage) {
      try {
        productUrl = (await webViewController.getUrl()).toString();
        productName = await webViewController.getTitle();
      } catch (e) {
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.black,
            content: Text(
              "Nous avons rencontré un problème, veuillez ressayer svp!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
          ),
        );
      }
      setState(() {
        showSpinner = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebviewOptions(
                  productDescription: "productDescription",
                  productName: productName,
                  productQuantite: 1,
                  productUrl: productUrl,
                )),
      );
      //print("L'URL EST $productUrl\n LE NOM EST $productName");
      /* showDialog(
        context: context,
        builder: (context) {
          return AddToCartDialog(
            productName: productName,
            productDescription: productDescription,
            productUrl: productUrl,
          );
        },
      );*/
    } else {
      setState(() {
        showSpinner = false;
      });
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            "Oups",
            style: TextStyle(color: AppColors.green),
          ),
          content: Text(
            "veuillez vous diriger vers la page d'un seul article",
            style: TextStyle(fontSize: 17),
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool move = false;
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              "CONFIRMATION",
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              "Quitter  le site",
              style: TextStyle(fontSize: 17),
            ),
            actions: [
              TextButton(
                child: Text("NON"),
                onPressed: () {
                  Navigator.of(context).pop();
                  move = false;
                },
              ),
              TextButton(
                child: Text("OUI"),
                onPressed: () {
                  move = true;
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
        return Future.value(move);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF020D1F),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
             widget.WebsiteName,
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                webViewController?.goBack();
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                webViewController?.goForward();
              },
            ),
            /* IconButton(
              icon: Badge(
                animationType: BadgeAnimationType.slide,
                badgeColor: AppColors.redAppbar,
                elevation: 0,
                position: BadgePosition.topStart(top: -8, start: 20),
                badgeContent: Consumer<PanierState>(
                  builder: (context, value, _) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      (value.contentPanier != null
                          ? value.contentPanier.length.toString()
                          : '0'),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 32,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Panier(),
                  ),
                );
              },
            ),*/
            SizedBox(width: 15)
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          color: AppColors.scaffoldBackgroundYellowForWelcomePage,
          progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.yellowAppbar),
          ),
          child: Column(
            children: [
              Visibility(
                visible: !webviewCreated,
                child: Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Chargement de la page....",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.redAppbar,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: errorOccured
                    ? Container(
                        width: fullWidth(context),
                        padding: EdgeInsets.fromLTRB(10, 21, 10, 21),
                        child: Column(
                          children: [
                            Icon(
                              Icons.flash_off,
                              color: Colors.amber,
                              size: 54,
                            ),
                            Text(
                              "Page introuvable",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: 14),
                           
                            SizedBox(height: 21),
                            
                            SizedBox(height: 14),
                           
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          InAppWebView(
                            key: webViewKey,
                            initialUrlRequest:
                                URLRequest(url: Uri.parse(widget.brand)),
                            initialOptions: options,
                            pullToRefreshController: pullToRefreshController,
                            onWebViewCreated: (controller) {
                              setState(() {
                                webviewCreated = true;
                              });
                              webViewController = controller;
                            },
                            onLoadStart: (controller, url) {
                              final String brand = widget.brand;
                              bool temp = false;
                              if (brand == AppNames.aliExpressFr) {
                                temp = "$url".contains("/item/");
                              }
                              if (brand == AppNames.alibabaFr) {
                                temp = ("$url".contains("/p-detail/") ||
                                    "$url".contains("/product/") ||
                                    "$url".contains("alibaba.com/p-detail/"));
                              }
                              if ([AppNames.amazonFr, AppNames.sheinFr]
                                  .contains(brand)) {
                                temp = true;
                              }
                              setState(() {
                                showAddButton = temp;
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },
                            androidOnPermissionRequest:
                                (controller, origin, resources) async {
                              return PermissionRequestResponse(
                                  resources: resources,
                                  action:
                                      PermissionRequestResponseAction.GRANT);
                            },
                            shouldOverrideUrlLoading:
                                (controller, navigationAction) async {
                              var uri = navigationAction.request.url;

                              if (![
                                "http",
                                "https",
                                "file",
                                "chrome",
                                "data",
                                "javascript",
                                "about"
                              ].contains(uri.scheme)) {
                                if (await canLaunch(url)) {
                                  // Launch the App
                                  await launch(
                                    url,
                                  );
                                  // and cancel the request
                                  return NavigationActionPolicy.CANCEL;
                                }
                              }

                              return NavigationActionPolicy.ALLOW;
                            },
                            onLoadStop: (controller, url) async {
                              pullToRefreshController.endRefreshing();
                              setState(() {
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },
                            onLoadError: (controller, url, code, message) {
                              pullToRefreshController.endRefreshing();
                              setState(() {
                                errorOccured = true;
                              });
                            },
                            onProgressChanged: (controller, progress) {
                              if (progress == 100) {
                                pullToRefreshController.endRefreshing();
                              }
                              setState(() {
                                this.progress = progress / 100;
                                urlController.text = this.url;
                              });
                            },
                            onUpdateVisitedHistory:
                                (controller, url, androidIsReload) {
                              setState(() {
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },
                            onConsoleMessage: (controller, consoleMessage) {
                              //print(consoleMessage);
                            },
                          ),
                          progress < 1.0
                              ? LinearProgressIndicator(value: progress)
                              : Container(),
                        ],
                      ),
              )
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: (errorOccured || (!webviewCreated))
            ? null
            : Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Card(
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /*    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          webViewController?.goBack();
                        },
                      ),*/
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                showAddButton ? Colors.blue : Colors.grey),
                            elevation: MaterialStateProperty.all(7)),
                        onPressed: showAddButton ? getProductDetails : null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Enregistrer le produit",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          webViewController?.goForward();
                        },
                      ),*/
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class AddToCartDialog extends StatefulWidget {
  final String productUrl;
  final String productName;
  final String productDescription;
  AddToCartDialog({
    @required this.productName,
    @required this.productDescription,
    @required this.productUrl,
  });
  @override
  _AddToCartDialogState createState() => _AddToCartDialogState();
}

class _AddToCartDialogState extends State<AddToCartDialog> {
  final _formKey = GlobalKey<FormState>();
  String productUrl = "";
  String productName = "";
  String productDescription = "";
  String productQuantite = "";
  File image;
// ImagePicker imagePicker = ImagePicker();

  handleChooseFromGallery() async {
/*    File tempFile = File((await imagePicker.getImage(source: ImageSource.gallery)).path);
    if (tempFile != null) {
      setState(() {
        image = tempFile;
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.only(left: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Builder(builder: (context) {
              return Theme(
                data: new ThemeData(
                  primaryColor: AppColors.indigo,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///
                    ///NOM DU PRODUIT
                    ///
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nom",
                            style: TextStyle(color: AppColors.indigo),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            maxLines: 1,
                            textInputAction: TextInputAction.next,
                            initialValue: widget.productName,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                    color: AppColors.lightGrey, width: 0.3),
                              ),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "N'oubliez pas le nom";
                              }
                              if (val.length < 3) {
                                return "Entrez un nom valide";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              productName = val;
                            },
                          ),
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
                          Text(
                            "Carctéristiques",
                            style: TextStyle(color: AppColors.indigo),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            maxLines: 5,
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
                                    color: AppColors.lightGrey, width: 0.3),
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
                              productDescription = val;
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
                          Text(
                            "Quantité",
                            style: TextStyle(color: AppColors.indigo),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            textInputAction: TextInputAction.next,
                            initialValue: "1",
                            decoration: InputDecoration(
                              hintText: "Quantité",
                              hintStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                    color: AppColors.lightGrey, width: 0.3),
                              ),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "N'oubliez pas la quantité";
                              }
                              if (val.contains('-') ||
                                  val.contains(',') ||
                                  val.contains(' ') ||
                                  val.contains('.')) {
                                return "Entrez un nombre sans espaces ni <, . ->";
                              }
                              if (int.parse(val) == 0) {
                                return "Veuillez entrer une quantité valide";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              productQuantite = val;
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
                            style: TextStyle(color: AppColors.indigo),
                          ),
                          Visibility(
                            visible: image == null,
                            child: Text(
                              "Il est conseillé d'ajouter un screenshot de la page web montrant le produit",
                              style: TextStyle(color: AppColors.yellowAppbar),
                            ),
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
                                    child: image != null
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
                                      ? Text("Image insérée")
                                      : Text("Insérer une image du produit"),
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.green,
                          ),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            /*  _formKey.currentState.save();
                            Provider.of<PanierState>(context, listen: false)
                                .contentPanierAdd(
                              Product(
                                nom: productName,
                                lien: widget.productUrl,
                                description: productDescription,
                                quantite: int.parse(productQuantite),
                                image: (image != null)
                                    ? base64Encode(image.readAsBytesSync())
                                    : null,
                              ),
                            );
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.lightBlue,
                                content: Text(
                                  "Article ajouté au panier!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.fromLTRB(15, 0, 15, 25),
                              ),
                            );*/
                          }
                          /* else {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: AppColors
                                  .scaffoldBackgroundYellowForWelcomePage,
                              content: Text(
                                "Une information est ommise ou erronée",
                                textAlign: TextAlign.center,
                              ),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
                            ));
                          } */
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "Ajouter au panier",
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
              );
            }),
          ),
        ),
      ],
    );
  }
}
