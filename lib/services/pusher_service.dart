import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

class PusherService {
  Event lastEvent;
  String lastConnectionState;
  String currentConnectionState;
  Channel channel;

  Future<void> initPusher() async {
    try {
      await Pusher.init(
        "92ec880c1a528fa0f007" /* APP_KEY */,
        PusherOptions(
          cluster: "eu",
          /* PUSHER_CLUSTER */
         // activityTimeout: 100000,
        ),
      );
    } on PlatformException catch (/* e */ _) {
      //print(e.message);
    }

  //   connectPusher();
  //  await subscribePusher("esugu-app").then((value) {
  //    bindEvent("esugu-push");
  //  });
    
  }

  void connectPusher() {
    Pusher.connect(
        onConnectionStateChange: (ConnectionStateChange connectionState) async {
      lastConnectionState = connectionState.previousState;
      currentConnectionState = connectionState.currentState;
      print(connectionState.currentState);
      //print("PUSHER PREVIOUS STATE == ${connectionState.previousState}");
      //print("PUSHER CURRENT STATE == ${connectionState.currentState}");
    }, onError: (ConnectionError e) {
      print(e.message);
      //print("Error: ${e.toJson().toString()}");
    });
  }

  Future<Channel> subscribePusher(String channelName) async {
    channel = await Pusher.subscribe(channelName);
    return channel;
  }

  void unSubscribePusher(String channelName) {
    Pusher.unsubscribe(channelName);
  }

  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;

  void bindEvent(String eventName) {
    channel.bind(eventName, (last) {
      final String data = last.data;
      //print("Data from pusher :" + last.data);
      //_inEventData.add(data);
    });
  }

  void unbindEvent(String eventName) {
    channel.unbind(eventName);
    _eventData.close();
  }

  Future<void> firePusher(
    String channelName,
    List<String> eventNames,
  ) async {
    await initPusher();
    connectPusher();
    await subscribePusher(channelName);
    for (var i = 0; i < eventNames.length; i++) {
      bindEvent(eventNames[i]);
    }
  }
}
