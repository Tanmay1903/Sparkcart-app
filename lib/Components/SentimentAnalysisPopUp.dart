import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparkcart/dimensions.dart';
import '../ApiCalls/sentiment.dart';

Widget LoadedPopUp(context,data){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.pink[800],
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(color: Colors.pink[900],offset: Offset(0,10),
                  blurRadius: 10
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                highlightColor: Colors.pink[800],
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.pink[50],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Text(
                "Sentiment Analysis",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(height: Dimensions.boxHeight*2),
      Container(
          padding: EdgeInsets.all(15.0),
          height: Dimensions.boxHeight*30,
          width: Dimensions.boxWidth*100,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(color: Colors.pink[900],offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: Dimensions.boxHeight*10,
                width: Dimensions.boxWidth*30,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Image.asset("assets/amazon.png")
                ),
              ),
              Text(
                "Name : ${data.amaz_name.split('-')[0]}",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800]
                ),
              ),
              SizedBox(height: Dimensions.boxHeight*1),
              Text(
                "Price : Rs. ${data.amaz_price.substring(3)}",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800]
                ),
              ),
              SizedBox(height: Dimensions.boxHeight*1),
              RichText(
                text: TextSpan(
                  text: 'The Product is liked by ',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[800]
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '${data.amaz_perc.round()} %', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                    TextSpan(text: ' of the Users'),
                  ],
                ),
              )
            ],
          )
      ),
      SizedBox(height: Dimensions.boxHeight*3),
      Container(
          padding: EdgeInsets.all(10.0),
          height: Dimensions.boxHeight*30,
          width: Dimensions.boxWidth*100,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(color: Colors.pink[900],offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: Dimensions.boxHeight*10,
                width: Dimensions.boxWidth*30,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Image.asset("assets/flipkart.png")
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Name : ${data.flip_name.split('-')[0]}",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800]
                ),
              ),
              SizedBox(height: Dimensions.boxHeight*1),
              Text(
                "Price : Rs. ${data.flip_price.substring(3)}",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800]
                ),
              ),
              SizedBox(height: Dimensions.boxHeight*1),
              RichText(
                text: TextSpan(
                  text: 'The Product is liked by ',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[800]
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '${data.flip_perc.round()} %', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                    TextSpan(text: ' of the Users'),
                  ],
                ),
              )
            ],
          )
      ),
      SizedBox(height: Dimensions.boxHeight*2),
      Container(
        width: Dimensions.boxWidth*100,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.pink[800],
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
            BoxShadow(color: Colors.pink[900],offset: Offset(0,10),
            blurRadius: 10
            ),
          ]
        ),
        child: Text(
          "Algorithm Accuracy :- ${((data.amaz_acc)*100).round().toDouble()} %",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      )
    ],
  );
}

Widget SentimentAnalysisPopUp(BuildContext context,int id) {
  getAnalysis(id);
  sentiment data = getSentiment();
  return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: LoadedPopUp(context,data)
  );
}