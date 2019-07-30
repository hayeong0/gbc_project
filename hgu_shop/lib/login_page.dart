import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hgu_shop/tab_page.dart';

class LoginPage extends StatelessWidget{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HGU Shop',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(50.0),
            ),
            SignInButton(
              Buttons.Google, onPressed: (){
                _handleSignIn().then((user){
                  //print(user);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => TabPage(user)));
                });
              },
            ),
            //facebook 아직안함
            SignInButton(
              Buttons.Facebook, onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }

  //비동기
  //firebase와 연결
  Future<FirebaseUser> _handleSignIn() async{
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user= await _auth.signInWithCredential(
      GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
    return user;
  }
}