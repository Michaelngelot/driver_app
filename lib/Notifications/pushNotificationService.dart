
import 'package:driver_app/Models/rideDetails.dart';
import 'package:driver_app/Notifications/notificationDialog.dart';
import 'package:driver_app/configMaps.dart';
import 'package:driver_app/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PushNotificationService
{
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future initialize(context) async {

    //onMessage
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      retrieveRideRequestInfo(getRideRequestId(message), context);
    });

    //onResume
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      retrieveRideRequestInfo(getRideRequestId(message), context);
    });

    //onLaunch
    final RemoteMessage ? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      retrieveRideRequestInfo(getRideRequestId(initialMessage), context);
    }

  }


  Future<String?> getToken() async
  {
    String? token = await firebaseMessaging.getToken();
    print("This is token :: ");
    print(token);
    driversRef.child(currentfirebaseUser!.uid).child("token").set(token);

    firebaseMessaging.subscribeToTopic("alldrivers");
    //firebaseMessaging.subscribeToTopic("allusers");
  }

  String getRideRequestId(message)
  {
    String rideRequestId = "";
    if(Platform.isAndroid)
    {
       rideRequestId = message['data']['ride_request_id'];
    }
    else
    {
       rideRequestId = message['ride_request_id'];
    }

    return rideRequestId;
  }

  void retrieveRideRequestInfo(String rideRequestId, BuildContext context)
  {
    newRequestsRef.child(rideRequestId).once().then((DataSnapshot dataSnapShot)
    {
      if(dataSnapShot.value != null)
      {
        //assetsAudioPlayer.open(Audio("sounds/alert.mp3"));
        //assetsAudioPlayer.play();

        double pickUpLocationLat = double.parse(dataSnapShot.value['pickup']['latitude'].toString());
        double pickUpLocationLng = double.parse(dataSnapShot.value['pickup']['longitude'].toString());
        String pickUpAddress = dataSnapShot.value['pickup_address'].toString();

        double dropOffLocationLat = double.parse(dataSnapShot.value['dropoff']['latitude'].toString());
        double dropOffLocationLng = double.parse(dataSnapShot.value['dropoff']['longitude'].toString());
        String dropOffAddress = dataSnapShot.value['dropoff_address'].toString();

        String paymentMethod = dataSnapShot.value['payment_method'].toString();

        String rider_name = dataSnapShot.value["rider_name"];
        String rider_phone = dataSnapShot.value["rider_phone"];

        RideDetails rideDetails = RideDetails(payment_method: '', dropoff_address: '', rider_phone: '', rider_name: '', pickup_address: '',  ride_request_id: '',);
        rideDetails.ride_request_id = rideRequestId;
        rideDetails.pickup_address = pickUpAddress;
        rideDetails.dropoff_address = dropOffAddress;
        rideDetails.pickup = LatLng(pickUpLocationLat, pickUpLocationLng);
        rideDetails.dropoff = LatLng(dropOffLocationLat, dropOffLocationLng);
        rideDetails.payment_method = paymentMethod;
        rideDetails.rider_name = rider_name;
        rideDetails.rider_phone = rider_phone;

        print("Information :: ");
        print(rideDetails.pickup_address);
        print(rideDetails.dropoff_address);

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => NotificationDialog(rideDetails: rideDetails,),
        );
      }
    });
  }
}