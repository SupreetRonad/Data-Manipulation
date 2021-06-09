import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_app/main.dart';

class GoogleSignedIn extends StatefulWidget {
  final auth1, flag;

  const GoogleSignedIn({this.auth1, this.flag});

  @override
  _GoogleSignedInState createState() => _GoogleSignedInState();
}

class _GoogleSignedInState extends State<GoogleSignedIn> {
  bool loading = true;
  var name, email, image;
  FacebookLogin facebookLogin = FacebookLogin();
  GoogleSignIn googleUser = GoogleSignIn(scopes: ['email']);

  void getUserInfo(auth1, flag) {
    var auth = auth1;

    setState(() {
      name = auth.displayName;
      email = auth1.email;
      image = flag ? auth1.photoUrl : auth1.photoURL;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      getUserInfo(widget.auth1, widget.flag);
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
                      widget.flag ? googleUser.signOut() : facebookLogin.logOut();
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
