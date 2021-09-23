import 'package:driver_app/AllScreens/SplashScreen.dart';
import 'package:driver_app/AllScreens/availablebookingsScreen.dart';
import 'package:driver_app/AllScreens/bookingScreen.dart';
import 'package:driver_app/AllScreens/loginScreen.dart';
import 'package:driver_app/AllScreens/mainscreen.dart';
import 'package:driver_app/AllScreens/registerationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("drivers");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Freight Driver App',
        theme: ThemeData(
         fontFamily: "Brand Bold",

          primarySwatch: Colors.blue,
        ),
        initialRoute: Splash.idScreen,
        routes: {
          Splash.idScreen: (context)=> Splash(),
          RegistrationScreen.idScreen: (context)=> RegistrationScreen(),
          LoginScreen.idScreen: (context)=> LoginScreen(),
          MainScreen.idScreen: (context)=> MainScreen(),
        BookingScreen.idScreen: (context)=> BookingScreen(),
        AvailableBookingScreen.idScreen: (context)=> AvailableBookingScreen(),
        },
        debugShowCheckedModeBanner: false,
    );
}
