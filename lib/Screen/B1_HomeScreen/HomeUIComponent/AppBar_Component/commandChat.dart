import 'package:provider/provider.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:trevashop_v2/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trevashop_v2/providers/commande_provider.dart';
import 'package:trevashop_v2/providers/messageCommande_provider.dart';
import 'package:trevashop_v2/services/shared_preferences.dart';

class CommandChat extends StatefulWidget {
  @override
  _CommandChatState createState() => _CommandChatState();
  int id;
  String reference;
  CommandChat({@required this.id, @required this.reference});
}

/// defaultUserName use in a Chat name
const String defaultUserName = "Alisa Hearth";

class _CommandChatState extends State<CommandChat>
    with TickerProviderStateMixin {
  List<dynamic> _messages = [];

  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;
  bool isload = true;

  var token;
  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      isload = true;
    });

    SharedPreferencesClass.restore("token").then((onValue) {
      setState(() {
        token = onValue;
        print(token);
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          // Provider.of<MessageCommandsProvider>(context, listen: false)
          //     .clearMessages();
          Provider.of<MessageCommandsProvider>(context, listen: false)
              .setMessages(token, widget.id.toString());
        } catch (e) {}
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    var collect = Provider.of<MessageCommandsProvider>(context, listen: true);
    var collectMessages =
        Provider.of<MessageCommandsProvider>(context, listen: true);

    void _submitMsg(String txt) {
      //final int long = collectMessages.getMessages.length;
      collectMessages
          .addMessages(0, {"contenu": _textController.text, "is_admin": 0});

      _textController.clear();
      setState(() {
        _isWriting = false;
      });
      // Msg msg = new Msg(
      //   txt: txt,
      //   animationController: new AnimationController(
      //       vsync: this, duration: new Duration(milliseconds: 800)),
      // );

      //msg.animationController.forward();
    }

    return EasyLocalizationProvider(
        data: data,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.4,
              title: Text(
                widget.reference,
                style: TextStyle(
                    fontFamily: "Gotik", fontSize: 18.0, color: Colors.black54),
              ),
              iconTheme: IconThemeData(color: Color(0xFF6991C7)),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),

            /// body in chat like a list in a message
            body: Container(
              color: Colors.white,
              child: new Column(children: <Widget>[
                new Flexible(
                    child: collect.getMessages == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : collect.getMessages.length == 0
                            ? NoMessage()
                            : Container(
                                child: new ListView.builder(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (collect.getMessages[index]
                                            ['is_admin'] ==
                                        0) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 3 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Colors.green,
                                              elevation: 5,
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 20,
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 4),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${collect.getMessages[index]['contenu']}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Icon(
                                                              Icons.check,
                                                              color: collect.getMessages[
                                                                              index]
                                                                          [
                                                                          'is_read'] ==
                                                                      1
                                                                  ? Colors.blue
                                                                  : Colors
                                                                      .white,
                                                            )
                                                          ],
                                                        )
                                                      ])),
                                            ),
                                          )
                                        ],
                                      );
                                    } else {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 3 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Color.fromARGB(
                                                  255, 27, 43, 27),
                                              elevation: 10,
                                              child: Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Text(
                                                  "${collect.getMessages[index]['contenu']}",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                  },
                                  itemCount: collect.getMessages.length,
                                  reverse: true,
                                  padding: new EdgeInsets.all(10.0),
                                ),
                              )),

                /// Line
                new Divider(height: 1.5),
                new Container(
                  child: IconTheme(
                    data:
                        new IconThemeData(color: Theme.of(context).accentColor),
                    child: new Container(
                        margin: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: new Row(
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.blueAccent,
                              size: 27.0,
                            ),
                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new TextField(
                                      controller: _textController,
                                      onChanged: (String txt) {
                                        setState(() {
                                          _isWriting = txt.length > 0;
                                        });
                                      },
                                      onSubmitted: _submitMsg,
                                      decoration: new InputDecoration.collapsed(
                                          hintText: 'Votre message',
                                          hintStyle: TextStyle(
                                              fontFamily: "Sans",
                                              fontSize: 16.0,
                                              color: Colors.black26)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            new Container(
                                margin:
                                    new EdgeInsets.symmetric(horizontal: 3.0),
                                child: Theme.of(context).platform ==
                                        TargetPlatform.iOS
                                    ? new CupertinoButton(
                                        child: new Text("Submit"),
                                        onPressed: _isWriting
                                            ? () {
                                                collectMessages.postMessageText(
                                                    token,
                                                    widget.id.toString(),
                                                    _textController.text);
                                                _submitMsg(
                                                    _textController.text);
                                              }
                                            : null)
                                    : new IconButton(
                                        icon: new Icon(Icons.message),
                                        onPressed: _isWriting
                                            ? () {
                                                collectMessages.postMessageText(
                                                    token,
                                                    widget.id.toString(),
                                                    _textController.text);
                                                _submitMsg(
                                                    _textController.text);
                                              }
                                            : null,
                                      )),
                          ],
                        ),
                        decoration: Theme.of(context).platform ==
                                TargetPlatform.iOS
                            ? new BoxDecoration(
                                border: new Border(
                                    top: new BorderSide(color: Colors.brown)))
                            : null),
                  ),
                  decoration: new BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(blurRadius: 1.0, color: Colors.black12)
                      ]),
                ),
              ]),
            )));
  }

  /// Component for typing text
  // Widget _buildComposer() {
  //   var Messages = Provider.of<MessageCommandsProvider>(context);

  //   return new IconTheme(
  //     data: new IconThemeData(color: Theme.of(context).accentColor),
  //     child: new Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 9.0),
  //         child: new Row(
  //           children: <Widget>[
  //             Icon(
  //               Icons.add,
  //               color: Colors.blueAccent,
  //               size: 27.0,
  //             ),
  //             new Flexible(
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 5.0),
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.black12),
  //                   ),
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: new TextField(
  //                       controller: _textController,
  //                       onChanged: (String txt) {
  //                         setState(() {
  //                           _isWriting = txt.length > 0;
  //                         });
  //                       },
  //                       onSubmitted: _submitMsg,
  //                       decoration: new InputDecoration.collapsed(
  //                           hintText: 'hintChat',
  //                           hintStyle: TextStyle(
  //                               fontFamily: "Sans",
  //                               fontSize: 16.0,
  //                               color: Colors.black26)),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             new Container(
  //                 margin: new EdgeInsets.symmetric(horizontal: 3.0),
  //                 child: Theme.of(context).platform == TargetPlatform.iOS
  //                     ? new CupertinoButton(
  //                         child: new Text("Submit"),
  //                         onPressed: _isWriting
  //                             ? () {
  //                                 _submitMsg(_textController.text);
  //                               }
  //                             : null)
  //                     : new IconButton(
  //                         icon: new Icon(Icons.message),
  //                         onPressed: _isWriting
  //                             ? () {
  //                                 /* Messages.postMessageText(
  //                                     token,
  //                                     widget.id.toString(),
  //                                     _textController.text);*/
  //                                 _submitMsg(_textController.text);
  //                               }
  //                             : null,
  //                       )),
  //           ],
  //         ),
  //         decoration: Theme.of(context).platform == TargetPlatform.iOS
  //             ? new BoxDecoration(
  //                 border: new Border(top: new BorderSide(color: Colors.brown)))
  //             : null),
  //   );
  // }

  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
}

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});

  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.fastOutSlowIn),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Expanded(
              child: Padding(
                padding: const EdgeInsets.all(00.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(1.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0)),
                        color: Color(0xFF6991C7).withOpacity(0.6),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: new Text(
                        txt,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
//            new Container(
//              margin: const EdgeInsets.only(right: 5.0,left: 10.0),
//              child: new CircleAvatar(
//                backgroundImage: AssetImage("assets/avatars/avatar-1.jpg"),
////                  backgroundColor: Colors.indigoAccent,
////                  child: new Text(defaultUserName[0])),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}

class NoMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(
              child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    "assets/imgIllustration/IlustrasiMessage.png",
                    height: 220.0,
                  )),
            ),
          ),
          Center(
              child: Text(
            'Pas de message',
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.black12,
                fontSize: 17.0,
                fontFamily: "Popins"),
          ))
        ],
      ),
    ));
  }
}
