import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparkcart/dimensions.dart';

class SentimentAnalysis extends StatefulWidget {
  @override
  _SentimentAnalysisState createState() => _SentimentAnalysisState();
}

class _SentimentAnalysisState extends State<SentimentAnalysis> {
  Map sentiment;
  Widget CardData(s,site){
    if(s[site].containsKey('message')){
      return Text(
        s[site]['message'],
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink[800]
        ),
      );
    }
    else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Name : ${sentiment[site]['Name'].split('-')[0]}",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.pink[800]
            ),
          ),
          SizedBox(height: Dimensions.boxHeight*1),
          Text(
            "Price : Rs. ${sentiment[site]['Price'].substring(3)}",
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
                TextSpan(text: '${sentiment[site]['Percentage'].round()} %', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                TextSpan(text: ' of the Users'),
              ],
            ),
          )
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    sentiment = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Text(
            'Sentiment Analysis'
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: Dimensions.boxHeight*2),
            Container(
                padding: EdgeInsets.all(15.0),
                height: Dimensions.boxHeight*35,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: Dimensions.boxHeight*10,
                      width: Dimensions.boxWidth*30,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: Image.asset("assets/amazon.png")
                      ),
                    ),
                    CardData(sentiment, 'Amazon')
                  ],
                )
            ),
            SizedBox(height: Dimensions.boxHeight*3),
            Container(
                padding: EdgeInsets.all(10.0),
                height: Dimensions.boxHeight*35,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: Dimensions.boxHeight*10,
                      width: Dimensions.boxWidth*30,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: Image.asset("assets/flipkart.png")
                      ),
                    ),
                    SizedBox(height: Dimensions.boxHeight*1.5),
                    CardData(sentiment, 'Flipkart')
                  ],
                )
            ),
            SizedBox(height: Dimensions.boxHeight*3),
            Container(
              height: Dimensions.boxHeight*6,
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
                "Algorithm Accuracy :- ${((sentiment['Amazon']['Accuracy'])*100).round().toDouble()} %",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
