/*
import 'package:flutter/material.dart';
import 'package:house_manager2/src/colors/Product.dart';
import 'package:house_manager2/src/colors/color.dart';
import 'package:house_manager2/src/colors/fryo_icons.dart';
import 'package:house_manager2/src/colors/partials.dart';
import 'package:house_manager2/src/colors/styles.dart';
import 'package:house_manager2/src/resource/Dashboard_page.dart';
import 'package:house_manager2/src/resource/Product_page.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _tabs = [
      storeTab(context),
      Text('Tab2'),
      Text('Tab3'),
      Text('Tab4'),
      Text('Tab5'),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: _tabs[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
Widget storeTab(BuildContext context) {

  // will pick it up from here
  // am to start another template
  List<Product> foods = [
    Product(
        name: "House_1",
        image: "assets/images/ic_house_error.png",
        price: "\$25.00",
        userLiked: true,
        discount: 10),
    Product(
        name: "House_2",
        image: "assets/images/ic_house_error.png",
        price: "\$150.00",
        userLiked: false,
        discount: 7.8),
    Product(
      name: "House_3",
      image: 'assets/images/ic_house_error.png',
      price: '\$10.99',
      userLiked: false,
    ),
    Product(
        name: "House_4",
        image: "assets/images/ic_house_error.png",
        price: '\$50.00',
        userLiked: true,
        discount: 14)
  ];

  List<Product> drinks = [
    Product(
        name: "House_5",
        image: "assets/images/ic_house_error.png",
        price: "\$45.12",
        userLiked: true,
        discount: 2),
    Product(
        name: "House_6",
        image: "assets/images/ic_house_error.png",
        price: "\$28.00",
        userLiked: false,
        discount: 5.2),
    Product(
        name: "House_7",
        image: "assets/images/ic_house_error.png",
        price: "\$78.99",
        userLiked: false),
    Product(
        name: "House_8",
        image: "assets/images/ic_house_error.png",
        price: "\$168.99",
        userLiked: true,
        discount: 3.4)
  ];

  return ListView(children: <Widget>[
    headerTopCategories(),
    deals('Hot Deals', onViewMore: () {}, items: <Widget>[
      foodItem(foods[0], onTapped: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return new ProductPage(
                productData: foods[0],
              );
            },
          ),
        );
      }, onLike: () {}),
      foodItem(foods[1], onTapped: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return new ProductPage(
                productData: foods[1],
              );
            },
          ),
        );
      }, imgWidth: 250, onLike: () {

      }),
      foodItem(foods[2], onTapped: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return new ProductPage(
                productData: foods[2],
              );
            },
          ),
        );
      }, imgWidth: 200, onLike: () {

      }),
      foodItem(foods[3], onTapped: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return new ProductPage(
                productData: foods[3],
              );
            },
          ),
        );
      }, onLike: () {

      }),
    ]),
    deals('Drinks Parol', onViewMore: () {}, items: <Widget>[
      foodItem(drinks[0], onTapped: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return new ProductPage(
                productData: drinks[0],
              );
            },
          ),
        );
      }, onLike: () {}, imgWidth: 60),
      foodItem(drinks[1], onTapped: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return new ProductPage(
                productData: drinks[1],
              );
            },
          ),
        );
      }, onLike: () {}, imgWidth: 75),
      foodItem(drinks[2], onTapped: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return new ProductPage(
                productData: drinks[2],
              );
            },
          ),
        );
      }, imgWidth: 110, onLike: () {}),
      foodItem(drinks[3], onTapped: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return new ProductPage(
                productData: drinks[3],
              );
            },
          ),
        );
      }, onLike: () {}),
    ])
  ]);
}

Widget sectionHeader(String headerTitle, {onViewMore}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, top: 10),
        child: Text(headerTitle, style: h4),
      ),
      Container(
        margin: EdgeInsets.only(left: 15, top: 2),
        child: FlatButton(
          onPressed: onViewMore,
          child: Text('View all ›', style: contrastText),
        ),
      )
    ],
  );
}

// wrap the horizontal listview inside a sizedBox..
Widget headerTopCategories() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      sectionHeader('All Categories', onViewMore: () {}),
      SizedBox(
        height: 130,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            headerCategoryItem('Frieds', IconData(0xe80d), onPressed: () {}),
            headerCategoryItem('Fast Food', Fryo.food, onPressed: () {}),
            headerCategoryItem('Creamery', Fryo.poop, onPressed: () {}),
            headerCategoryItem('Hot Drinks', Fryo.coffee_cup, onPressed: () {}),
            headerCategoryItem('Vegetables', Fryo.leaf, onPressed: () {}),
          ],
        ),
      )
    ],
  );
}

Widget headerCategoryItem(String name, IconData icon, {onPressed}) {
  return Container(
    margin: EdgeInsets.only(left: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 86,
            height: 86,
            child: FloatingActionButton(
              shape: CircleBorder(),
              heroTag: name,
              onPressed: onPressed,
              backgroundColor: white,
              child: Icon(icon, size: 35, color: Colors.black87),
            )),
        Text(name + ' ›', style: categoryText)
      ],
    ),
  );
}

Widget deals(String dealTitle, {onViewMore, List<Widget> items}) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sectionHeader(dealTitle, onViewMore: onViewMore),
        SizedBox(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: (items != null)
                ? items
                : <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text('No items available at this moment.',
                    style: taglineText),
              )
            ],
          ),
        )
      ],
    ),
  );
}*/
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:house_manager2/src/resource/horizontal_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final carousel = Carousel(
    boxFit: BoxFit.cover,
    images: [
      AssetImage('assets/images/aaa.png'),
      AssetImage('assets/images/smart_house.png'),
      AssetImage('assets/images/touch_cell.png'),
    ],
    dotSize: 4.0,
    indicatorBgPadding: 3.0,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 2000),
  );

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          Container(
            child: Center(
              child: Stack(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.all(0.0),
                    height: screenHeight / 3,
                    child: carousel,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 340.0,
                      child: Container(
                        margin: EdgeInsets.only(top: 180, bottom: 10),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width * 0.92,
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 40.0,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Container(
                                    child: TextField(
                                      style: TextStyle(fontSize: 18, color: Colors.black),
                                      decoration: InputDecoration(
                                        labelText: 'Search',
                                        labelStyle: TextStyle(color: Color(0xff888888),fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              HorizontalList(),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                  color: Color.fromRGBO(0, 0, 0, .3))
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0,top: 360.0),
                    child: Text('Room emtpy',style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 380, 15, 0),
                    child: Text('aaaa'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

