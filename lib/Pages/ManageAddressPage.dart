import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkcart/ApiCalls/AddressApi.dart';
import 'package:sparkcart/Components/AddressCard.dart';
import 'package:sparkcart/Components/getSnackbar.dart';
import 'package:sparkcart/dimensions.dart';

class ManageAddressesPage extends StatefulWidget {
  @override
  _ManageAddressesPageState createState() => _ManageAddressesPageState();
}

class _ManageAddressesPageState extends State<ManageAddressesPage> {
  bool isAddAddress = false;
  Map address = {};
  String selectedAddress;
  setAddress(Map temp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = temp;
      if(((selectedAddress == null) && (!address.containsKey('message'))) || ((selectedAddress == "") && (!address.containsKey('message')))) {
        var key = address.keys.first;
        selectedAddress = address[key];
        prefs.setString("address", selectedAddress);
      }
      else if(address.containsKey('message')){
        SnackBar snackBar = getSnackBar(address['message']);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  check_user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedAddress = prefs.getString('address');
    await getAddresses(setAddress);
  }
  setOnAddressAdd(){
    check_user();
    setState(() {
      isAddAddress = false;
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
          'Manage Addresses'
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Dimensions.boxHeight*2),
            Text(
                "Select an Address",
              style: TextStyle(
                color: Colors.pink[800],
                fontSize: Dimensions.boxHeight*3,
                fontWeight: FontWeight.bold
              ),
            ),
            address.isNotEmpty?
            Column(
              children: address.keys.map((key){
                return Container(
                  width: Dimensions.boxWidth*100,
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/25,vertical: MediaQuery.of(context).size.height/50),
                  margin: EdgeInsets.fromLTRB(12.0,12.0,12.0,0.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(Dimensions.boxHeight * 2),
                      boxShadow: [
                        BoxShadow(color: Colors.pink[900],offset: Offset(0,3),
                            blurRadius: 5
                        ),
                      ]
                  ),
                  child: Row(
                    children: [
                      Radio(
                        value: address[key],
                        groupValue: selectedAddress,
                        activeColor: Colors.pink[800],
                        onChanged: (val) async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('address', val);
                          setState(() {
                            selectedAddress = val;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          address[key],
                          style: TextStyle(
                              color: Colors.pink[900],
                              letterSpacing: 2
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          SnackBar snackBar = getSnackBar("Coming soon");
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.pink[800],
                          size: Dimensions.boxHeight*3,
                        ),
                      ),
                      SizedBox(width: Dimensions.boxWidth*2),
                      InkWell(
                        onTap: () async {
                          if(address[key] == selectedAddress){
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("address", "");
                          }
                          var status = await DeleteAddress(address[key]);
                          SnackBar snackbar;
                          if (status == 200){
                            check_user();
                            setState(() {
                              address.remove(key);
                            });
                          }
                          else if(status == 404){
                            snackbar = getSnackBar('Address Already Deleted');
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                          else{
                            snackbar = getSnackBar('Some Other error from Backend');
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.pink[800],
                          size: Dimensions.boxHeight*3,
                        ),
                      ),
                      SizedBox(width: Dimensions.boxWidth*2),
                    ],
                  ),
                );
              }).toList()
            ):
                Container(
                  width: Dimensions.boxWidth*100,
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/25,vertical: MediaQuery.of(context).size.height/50),
                  margin: EdgeInsets.fromLTRB(12.0,12.0,12.0,0.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(Dimensions.boxHeight * 2),
                      boxShadow: [
                        BoxShadow(color: Colors.pink[900],offset: Offset(0,3),
                            blurRadius: 5
                        ),
                      ]
                  ),
                  child: Text(
                    "No Addresses added yet!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.pink[800],
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.boxHeight*2.5
                    ),
                  ),
                ),
            isAddAddress?
                Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/25,vertical: MediaQuery.of(context).size.height/50),
                  margin: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(Dimensions.boxHeight * 2),
                      boxShadow: [
                        BoxShadow(color: Colors.pink[900],offset: Offset(0,3),
                            blurRadius: 10
                        ),
                      ]
                  ),
                  child: AddressCard(setonAddressAdd: setOnAddressAdd),
                )
                : Container()
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: (){
          setState(() {
            isAddAddress = true;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/25,vertical: MediaQuery.of(context).size.height/50),
          margin: EdgeInsets.all(12.0),
          width: Dimensions.boxWidth*90,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.pink[800],
            borderRadius: BorderRadius.circular(Dimensions.boxHeight),
          ),
          child: Text(
            "Add an Address",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              fontSize: Dimensions.boxHeight*2.5
            ),
          ),
        ),
      ),
    );
  }
}
