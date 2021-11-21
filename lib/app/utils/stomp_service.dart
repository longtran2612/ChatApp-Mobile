import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class StompService {
  static var stompClient = null;
  static var wsUrl = dotenv.env['WS_URL'];
  final _userId = Storage.getToken()?.username;
  final _token = Storage.getToken()?.accessToken;

  void startStomp() {
    if (stompClient == null) {
      initStomp();
    }
    stompClient.activate();
  }

  void desTroyStomp() {
    if (stompClient != null) {
      stompClient.deactivate();
    }
  }

  void initStomp() {
    stompClient = StompClient(
      config: StompConfig.SockJS(
          url: '${wsUrl}',
          onConnect: onConnect,
          onDisconnect: onDisconnect,
          beforeConnect: () async {
            print('connecting...');
          },
          onWebSocketError: (dynamic error) {
            print('websocket error');
            print(error.toString());
          },
          stompConnectHeaders: {
            'userId': _userId.toString(),
            'token': _token.toString(),
          },
          webSocketConnectHeaders: {
            'userId': _userId,
            'token': _token,
          }),
    );
  }

  void onConnect(StompFrame frame) {
    print("--Connected---");
  }

  dynamic onDisconnect(StompFrame frame) {
    print("--onDisconnect---");
  }

  dynamic onStompError(StompFrame frame) {
    print("--onStompError---");
    print(json.decode(frame.body.toString()));
  }
}
