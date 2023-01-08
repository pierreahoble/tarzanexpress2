import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../constants/appColors.dart';
import '../../../widgets/customWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewProduct extends StatefulWidget {
  final String initialUrl;
  ViewProduct({@required this.initialUrl});
  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  final GlobalKey webViewKey = GlobalKey();
  // InAppWebViewController webViewController;
  // InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
  //   crossPlatform: InAppWebViewOptions(
  //     useShouldOverrideUrlLoading: true,
  //     mediaPlaybackRequiresUserGesture: false,
  //   ),
  //   android: AndroidInAppWebViewOptions(
  //     useHybridComposition: true,
  //   ),
  //   ios: IOSInAppWebViewOptions(
  //     allowsInlineMediaPlayback: true,
  //   ),
  // );
  // PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();
  bool errorOccured = false;

  @override
  void initState() {
    super.initState();

    // pullToRefreshController = PullToRefreshController(
    //   options: PullToRefreshOptions(
    //     color: Colors.blue,
    //   ),
    //   onRefresh: () async {
    //     if (Platform.isAndroid) {
    //       webViewController?.reload();
    //     } else if (Platform.isIOS) {
    //       webViewController?.loadUrl(
    //           urlRequest: URLRequest(url: await webViewController?.getUrl()));
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.close_outlined),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.redAppbar),
        title: Text(
          "Voir Produit",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              // webViewController?.goBack();
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              // webViewController?.goForward();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
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
                          "Hmm. Nous ne parvenons pas à trouver cette page.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          "Voici trois choses que vous pouvez essayer:",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 21),
                        Text(
                          " - Vérifiez votre connection réseau.\n - Réessayez plus tard.\n - Si vous êtes connecté mais derrière un pare-feu, vérifiez d'être autorisé à accéder au Web.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 14),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue[900]),
                          ),
                          onPressed: () {
                            setState(() {
                              errorOccured = false;
                            });
                          },
                          child: Text(
                            "Réessayer",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      // InAppWebView(
                      //   key: webViewKey,
                      //   initialUrlRequest:
                      //       URLRequest(url: Uri.parse(widget.initialUrl)),
                      //   initialOptions: options,
                      //   pullToRefreshController: pullToRefreshController,
                      //   onWebViewCreated: (controller) {
                      //     webViewController = controller;
                      //   },
                      //   onLoadStart: (controller, url) {
                      //     setState(() {
                      //       this.url = url.toString();
                      //       urlController.text = this.url;
                      //     });
                      //   },
                      //   androidOnPermissionRequest:
                      //       (controller, origin, resources) async {
                      //     return PermissionRequestResponse(
                      //         resources: resources,
                      //         action: PermissionRequestResponseAction.GRANT);
                      //   },
                      //   shouldOverrideUrlLoading:
                      //       (controller, navigationAction) async {
                      //     var uri = navigationAction.request.url;

                      //     if (![
                      //       "http",
                      //       "https",
                      //       "file",
                      //       "chrome",
                      //       "data",
                      //       "javascript",
                      //       "about"
                      //     ].contains(uri.scheme)) {
                      //       if (await canLaunch(url)) {
                      //         // Launch the App
                      //         await launch(
                      //           url,
                      //         );
                      //         // and cancel the request
                      //         return NavigationActionPolicy.CANCEL;
                      //       }
                      //     }

                      //     return NavigationActionPolicy.ALLOW;
                      //   },
                      //   onLoadStop: (controller, url) async {
                      //     pullToRefreshController.endRefreshing();
                      //     setState(() {
                      //       this.url = url.toString();
                      //       urlController.text = this.url;
                      //     });
                      //   },
                      //   onLoadError: (controller, url, code, message) {
                      //     pullToRefreshController.endRefreshing();
                      //     setState(() {
                      //       errorOccured = true;
                      //     });
                      //   },
                      //   onProgressChanged: (controller, progress) {
                      //     if (progress == 100) {
                      //       pullToRefreshController.endRefreshing();
                      //     }
                      //     setState(() {
                      //       this.progress = progress / 100;
                      //       urlController.text = this.url;
                      //     });
                      //   },
                      //   onUpdateVisitedHistory:
                      //       (controller, url, androidIsReload) {
                      //     setState(() {
                      //       this.url = url.toString();
                      //       urlController.text = this.url;
                      //     });
                      //   },
                      //   onConsoleMessage: (controller, consoleMessage) {
                      //     // print(consoleMessage);
                      //   },
                      // ),
                      // progress < 1.0
                      //     ? LinearProgressIndicator(value: progress)
                      //     :
                           Container(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
