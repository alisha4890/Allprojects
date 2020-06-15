
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutterchatapp/widgets/auth/auth_forum.dart';
import'package:cloud_firestore/cloud_firestore.dart';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  var _isLoading =false ;
  void _submitAuthForm(
      String email,
      String password,
      String username,
      bool isLogin,
      BuildContext ctx
      )
    async {
      AuthResult authResult;
      try {
        setState(() {
          _isLoading = true;
        });
        if (isLogin) {
          authResult = await _auth.signInWithEmailAndPassword(
              email: email, password: password);
        } else {
          authResult = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          await Firestore.instance                                   // managing and storing extra user data own our own
              .collection('users')
              .document(authResult.user.uid)
              .setData({
            'username' : username,
            'email': email,

          });
        }
      }
      on PlatformException catch(err) { // catch not any error but platefrom one== particular!!
        var message = 'An error occured ,please check you credentials!';
        if (err.message != null) {
          message = err.message; //override the msg
        }
        //showing error to user =  snackbar does this
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme
                .of(context)
                .errorColor,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
      catch (err) {
        print(err);               //if any other error ..display
        setState(() {
          _isLoading = false;
        });
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),


    );
  }
}
