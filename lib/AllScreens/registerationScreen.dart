import 'package:driver_app/AllScreens/loginScreen.dart';
import 'package:driver_app/AllScreens/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:driver_app/main.dart';

class RegistrationScreen extends StatefulWidget {

  static const String idScreen = "register";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController licenseTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              Image(
                image: AssetImage("images/fleet-truck_601ff552af2f0.png"),
                alignment: Alignment.center,
                width: 390.0,
                height: 250.0,
              ),
              SizedBox(height: 15.0,),
              Text(
                "Signup As A Driver",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Name",
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
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
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
                      controller: licenseTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "License",
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
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
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
                              "Signup",
                              style: TextStyle(fontSize: 18.0, fontFamily:"Brand Bold" ),
                            ),
                          ),

                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0),
                        ),
                        onPressed: ()
                        {
                          if (nameTextEditingController.text.length < 4)
                          {
                            displayToastMessage("Name must be at least 3 characters", context);
                          }
                          else if ((!emailTextEditingController.text.contains("@")))
                            {
                              displayToastMessage("Email is not valid", context);
                            }
                         else if (phoneTextEditingController.text.isEmpty)
                           {
                             displayToastMessage("Phone Number is mandatory", context);
                           }
                         else if (passwordTextEditingController.text.length < 6)
                           {
                             displayToastMessage("password must be at least 6 characters", context);
                           }
                         else
                           {
                             registerNewUser(context);
                           }

                        }

                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed:()
                {
                  Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
                },
                child: Text(
                    "Already have an Account? Login Here."
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async
  {
final User? firebaseUser = (await _firebaseAuth
    .createUserWithEmailAndPassword(
    email: emailTextEditingController.text,
    password: passwordTextEditingController.text
).catchError ((errMsg){
  displayToastMessage("error: " + errMsg.toString(), context);
})).user;
if (firebaseUser !=null)//user created
{
  //save user info into db
  Map userDataMap = {
    "name": nameTextEditingController.text.trim(),
    "email": emailTextEditingController.text.trim(),
    "phone": phoneTextEditingController.text.trim(),
    "license": licenseTextEditingController.text.trim(),
    "password": passwordTextEditingController.text.trim(),
  };

  usersRef.child(firebaseUser.uid).set(userDataMap);
  displayToastMessage("Congratulations, your account has been created successfully", context);
  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
}
else
  {
//error occured
displayToastMessage("New Driver Account Is Created", context);
  }
  }

  displayToastMessage(String message, BuildContext context)
  {
    Fluttertoast.showToast(msg: message);
  }
}
