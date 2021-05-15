import 'package:flutter/material.dart';
import 'package:sparkcart/Components/getSnackbar.dart';
import 'package:sparkcart/Pages/ProfilePage.dart';
import 'package:sparkcart/main.dart';
import '../dimensions.dart';
import '../Components/custom_testFormField.dart';
import '../ApiCalls/registerapi.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>(); // for form validation

  final TextEditingController _FirstnameController = new TextEditingController();
  final TextEditingController _LastnameController = new TextEditingController();
  final TextEditingController _EmailController = new TextEditingController();
  final TextEditingController _UsernameController = new TextEditingController();
  final TextEditingController _PasswordController = new TextEditingController();
  final TextEditingController _ConfirmPasswordController = new TextEditingController();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _eMailFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _condition = true;

  String message;
  String fname, email, lname, pass, username;

  String validatefName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      SnackBar snackBar = getSnackBar("Name is Required");
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return null;
    } else if (!regExp.hasMatch(value)) {
      SnackBar snackBar = getSnackBar("Name must be a-z and A-Z");
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return null;
    }
    return null;
  }

  String validatelName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      SnackBar snackBar = getSnackBar("Name is Required");
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return null;
    } else if (!regExp.hasMatch(value)) {
      SnackBar snackBar = getSnackBar("Name must be a-z and A-Z");
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return null;
    }
    return null;
  }

  String validatelUsername(String value) {
    String patttern = r'(^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      SnackBar snackBar = getSnackBar("Username is Required");
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return null;
    } else if (!regExp.hasMatch(value)) {
      SnackBar snackBar = getSnackBar("Username must be a-z and A-Z or 0-9");
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return null;
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      SnackBar snackBar = getSnackBar("Email is Required");
      // ignore: deprecated_member_use
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return null;
    } else if (!regExp.hasMatch(value)) {
      SnackBar snackBar = getSnackBar("Invalid Email");
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return null;
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      SnackBar snackBar = getSnackBar("Password is required");
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return null;
    } else {
      return null;
    }
  }

  void _register()async{

    try{
      setState(() {
        _condition = false;
      });
      if (_form.currentState.validate()) {
        final String first_name = _FirstnameController.text;
        final String last_name = _LastnameController.text;
        final String email = _EmailController.text;
        final String password =
            _ConfirmPasswordController.text;
        final String username = _UsernameController.text;

        var res = await registeruser(
            first_name, last_name, username, email, password);
        print(res);
        if (res == "Please confirm your email address to complete the registration") {
          SnackBar snackbar = getSnackBar("Please confirm your email address to complete the registration");
          // ignore: deprecated_member_use
          _scaffoldKey.currentState.showSnackBar(snackbar);

          Future.delayed(Duration(seconds: 3), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Loading()));
          });
        }
        else if (res == "This Email is already registered.Please login to your aacount.") {
          SnackBar snackbar = getSnackBar("This Email is already registered.Please login to your account.");
          _scaffoldKey.currentState.showSnackBar(snackbar);
        } else if (res == "Username is already taken!!") {
          SnackBar snackbar = getSnackBar("Username is already taken!!");
          _scaffoldKey.currentState.showSnackBar(snackbar);
        }
        print("register pressed");
      }
    }
    catch(e){
      print("Register Error $e");
    }finally{
      setState(() {
        _condition = true;
      });
    }

  }

  void _fNameEditingComplete(){
    FocusScope.of(context).requestFocus(_lastNameFocusNode);
  }
  void _lNameEditingComplete(){
    FocusScope.of(context).requestFocus(_eMailFocusNode);
  }
  void _emailEditingComplete(){
    FocusScope.of(context).requestFocus(_userNameFocusNode);
  }
  void _userNameEditingComplete(){
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }
  void _passwordEditingComplete(){
    FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(
            letterSpacing: 2
          ),
        ),
      ),
      body: Container(
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: Dimensions.boxHeight*4),
                Center(
                  child: Text(
                    'Account Register',
                    style: TextStyle(
                        color: Colors.pink[800],
                        fontSize: Dimensions.boxHeight*4.5,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.boxHeight*3),
                CustomTextFormField(
                  controller: _FirstnameController,
                  onSaved: (String val) {
                    fname = val;
                  },
                  onEditingComplete: _fNameEditingComplete,

                  validator: validatefName,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.pink[800],
                  ),
                  hintText: 'First name',
                ),
                CustomTextFormField(
                  controller: _LastnameController,
                  onSaved: (String val) {
                    lname = val;
                  },
                  focusNode: _lastNameFocusNode,
                  onEditingComplete: _lNameEditingComplete,
                  validator: validatelName,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(Icons.supervised_user_circle,
                      color: Colors.pink[800]
                  ),
                  hintText: 'Last name',
                ),
                CustomTextFormField(
                  controller: _EmailController,
                  onSaved: (String val) {
                    email = val;
                  },
                  focusNode: _eMailFocusNode,
                  onEditingComplete: _emailEditingComplete,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email, color: Colors.pink[800]),
                  hintText: 'E-mail',
                ),
                CustomTextFormField(
                  controller: _UsernameController,
                  onSaved: (String val) {
                    username = val;
                  },
                  focusNode: _userNameFocusNode,
                  onEditingComplete: _userNameEditingComplete,
                  validator: validatelUsername,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(Icons.supervised_user_circle,
                      color: Colors.pink[800]),
                  hintText: 'Username',
                ),
                CustomTextFormField(
                  controller: _PasswordController,
                  onSaved: (String val) {
                    pass = val;
                  },
                  focusNode: _passwordFocusNode,
                  onEditingComplete: _passwordEditingComplete,
                  validator: validatePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon:
                  Icon(Icons.account_circle, color: Colors.pink[800]),
                  hintText: 'Password',
                  obscureText: true,
                ),
                CustomTextFormField(
                  controller: _ConfirmPasswordController,
                  onSaved: (String val) {
                    pass = val;
                  },
                  focusNode: _confirmPasswordFocusNode,
                  onEditingComplete: (){
                    FocusScope.of(context).requestFocus(new FocusNode());
                    //_register();
                  },
                  obscureText: true,

                  validator: (val) {
                    if (val.isEmpty) return 'Please re-try your password';
                    if (val != _PasswordController.text)
                      return 'Password Not Match';
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon:
                  Icon(Icons.account_circle, color: Colors.pink[800]),
                  hintText: 'Confirm Password',
                ),
                SizedBox(
                  height: Dimensions.boxHeight * 2.5,
                ),
                FloatingActionButton.extended(
                  elevation: 7.0,
                  isExtended: true,
                  backgroundColor: Colors.pink[800],
                  onPressed: (){
                    _register();
                  },
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: Dimensions.boxHeight*3,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.boxHeight * 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
