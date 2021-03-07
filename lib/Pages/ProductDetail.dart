import 'package:flutter/material.dart';
import 'package:sparkcart/Components/CustomDivider.dart';
import 'package:sparkcart/Components/Description.dart';
import 'package:sparkcart/Components/Specification.dart';
import 'package:sparkcart/Components/MoreInfo.dart';

class ProductDetail extends StatefulWidget {
  final Map product;
  ProductDetail({this.product});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String title = 'Description';

  Widget Detail(title){
      switch(title) {
        case 'Description':
          {
            return Description(widget.product);
          }
        case 'Specification':{
          return Specification(widget.product);
        }
        case 'More Info':{
          return MoreInfo(widget.product);
        }
        default:
          return Description(widget.product);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.mic),
                onPressed: (){},
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,0.0),
                child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.shopping_cart)
                ),
              )
            ]
        ),
        body:Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                  widget.product['product_name'],
                style: TextStyle(
                  color: Colors.pink[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0
                ),
              ),
            ),
            CustomDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: (){
                        setState((){
                          title = 'Description';
                        });
                      },
                      highlightColor: Colors.pink[100],
                      child: Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.pink[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                        ),
                      )
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: (){
                        setState((){
                          title = 'Specification';
                        });
                      },
                        highlightColor: Colors.pink[100],
                        child: Text(
                          "Specification",
                          style: TextStyle(
                              color: Colors.pink[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0
                          ),
                        )
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: (){
                        setState((){
                          title = 'More Info';
                        });
                      },
                        highlightColor: Colors.pink[100],
                        child: Text(
                          "More Info",
                          style: TextStyle(
                              color: Colors.pink[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
            CustomDivider(),
            Detail(title)
          ],
        ),
    );
  }
}




