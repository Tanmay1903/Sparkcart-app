import 'package:flutter/material.dart';

import '../dimensions.dart';
import '../constants.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final String Function(String) validator;
  final String Function(String) onSaved;
  final TextInputType keyboardType;
  final Widget prefixIcon;
  final String hintText;
  final Function onEditingComplete;
  final FocusNode focusNode;
  final bool obscureText;
  final double containerHeight;
  final int maxLines;
  final TextInputAction textInputAction;


  CustomTextFormField({
    @required this.controller,
    this.validator,
    this.onSaved,
    @required this.keyboardType,
    this.prefixIcon,
    @required this.hintText,
    this.onEditingComplete,
    this.focusNode,
    this.obscureText:false,
    this.containerHeight: 9,
    this.maxLines: 1,
    this.textInputAction:TextInputAction.next,

  });
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.boxWidth * 5,
            vertical: Dimensions.boxWidth *2),
        child: Container(
          height: Dimensions.boxHeight *containerHeight,
          width: Dimensions.boxWidth * 90,
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(Dimensions.boxHeight * 5),
            color: Colors.pink[100],
          ),

            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.boxHeight ,
                  horizontal: Dimensions.boxWidth * 4),
              child: Center(
                child: TextFormField(
                  maxLines: maxLines,
                  cursorColor: Colors.pink[800],
                  cursorWidth: Dimensions.boxHeight * 0.2,
                  controller: controller,
                  validator: validator,
                  onSaved: onSaved,
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  textInputAction: textInputAction,
                  autocorrect: true,
                  textAlign: TextAlign.start,
                    onEditingComplete: onEditingComplete,
                    focusNode: focusNode,
                  style: TextStyle(
                      fontSize: Dimensions.boxHeight * 2.5,
                      letterSpacing: 2,
                      color: Colors.pink[800],
                      ),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontSize: Dimensions.boxHeight*1.5,
                      height: Dimensions.boxWidth,),
                    border: InputBorder.none,
                    prefixIcon: prefixIcon,
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontSize: Dimensions.boxHeight * 2,
                      letterSpacing: 2,
                      color: Colors.pink[800],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
