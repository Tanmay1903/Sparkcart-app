library sweetalert;

import 'package:flutter/material.dart';
import '../dimensions.dart';
import '../constants.dart';

import 'success.dart';
import 'cancel.dart';
import 'confirm.dart';

typedef bool SweetAlertOnPress(bool isConfirm);

enum SweetAlertStyle { success, error, confirm, loading }

class SweetAlertOptions {
  final String title;
  final String subtitle;


  final SweetAlertOnPress onPress;

  /// if null,
  /// default value is `SweetAlert.success` when `showCancelButton`=false
  /// and `SweetAlert.danger` when `showCancelButton` = true
  final Color confirmButtonColor;

  /// if null,default value is `SweetAlert.cancel`
  final Color cancelButtonColor;

  /// if null,default value is `SweetAlert.successText` when `showCancelButton`=false
  ///  and `SweetAlert.dangerText` when `showCancelButton` = true
  final String confirmButtonText;

  /// if null,default value is `SweetAlert.cancelText`
  final String cancelButtonText;

  /// If set to true, two buttons will be displayed.
  final bool showCancelButton;

  final SweetAlertStyle style;

  SweetAlertOptions({
    this.showCancelButton: false,
    this.title,
    this.subtitle,
    this.onPress,
    this.cancelButtonColor,
    this.cancelButtonText,
    this.confirmButtonColor,
    this.confirmButtonText,
    this.style,

  });
}

class SweetAlertDialog extends StatefulWidget {
  /// animation curve when showing,if null,default value is `SweetAlert.showCurve`
  final Curve curve;

  final SweetAlertOptions options;

  SweetAlertDialog({
    this.options,
    this.curve,
  }) : assert(options != null);

  @override
  State<StatefulWidget> createState() {
    return SweetAlertDialogState();
  }
}

class SweetAlertDialogState extends State<SweetAlertDialog>
    with SingleTickerProviderStateMixin, SweetAlert {
  AnimationController controller;

  Animation tween;

  SweetAlertOptions _options;

  @override
  void initState() {
    _options = widget.options;
    controller = new AnimationController(vsync: this);
    tween = new Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.animateTo(1.0,
        duration: new Duration(milliseconds: 300),
        curve: widget.curve ?? SweetAlert.showCurve);

    SweetAlert._state = this;

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();

    SweetAlert._state = null;
    super.dispose();
  }

  @override
  void didUpdateWidget(SweetAlertDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void showSnackbar(String message){
    final snackbar = SnackBar(
        content: Text(
            message,
          style: TextStyle(
              color: Colors.white,
              fontSize: Dimensions.boxHeight*2,
              fontWeight: FontWeight.bold,
              letterSpacing: 2
        )
        ),
      backgroundColor: Colors.pink[800],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void confirm() {
    if (_options.onPress != null && _options.onPress(true) == false) return;
    showSnackbar('Logout Successfully');
    Navigator.pop(context);

  }

  void cancel() {
    if (_options.onPress != null && _options.onPress(false) == false) return;
    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> listOfChildren = [];

    switch (_options.style) {
      case SweetAlertStyle.success:
        listOfChildren.add(Column(children: <Widget>[
          SizedBox(
            height: Dimensions.boxHeight * 2,
          ),
          SizedBox(
            width: Dimensions.boxWidth*16,
            height: Dimensions.boxHeight*11,
            child: SuccessView(),
          ),
          SizedBox(
            height: Dimensions.boxHeight * 2,
          )
        ]));
        break;
      case SweetAlertStyle.confirm:
        listOfChildren.add(Column(children: <Widget>[
          SizedBox(
            height: Dimensions.boxHeight * 2,
          ),
          SizedBox(
            width: Dimensions.boxWidth*16,
            height: Dimensions.boxHeight*11,
            child: ConfirmView(),
          ),
          SizedBox(
            height: Dimensions.boxHeight * 2,
          )
        ]));
        break;
      case SweetAlertStyle.error:
        listOfChildren.add(new SizedBox(
          width: Dimensions.boxWidth*16,
          height: Dimensions.boxHeight*11,
          child: new CancelView(),
        ));
        break;
      case SweetAlertStyle.loading:
        listOfChildren.add(new SizedBox(
          width: Dimensions.boxWidth*16,
          height: Dimensions.boxHeight*11,
          child: new Center(
            child: new CircularProgressIndicator(),
          ),
        ));
        break;

    }

    if (_options.title != null) {
      listOfChildren.add(new Text(
        _options.title,

        style: TextStyle(
            fontSize: Dimensions.boxHeight*3.5,
          color: Colors.pink[800],
          fontWeight: FontWeight.bold
        ),
      ));
    }

//    if (_options.subtitle != '') {
//      listOfChildren.add(new Padding(
//        padding: new EdgeInsets.only(top: 10.0),
//        child: new Text(
//          _options.subtitle,
//          style: new TextStyle(fontSize: 16.0, color: new Color(0xff797979)),
//        ),
//      ));
//    }

    //we do not render buttons when style=loading
    if (_options.style != SweetAlertStyle.loading) {
      if (_options.showCancelButton ) {
        listOfChildren.add(new Padding(
          padding: new EdgeInsets.symmetric(vertical: Dimensions.boxHeight),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             new RaisedButton(
                onPressed: cancel,
                color: _options.cancelButtonColor ?? SweetAlert.cancel,
                child: new Text(
                  _options.cancelButtonText ?? SweetAlert.cancelText,
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.boxHeight * 2.3,
                    fontWeight: FontWeight.values[8]
                  ),
                ),
              ) ,
              new SizedBox(
                width: 10.0,
              ),
              new RaisedButton(
                onPressed: confirm,
                color: _options.confirmButtonColor ?? SweetAlert.danger,
                child: new Text(
                  _options.confirmButtonText ?? SweetAlert.confirmText,
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.boxHeight * 2.3,
                    fontWeight: FontWeight.values[8]
                  ),
                ),
              ),
            ],
          ),
        ));
      }

      else {
        listOfChildren.add(new Padding(
          padding: new EdgeInsets.only(top: 10.0),
          child: new RaisedButton(
            onPressed: confirm,
            color: _options.confirmButtonColor ?? SweetAlert.success,
            child: new Text(
              _options.confirmButtonText ?? SweetAlert.successText,
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.boxHeight * 2,
                  ),
            ),
          ),
        ));
      }
    }


    return new Center(
        child: new AnimatedBuilder(
            animation: controller,
            builder: (c, w) {
              return new ScaleTransition(
                scale: tween,
                child: new ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.boxHeight * 2)),
                  child: new Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: new Padding(
                        padding: new EdgeInsets.symmetric(
                            vertical: Dimensions.boxHeight * 3),
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: listOfChildren,
                        ),
                      )),
                ),
              );
            }));
  }

  void update(SweetAlertOptions options) {
    setState(() {
      _options = options;
    });
  }
}

class SweetAlert {
  static Color success = new Color(kdark);
  static Color danger = new Color(kdark);
  static Color cancel = new Color(kdark);

  static String successText = "OK";
  static String confirmText = "Confirm";
  static String cancelText = "Cancel";

  static Curve showCurve = Curves.bounceOut;

  static SweetAlertDialogState _state;

  static void show(BuildContext context,
      {Curve curve,
      String title,
      String subtitle,
      bool showCancelButton: false,
      SweetAlertOnPress onPress,
      Color cancelButtonColor,
      Color confirmButtonColor,
      String cancelButtonText,
      String confirmButtonText,
      SweetAlertStyle style,
      }) {
    SweetAlertOptions options = new SweetAlertOptions(
        showCancelButton: showCancelButton,
        title: title,
        subtitle: subtitle,
        style: style,
        onPress: onPress,
        confirmButtonColor: confirmButtonColor,
        confirmButtonText: confirmButtonText,
        cancelButtonText: cancelButtonText,
        cancelButtonColor: confirmButtonColor,
        );
    if (_state != null) {
      _state.update(options);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new Container(
              color: Colors.transparent,
              child: new Padding(
                padding: new EdgeInsets.symmetric(horizontal: 60.0,vertical: 160.0),
                child: new Scaffold(
                  backgroundColor: Colors.transparent,
                  body: new SweetAlertDialog(curve: curve, options: options),
                ),
              ),
            );
          });
//
    }
  }
}
