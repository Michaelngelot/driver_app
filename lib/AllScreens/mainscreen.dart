import 'package:driver_app/AllScreens/availablebookingsScreen.dart';
import 'package:driver_app/AllScreens/bookingScreen.dart';
import 'package:driver_app/AllScreens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
const MainScreen({Key? key}) : super(key: key);
static const String idScreen = "mainScreen";

@override
_MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

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
