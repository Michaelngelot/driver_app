import 'package:driver_app/AllScreens/availablebookingsScreen.dart';
import 'package:driver_app/AllScreens/bookingScreen.dart';
import 'package:driver_app/AllScreens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MainScreen extends StatefulWidget {
const MainScreen({Key? key}) : super(key: key);
static const String idScreen = "mainScreen";

@override
_MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  var bPadding=0.0;
  //late String _resultAddress;
  Completer<GoogleMapController> _newGooglecontroller = Completer();
  late GoogleMapController userMap;

  late Position currentPosition;
  var geoLocator = Geolocator();

  void getCurrentLocation() async{
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
    currentPosition = position;
    LatLng lang = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition= CameraPosition(target: lang, zoom: 14.0);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
       title: Text("DRIVER APP"),
      ),
      key: scaffoldkey,
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(
            context, MaterialPageRoute(builder: (context)=>BookingScreen()));

      },
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add,color: Colors.white,),

      ),

      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
        child: ListView(
          children: [
            Container(
                height: 165.0,
                child: DrawerHeader(
                 decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset("images/user_icon.png", height: 65.0, width: 65.0,),
                    SizedBox (width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Profile Name", style: TextStyle(fontSize: 16.0, fontFamily: "Brand-Bold"),),
                          SizedBox(height: 6.0,),
                          Text("Visit Profile"),
                        ],
                      )
                    ],
                    ),
                ),
            ),
           Divider(),

            SizedBox(height: 12.0,),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("History", style: TextStyle(fontSize: 15.0),),
            ),
            ListTile(
              leading: Icon(Icons.departure_board),
              title: Text("Bookings Added", style: TextStyle(fontSize: 15.0),),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>AvailableBookingScreen()));
                },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout", style: TextStyle(fontSize: 15.0),),
              onTap: () {
                signout(context);
              }
            ),
          ],
        ),
        ),
      ),
      body: Stack(
        children: [
               GoogleMap(
                 initialCameraPosition: _kGooglePlex,
                 mapType: MapType.normal,
                 myLocationEnabled: true,
                 tiltGesturesEnabled: true,
                 zoomGesturesEnabled: true,
                 zoomControlsEnabled: true,
                 onMapCreated: (GoogleMapController controller){
                   _newGooglecontroller.complete(controller);
                   userMap=controller;
                   setState(() {
                     bPadding = 305.0;
                   });
                   getCurrentLocation();
                 },
             ),
      ]),
    );
  }
  //logout from page
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
 Future<void> signout(BuildContext context) async {
    await _firebaseAuth.signOut().then((value) =>
      Navigator.of(
          context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false));
 }


}
