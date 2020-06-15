import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn ,this.isLoading);
  final bool isLoading ;
  final void Function(
      String email,
      String password,
      String username,
      bool isLogin,
      BuildContext ctx,
      ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true ;
  String _userEmail = ''  ;
  String _userName =  '';
  String _userPassword = '' ;


  void _trySubmit()
  {
   final isValid = _formKey.currentState.validate();
   FocusScope.of(context).unfocus();         // so that kyeborad closes reach tym
   if(isValid)
     {
       _formKey.currentState.save();
       widget.submitFn(
         _userEmail.trim(),
         _userPassword.trim(), // trim doesnot considers any spces ne4 or after the input
         _userName.trim(),
         _isLogin,
         context
       );

       //use those values to send our auth request......
     }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
       margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if(value.isEmpty  ||  !value.contains('@'))
                          {
                            return "Please enter a valid Email address.";
                          }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email-Address",
                      ),
                        onSaved:(value) {
                          _userEmail = value ;
                        }
                    ),
                    if(!_isLogin)
                    TextFormField(
                      validator: (value) {
                        if(value.isEmpty)
                          {
                            return "Please enter a valid username";
                          }
                        return null;
                      },
                      decoration: InputDecoration(          //username
                        labelText: "Username",),
                        onSaved:(value) {
                        _userName = value ;
                        } ,
                    ),
                    TextFormField(
                      validator: (value) {
                        if(value.isEmpty || value.length < 7)
                          {
                           return "Password must be atleast 7 characters long";
                          }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Password"
                      ),
                      onSaved:(value) {
                        _userPassword = value ;
                      },
                      obscureText:  true,  //this will hide the password,
                    ),
                    SizedBox(height:12),
                    if(widget.isLoading)
                      CircularProgressIndicator(),         //loading spinner
                    if(!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: _trySubmit ,
                    ),
                    if(!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin ? 'Create new account' : "Already have an acoount"),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin ;
                        });
                      },
                    )
                  ],

              ),),
           )
         ),
        ),
    );
  }
}
