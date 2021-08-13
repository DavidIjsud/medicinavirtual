
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class PushNotificationProvider{

     FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    final _mensajesStreamController = StreamController<String>.broadcast();
    Stream<String> get mensajes => _mensajesStreamController.stream;

  
  initNotifications() {
  
    _firebaseMessaging.requestPermission(); 
    _firebaseMessaging.getToken().then( (token) {

     // print('El token');
      print( 'El Token '+token );
     
        });

        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
               print(message.data);
         }); 
         FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
              print(message.data);
        });
  }

}