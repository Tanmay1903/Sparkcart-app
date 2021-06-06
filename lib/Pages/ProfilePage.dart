import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkcart/Components/CustomDivider.dart';
import 'package:sparkcart/Components/getSnackbar.dart';
import 'package:sparkcart/dimensions.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoggedIn = false;
  String FirstName = '';
  String LastName = '';
  String UserName = '';
  String Email = '';
  List fields = [
    'FirstName',
    'LastName',
    'UserName',
    'Email'
  ];
  Map fields_variable ={};

  check_user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLogin') != null ? prefs.getBool('isLogin') : false ;
      FirstName = prefs.getString('first_name');
      LastName = prefs.getString('last_name');
      UserName = prefs.getString('username');
      Email = prefs.getString('email');
      fields_variable = {
        'FirstName': FirstName,
        'LastName' : LastName,
        'UserName' : UserName,
        'Email' : Email
      };
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.boxHeight*6),
          Row(
            children: [
              SizedBox(width: Dimensions.boxWidth*4),
              FloatingActionButton(
                elevation: 15.0,
                  child: Icon(
                      Icons.home,
                    color: Colors.pink[800],
                    size: Dimensions.boxHeight*5,
                  ),
                  onPressed: (){
                  Navigator.pushReplacementNamed(context, '/');
                  } ),
            ],
          ),
          Center(
            child: CircleAvatar(
              radius: Dimensions.boxWidth*15,
              backgroundColor: Colors.pink[800],
              child: Text(
                "${FirstName != ""?FirstName[0]:""}${LastName != "" ? LastName[0]: ""}",
                style: TextStyle(
                    color: Colors.pink[50],
                    fontSize: Dimensions.boxHeight*6.5,
                    fontWeight: FontWeight.values[8]
                ),
              ),
            ),
          ),

          SizedBox(height: Dimensions.boxHeight*2.5),
          CustomDivider(),
          ListView.builder(
            scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: fields.length,
              itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.only(bottom: Dimensions.boxHeight*2,right: Dimensions.boxWidth*3),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.boxWidth*7,),
                    Expanded(
                      flex: 2,
                      child: Text(
                          "${fields[index]} : ",
                          style: TextStyle(
                              fontSize: Dimensions.boxHeight*3,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[800]
                          )
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "${fields_variable[fields[index]] !=""? fields_variable[fields[index]] : ""}",
                        style: TextStyle(
                            fontSize: Dimensions.boxHeight*3,
                            //fontWeight: FontWeight.bold,
                            color: Colors.pink[900]
                        ),
                      ),
                    )
                  ],
                ),
              );
              }),
          CustomDivider(),
          InkWell(
            onTap: (){
              isLoggedIn?
              Navigator.pushNamed(context, '/myorders')
                  :
              Navigator.pushNamed(context, '/login');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.boxHeight*2,horizontal: Dimensions.boxWidth*7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Orders',
                      style: TextStyle(
                          fontSize: Dimensions.boxHeight*3,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[800]
                      )
                  ),
                  Text(
                    '>',
                      style: TextStyle(
                          fontSize: Dimensions.boxHeight*3,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[800]
                      )
                  )
                ],
              ),
            ),
          ),
          CustomDivider(),
          InkWell(
            onTap: (){
              SnackBar snackBar = getSnackBar("Coming soon");
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.boxHeight*2,horizontal: Dimensions.boxWidth*7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Add Additional Information',
                      style: TextStyle(
                          fontSize: Dimensions.boxHeight*3,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[800]
                      )
                  ),
                  Text(
                      '>',
                      style: TextStyle(
                          fontSize: Dimensions.boxHeight*3,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[800]
                      )
                  )
                ],
              ),
            ),
          ),
          CustomDivider()
        ],
      ),
    );
  }
}
