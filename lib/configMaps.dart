import 'dart:async';

//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driver_app/Models/drivers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:driver_app/Models/allUsers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String mapKey = "AIzaSyCz5b_Z9M9Mhf-GwCN3M783WFl9xMGR9kw";

User? firebaseUser;

Users? userCurrentInfo;

User? currentfirebaseUser;

StreamSubscription<Position>? homeTabPageStreamSubscription;

StreamSubscription<Position>? rideStreamSubscription;

//final assetsAudioPlayer = AssetsAudioPlayer();

Position? currentPosition;

Drivers? driversInformation;

String title="";
double starCounter=0.0;

String rideType="";

//flutter run --no-sound-null-safety
