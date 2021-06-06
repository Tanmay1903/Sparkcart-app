import 'package:flutter/material.dart';
import 'package:sparkcart/ApiCalls/AddressApi.dart';
import 'package:sparkcart/Components/custom_testFormField.dart';
import 'package:sparkcart/Components/getSnackbar.dart';
import 'package:sparkcart/dimensions.dart';

class AddressCard extends StatefulWidget {
  final setonAddressAdd;

  const AddressCard({Key key, this.setonAddressAdd}) : super(key: key);
  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  String address ;
  String address1,address2,state;
  String pincode;
  final TextEditingController _AddressLine1Controller = new TextEditingController();
  final TextEditingController _AddressLine2Controller = new TextEditingController();
  final TextEditingController _StateController = new TextEditingController();
  final TextEditingController _PinController = new TextEditingController();
  final FocusNode _Address2FocusNode = FocusNode();
  final FocusNode _StateFocusNode = FocusNode();
  final FocusNode _PinFocusNode = FocusNode();

  void _Address1EditingComplete(){
    FocusScope.of(context).requestFocus(_Address2FocusNode);
  }
  void _Address2EditingComplete(){
    FocusScope.of(context).requestFocus(_StateFocusNode);
  }
  void _StateEditingComplete(){
    FocusScope.of(context).requestFocus(_PinFocusNode);
  }

  void AddAddress() async {
    address1 = _AddressLine1Controller.text;
    address2 = _AddressLine2Controller.text;
    state = _StateController.text;
    pincode = _PinController.text;
    if((address1.isNotEmpty) && (address2.isNotEmpty) && (state.isNotEmpty) && (pincode.isNotEmpty)){
      address = [address1, address2, state, pincode].join(", ");
      var status = await AddAddressApi(address);
      if(status == 201){
        widget.setonAddressAdd();
      }
      else if(status == 409){
        SnackBar snackBar = getSnackBar('You have already added 4 addresses. Please delete 1 before adding another');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        widget.setonAddressAdd();
      }
    }
    else{
      SnackBar snackBar = getSnackBar('Please Fill the Empty Fields');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          CustomTextFormField(
              controller: _AddressLine1Controller,
              keyboardType: TextInputType.text,
              containerHeight: 6,
              circular: 2,
              onSaved: (String val) {
                address1 = val;
              },
              onEditingComplete: _Address1EditingComplete,
              hintText: "Address Line 1"
          ),
          CustomTextFormField(
              controller: _AddressLine2Controller,
              containerHeight: 6,
              circular: 2,
              keyboardType: TextInputType.text,
              onSaved: (String val) {
                address2 = val;
              },
              onEditingComplete: _Address2EditingComplete,
              hintText: "Address Line 2"
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextFormField(
                  controller: _StateController,
                  containerHeight: 6,
                  containerWidth: 40,
                  circular: 2,
                  keyboardType: TextInputType.text,
                  onSaved: (String val) {
                    state = val;
                  },
                  onEditingComplete: _StateEditingComplete,
                  hintText: "State"
              ),
              CustomTextFormField(
                  controller: _PinController,
                  containerHeight: 6,
                  containerWidth: 40,
                  circular: 2,
                  keyboardType: TextInputType.number,
                  onSaved: (String val) {
                    pincode = val;
                  },
                  hintText: "Pin Code"
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: AddAddress,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/25,vertical: MediaQuery.of(context).size.height/100),
                  margin: EdgeInsets.fromLTRB(0.0,10.0,10.0,0.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.pink[800],
                      borderRadius: BorderRadius.circular(Dimensions.boxHeight),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: widget.setonAddressAdd,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/50,vertical: MediaQuery.of(context).size.height/100),
                  margin: EdgeInsets.fromLTRB(0.0,10.0,10.0,0.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(Dimensions.boxHeight),
                  ),
                  child: Text(
                      'Cancel',
                    style: TextStyle(
                        color: Colors.pink[800],
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
