import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_app/main.dart';
import 'package:sign_in_app/signIn.dart';

class GoogleSignedIn extends StatefulWidget {
  final googleAuth;

  const GoogleSignedIn(this.googleAuth);

  @override
  _GoogleSignedInState createState() => _GoogleSignedInState();
}

class _GoogleSignedInState extends State<GoogleSignedIn> {
  bool loading = true;
  var name, email, image;

  void getUserInfo(googleAuth) {
    setState(() {
      name = googleAuth.currentUser.displayName;
      email = googleAuth.currentUser.email;
      image = googleAuth.currentUser.photoUrl;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      getUserInfo(widget.googleAuth);
    }
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.network(
                      image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                    onPressed: () {
                      widget.googleAuth.signOut();
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                      );
                    },
                    child: Text("Sign Out"),
                  )
                ],
              ),
            ),
    );
  }
}
