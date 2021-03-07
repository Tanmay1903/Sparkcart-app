import 'package:flutter/material.dart';

Widget Specification(product){
  List<String> labels = [
    'Brand',
    'Model',
    'Category',
    'Price',
    'Discount'
  ];
  List<String> intlabels = [
    "Height",
    "Depth",
    "Width"
  ];
  Map data = product['Shipping_details'][0];
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
    child: Column(
      children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 20.0,bottom: 10.0),
        child: Row(
            children: <Widget>[
            Expanded(
              flex:4,
              child: Text(
                  "Name",
                   style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.pink[800],
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Expanded(
              flex:5,
             child: Text(
                "${product['product_name']}",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.pink[800],
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: labels.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.only(left: 20.0,bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex:4,
                      child: Text(
                        labels[index],
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.pink[800],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Expanded(
                      flex:5,
                      child: Text(
                        "${product[labels[index]]}",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.pink[800],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: intlabels.length,
            itemBuilder: (context, index){

              return Padding(
                padding: const EdgeInsets.only(left: 20.0,bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex:4,
                      child: Text(
                        intlabels[index],
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.pink[800],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Expanded(
                      flex:5,
                      child: Text(
                        "${data[intlabels[index]]} mm",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.pink[800],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0,bottom: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex:4,
                child: Text(
                  "Weight",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.pink[800],
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Expanded(
                flex:5,
                child: Text(
                  "${data['Weight']} g",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.pink[800],
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}