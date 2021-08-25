import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/AllScreens/loginScreen.dart';
import 'package:driver_app/AllScreens/mainscreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookingScreen extends StatelessWidget {
  //const BookingScreen({Key? key}) : super(key: key);
  static const String idScreen = "bookingscreen";

  String uid = FirebaseAuth.instance.currentUser!.uid;

  DatabaseReference DBRef = FirebaseDatabase.instance.reference().child('drivers/Forms');

  TextEditingController carTextEditingController = TextEditingController();
  TextEditingController storageTextEditingController = TextEditingController();
  TextEditingController destinationTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Add Availability"),
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: carTextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Cartype",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),

                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0),
                    TextField(
                      controller: storageTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Storage Description",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),

                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 1.0),
                    TextField(
                      controller: destinationTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Destination",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),

                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 1.0),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Telephone",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),

                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0),
                    TextFormField(
                      controller: dateTextEditingController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "Departure Date",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),

                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 10.0),
                    RaisedButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        child: Container(
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 18.0, fontFamily: "Brand Bold"),
                            ),
                          ),

                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0),
                        ),
                        onPressed: () {
                          if (carTextEditingController.text.isEmpty) {
                            displayToastMessage(
                                "CarName is mandatory", context);
                          }
                          else if (storageTextEditingController.text.isEmpty) {
                            displayToastMessage("storage is mandatory",
                                context);
                          }
                          else if (phoneTextEditingController.text.isEmpty) {
                            displayToastMessage(
                                "Phone Number is mandatory", context);
                          }
                          else
                          if (destinationTextEditingController.text.isEmpty) {
                            displayToastMessage(
                                "Destination is mandatory", context);
                          }
                          else {
                            registerNewForm(context);
                          }
                        }
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  void registerNewForm(BuildContext context) {
    //save user info into db
   Map<String, String> driver ={
      "Cartype": carTextEditingController.text.trim(),
      "storage": storageTextEditingController.text.trim(),
      "phone": '+233'+ phoneTextEditingController.text.trim(),
      "destination": destinationTextEditingController.text.trim(),
      "depatrtureTime": dateTextEditingController.text.trim(),
    };
   DBRef.child(uid.toString()).push().set(driver);
    displayToastMessage("Congratulations, your details have been submitted successfully", context);
    Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
  }

  displayToastMessage(String message, BuildContext context)
  {
    Fluttertoast.showToast(msg: message);
  }
}
