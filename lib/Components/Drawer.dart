import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkcart/Pages/HelpPage.dart';
import 'package:sparkcart/Pages/SettingsPage.dart';
import 'package:sparkcart/Pages/WishlistPage.dart';
import 'package:sparkcart/dimensions.dart';
import '../Components/sweetalert.dart';
import '../ApiCalls/logoutapi.dart';

class CustomDrawer extends StatefulWidget {

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final _storage = FlutterSecureStorage();
  bool isLoggedIn = false;
  String FirstName = '';
  String LastName = '';
  check_user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLogin') != null ? prefs.getBool('isLogin') : false ;
      FirstName = prefs.getString('first_name');
      LastName = prefs.getString('last_name');
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
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: Dimensions.boxHeight*22,
            child: DrawerHeader(
              padding: EdgeInsets.only(top:10.0),
                child: isLoggedIn ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: Dimensions.boxWidth*10,
                        backgroundColor: Colors.pink[50],
                        child: Text(
                          "${FirstName[0]}${LastName[0]}",
                          style: TextStyle(
                            color: Colors.pink[800],
                            fontSize: Dimensions.boxHeight*6.5,
                            fontWeight: FontWeight.values[8]
                          ),
                        ),
                      ),
                      Text(
                        "Hi, ${FirstName} ${LastName}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.boxHeight * 3,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                    :
                Center(
                  child: Text(
                        "Welcome To Sparkcart! \n Log In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.boxHeight*3,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                ),
              decoration: BoxDecoration(
                color: Colors.pink[800],
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0),bottomRight: Radius.circular(25.0))
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
            onTap: () => {
              isLoggedIn? {
                Navigator.of(context).pop(),
                Navigator.pushNamed(context, '/profile')
              }
                  : {
                Navigator.of(context).pop(),
                Navigator.pushNamed(context, '/login')
              }
            },
            leading: Icon(
                Icons.person,
              color: Colors.pink[800],
            ),
            title: Text(
              'My Account',
              style: TextStyle(
                  color: Colors.pink[800],
                  fontSize: Dimensions.boxHeight*2.5,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            onTap: (){
              isLoggedIn?
                  Navigator.pushNamed(context, '/myorders')
                  :
              Navigator.pushNamed(context, '/login');
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
            leading: Icon(
              Icons.dashboard,
              color: Colors.pink[800],
            ),
            title: Text(
              'My Orders',
              style: TextStyle(
                  color: Colors.pink[800],
                  fontSize: Dimensions.boxHeight*2.5,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            onTap: (){
              isLoggedIn?
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => WishlistPage()))
                  :
              Navigator.pushNamed(context, '/login');
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
            leading: Icon(
              Icons.favorite,
              color: Colors.pink[800],
            ),
            title: Text(
              'Wishlist',
              style: TextStyle(
                  color: Colors.pink[800],
                  fontSize: Dimensions.boxHeight*2.5,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage())
              );
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
            leading: Icon(
              Icons.settings,
              color: Colors.pink[800],
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                  color: Colors.pink[800],
                  fontSize: Dimensions.boxHeight*2.5,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
            leading: Icon(
              Icons.help,
              color: Colors.pink[800],
            ),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HelpPage())
              );
            },
            title: Text(
              'Help',
              style: TextStyle(
                  color: Colors.pink[800],
                  fontSize: Dimensions.boxHeight*2.5,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          isLoggedIn?
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
            leading: Icon(
              Icons.logout,
              color: Colors.pink[800],
            ),
            onTap: showLogOutDialog,
            title: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.pink[800],
                  fontSize: Dimensions.boxHeight*2.5,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
              :
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
              onTap: () => {
                Navigator.pushNamed(context, '/login')
              },
              leading: Icon(
                Icons.login,
                color: Colors.pink[800],
              ),
              title: Text(
                'Login',
                style: TextStyle(
                    color: Colors.pink[800],
                    fontSize: Dimensions.boxHeight * 2.5,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
        ],
      ),
    );
  }
  void showLogOutDialog() {
    Navigator.of(context).pop();

    SweetAlert.show(context,
      title: "Confirm Log Out?",
      subtitle: " ",
      style: SweetAlertStyle.confirm,
      confirmButtonText: 'LOGOUT',
      cancelButtonText: 'CANCEL',
      showCancelButton: true,
      onPress: (bool isConfirm){
        if(isConfirm){
          loggingout();

        }
        return true;
      },
    );
  }

  void showSnackbar(String message){
    final snackbar = SnackBar(
        content: Text(
          message
        )
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  Future loggingout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool("isLogin") == true) {
        String res = await logout();
        if (res == '{"message":"You have been successfully logged out"}') {
          prefs.setBool("isLogin", false);
          prefs.setString("username", "");
          prefs.setString("first_name", null);
          prefs.setString("last_name", null);
          //prefs.setString("address", null);
          final all = await _storage.deleteAll();
          showSnackbar('Logout Successfully');
        }  else {
          prefs.setBool("isLogin", false);
          final all = await _storage.deleteAll();
          print("some other error from backend");
        }
      }
    } catch (e) {
      print(" ERROR in loggout : $e");
    }
  }
}

