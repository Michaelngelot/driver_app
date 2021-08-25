import 'package:driver_app/AllScreens/bookingScreen.dart';
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
        backgroundColor: Colors.red,
       title: Text("Main Screen"),
      ),
      key: scaffoldkey,

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
              leading: Icon(Icons.person),
              title: Text("Visit Profile", style: TextStyle(fontSize: 15.0),),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Add Bookings", style: TextStyle(fontSize: 15.0),),
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(
                      context, BookingScreen.idScreen, (route) => false);
                }
            ),
          ],
        ),
        ),
      ),
      body: Stack(
        children: [

        ],
      ),
    );
  }
}
