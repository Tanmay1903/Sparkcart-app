import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkcart/Components/getSnackbar.dart';
import 'package:sparkcart/Pages/RegisterPage.dart';
import 'package:sparkcart/dimensions.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLoggedIn = false;
  check_user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLogin') != null ? prefs.getBool('isLogin') : false ;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_user();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            letterSpacing: 2
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
              leading: Icon(
                Icons.app_registration,
                color: Colors.pink[800],
              ),
              title: Text(
                'Register',
                style: TextStyle(
                    color: Colors.pink[800],
                    fontSize: Dimensions.boxHeight*3,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            ListTile(
              onTap: (){
                SnackBar snackBar = getSnackBar("Coming soon");
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
              leading: Icon(
                Icons.edit,
                color: Colors.pink[800],
              ),
              title: Text(
                'Edit Information',
                style: TextStyle(
                    color: Colors.pink[800],
                    fontSize: Dimensions.boxHeight*3,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            ListTile(
              onTap: (){
                isLoggedIn?
                Navigator.pushNamed(context, '/manageaddress')
                    :
                Navigator.pushNamed(context, '/login');
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
              leading: Icon(
                Icons.assignment,
                color: Colors.pink[800],
              ),
              title: Text(
                'Manage Addresses',
                style: TextStyle(
                    color: Colors.pink[800],
                    fontSize: Dimensions.boxHeight*3,
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
