import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparkcart/Components/Corousel.dart';
import 'package:sparkcart/Components/Drawer.dart';
import 'package:sparkcart/Components/getSnackbar.dart';
import 'package:sparkcart/Pages/CartPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkcart/Pages/SearchByCategoryPage.dart';
import 'package:sparkcart/Pages/WishlistPage.dart';
import '../dimensions.dart';
import 'dart:math';
import '../Components/Productcard.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> products = [];
  var searchValue;
  var imageurls = [
    'assets/offer1.jfif',
    'assets/offer2.jpg',
    'assets/offer4.jfif'
  ];
  var categories = [
    'Electronics',
    'Men',
    'Women',
    'Furniture',
    'TVs & Appliances',
    'Sports',
    'Babies & Kids',
    'Others'
  ];
  final _random = new Random();
  dynamic product;
  bool isLoggedIn = false;
  check_user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLogin');
    });
  }
  void onItemTapped(int index){
    if (index == 1){
      isLoggedIn?
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WishlistPage()))
          :
      Navigator.pushNamed(context, '/login');
    }
    if (index == 2){
      isLoggedIn ?
      Navigator.pushNamed(context, '/profile')
      :
      Navigator.pushNamed(context, '/login');
    }
  }
  Widget ProductCard() {
    return Container(
      constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 30,maxWidth: Dimensions.boxHeight * 60),
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      height: Dimensions.boxHeight * 30,
      width: Dimensions.boxHeight * 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, index){
          product = products[_random.nextInt(products.length)];
          return ProductCardComponent(product:product);
        },
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_user();
  }
  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    products = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Sparkcart'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.mic),
              onPressed: (){
                SnackBar snackbar = getSnackBar('Coming Soon');
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,0.0),
            child: IconButton(
                onPressed: ()  {
                  isLoggedIn?
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => CartPage()))
                  :
                  Navigator.pushNamed(context, '/login');
                  },
                icon: Icon(Icons.shopping_cart)
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.boxHeight*9),
          child: Container(
            height: Dimensions.boxHeight*6,
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            //padding: const EdgeInsets.only(top:10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Material(
                color: Colors.grey[300],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(width: Dimensions.boxWidth*2,),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => SearchByCategoryPage(Category: searchValue,Key: "Search",)));
                      },
                        child: Icon(Icons.search,color: Colors.grey)
                    ),
                    SizedBox(width: Dimensions.boxWidth*2,),
                    Expanded(
                      child: TextField(
                        // textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: ' Search by name or category',
                        ),
                        onChanged: (value) {
                          searchValue = value;
                        },
                        onSubmitted: (value){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => SearchByCategoryPage(Category: value,Key: "Search",)));
                        },
                      ),
                    ),
                    SizedBox(width: Dimensions.boxWidth*2,),
                    InkWell(
                      child: Icon(Icons.mic,color: Colors.grey,),
                      onTap: () {
                        SnackBar snackbar = getSnackBar('Coming Soon');
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                    ),
                    SizedBox(width: Dimensions.boxWidth*2,),
                  ],
                ),
              ),
            )
        ) ,
      ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(height: Dimensions.boxHeight*2),
            Container(
                child: getCorousel(imageurls)
            ),
            SizedBox(height: Dimensions.boxHeight*3),
            ProductCard(),
            SizedBox(height: Dimensions.boxHeight*2),
            Row(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 10,maxWidth: Dimensions.boxWidth * 100),
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  height: Dimensions.boxHeight * 10,
                  width: Dimensions.boxWidth * 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context,index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => SearchByCategoryPage(Category: categories[index],Key: "Category",)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: CircleAvatar(
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                  fontSize: Dimensions.boxHeight*1.6,
                                  color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                            radius: 30.0,
                            backgroundColor: Colors.pink[800],
                            //backgroundImage: AssetImage('assets/electronics.jfif'),
                          ),
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
            SizedBox(height: Dimensions.boxHeight*2),
            ProductCard()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped ,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // ignore: deprecated_member_use
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          // ignore: deprecated_member_use
          title: Text('Wishlist'),
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          // ignore: deprecated_member_use
          title: InkWell(
              child: Text('Profile')
          ),
          )
        ],
        selectedItemColor: Colors.pink[800],
      ),
    );
  }
}
