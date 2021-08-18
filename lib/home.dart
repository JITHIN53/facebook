import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  bool _isLoggedIn =false;
  Map _userObj ={};

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("facebook"),
      ),
      body: Container(
        child: _isLoggedIn?
            Column(
              children: [
                Image.network(_userObj["picture"]["data"]["url"]),
                Text(_userObj["name"]),
                Text(_userObj["email"]),
                TextButton(onPressed: () {}, child: Text("logout"))
              ],
            )
            : Center(
          child: ElevatedButton(
            child: Text("login with facebook"),
            onPressed: () async{
              FacebookAuth.instance.login(
                permissions: ["public_profile","email"]
              ).then((value){
                FacebookAuth.instance.getUserData().then((userData){
                  setState(() {
                    _isLoggedIn = true;
                    _userObj = userData;
                  });
                });
              });
            },
          ),
        ),
      ),
    );
  }
}

