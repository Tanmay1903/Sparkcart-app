import 'package:flutter/material.dart';
import 'package:sparkcart/Pages/Homepage.dart';
import 'package:sparkcart/dimensions.dart';
import 'package:sparkcart/main.dart';
import '../Components/custom_testFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiCalls/loginapi.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, pass;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _EmailController = new TextEditingController();
  final TextEditingController _PassController = new TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _condition = true;
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Password is Required";
    }
  }
  void _emailEditingComplete(){
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _login() async {
    try{
      setState(() {
        _condition = false;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
        final String email = _EmailController.text;
        final String password = _PassController.text;

        var res = await loginusers(email, password);
        if (res == 1) {
          prefs.setBool("isLogin", false);
          SnackBar snackbar2 = SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "Invalid login details",
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  color: Colors.white,
                  ),
            ),
            backgroundColor: Colors.pink[800],
          );
          scaffoldKey.currentState.showSnackBar(snackbar2);
        } else if (res == 2) {
          prefs.setBool("isLogin", false);
          SnackBar snackbar9 = SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "User does not exist",
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  color: Colors.white,
                  ),
            ),
            backgroundColor: Colors.pink[800],
          );
          scaffoldKey.currentState.showSnackBar(snackbar9);
        } else if (res == 3) {
          prefs.setBool("isLogin", false);
          SnackBar snackbar9 = SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "Please click on the verification link \nsent to you on your registered email",
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  color: Colors.white,
                  ),
            ),
            backgroundColor: Colors.pink[800],
          );
          scaffoldKey.currentState.showSnackBar(snackbar9);
        } else {
          prefs.setBool("isLogin", true);
          prefs.setString('username', res['username']);
          prefs.setString('first_name', res['first_name']);
          prefs.setString('last_name', res['last_name']);
          prefs.setString('email', res['email']);
          SnackBar snackbar1 = SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "Login Successful",
              style: TextStyle(
                  fontSize: Dimensions.boxHeight*2.5,
                  letterSpacing: 2,
                  color: Colors.white,
                fontWeight: FontWeight.bold
                  ),
            ),
            backgroundColor: Colors.pink[800],
          );
          scaffoldKey.currentState.showSnackBar(snackbar1);
          if (prefs.getBool("isLogin") == true) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Loading()));
            });
          }
        }
    }catch(e){

    }finally{
      setState(() {
        _condition = true;
      });
    }
  }

      @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Text('Sparkcart',
          textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: Dimensions.boxHeight*5),
            Center(
              child: Text(
                  'Account Login',
                style: TextStyle(
                  color: Colors.pink[800],
                  fontSize: Dimensions.boxHeight*5,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: Dimensions.boxHeight*6),
            CustomTextFormField(
              controller: _EmailController,
              validator: validateEmail,

              onSaved: (String val) {
                email = val;
              },
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.pink[800],
              ),
              hintText: 'E-mail',
              onEditingComplete: _emailEditingComplete,
            ),
            SizedBox(height: Dimensions.boxHeight*2),
            CustomTextFormField(
              controller: _PassController,
              validator: validatePassword,
              onSaved: (String val) {
                pass = val;
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.pink[800],
              ),
              hintText: 'Password',
              onEditingComplete: (){
                FocusScope.of(context).requestFocus(new FocusNode());
                _login();
              },
              focusNode: _passwordFocusNode,
            ),
            SizedBox(
              height: Dimensions.boxHeight * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontSize: Dimensions.boxHeight * 2.4,
                        letterSpacing: 2,
                        color: Colors.pink[800],
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: Dimensions.boxHeight * 2.4,
                        letterSpacing: 2,
                        color: Colors.pink[800],
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.boxHeight*3,),
            FlatButton(
              color: Colors.pink[50],
                child: Container(
                  width: Dimensions.boxWidth*50,
                  height: Dimensions.boxHeight*7,
                  decoration: BoxDecoration(
                    color: Colors.pink[800],
                    borderRadius: BorderRadius.circular(Dimensions.boxHeight * 5)
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.boxHeight*3,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                onPressed: _condition?(){_login();}:null,
                )
          ],
        ),
      ),
    );
  }
}