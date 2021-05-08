import 'package:flutter/material.dart';
import 'package:sparkcart/ApiCalls/searchapi.dart';
import '../dimensions.dart';
import '../Components/SearchCard.dart';

class SearchByCategoryPage extends StatefulWidget {
  final String Category;
  final String Key;

  SearchByCategoryPage({this.Category,this.Key});
  @override
  _SearchByCategoryPageState createState() => _SearchByCategoryPageState();
}

class _SearchByCategoryPageState extends State<SearchByCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.Category,
          style: TextStyle(
            letterSpacing: 2
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: FutureBuilder(
              future: SearchCategory(widget.Category,widget.Key),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if (snapshot.data == '204'){
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: Dimensions.boxHeight*2, horizontal: Dimensions.boxWidth*5),
                    padding: EdgeInsets.all(10.0),
                    height: Dimensions.boxHeight*15,
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
                    child: Center(
                      child: Text(
                        'No Products in this Category Found',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Dimensions.boxHeight*3,
                            color: Colors.pink[800],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  );
                }
                else if(snapshot.data == null){
                  return Container(
                    margin: EdgeInsets.all(Dimensions.boxHeight * 13),
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.pink[800],
                    ),
                  );
                }
                else {
                  return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return SearchCard(data: snapshot.data[index]);
                          },
                      )
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
