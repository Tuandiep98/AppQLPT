import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:house_manager2/src/resource/Add_house_page.dart';
import 'package:house_manager2/src/models/house.dart';

class HouseItemPage extends StatefulWidget
{
  @override
  _HouseItemPageState createState() => _HouseItemPageState();
}

class _HouseItemPageState extends State<HouseItemPage>
{
  List<HouseData> allData = [];
  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    FirebaseAuth.instance.currentUser().then((user){
      ref.child('Houses').child(user.uid).once().then((DataSnapshot snap){
        var keys = snap.value.keys;
        var data = snap.value;
        for(var key in keys){
          HouseData d = new HouseData(
            data[key]['nameHouse'],
            data[key]['addressHouse'],
            data[key]['numberHouse'],
            data[key]['floorHouse'],
          );
          allData.add(d);
        }
        setState(() {
          print('length: ${allData.length}');
        });
      });
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
        appBar: AppBar
          (
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton
            (
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text('Nhà trọ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          // actions: <Widget>
          // [
          //   Container
          //   (
          //     margin: EdgeInsets.only(right: 8.0),
          //     child: Row
          //     (
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>
          //       [
          //         Text('beclothed.com', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14.0)),
          //         Icon(Icons.arrow_drop_down, color: Colors.black54)
          //       ],
          //     ),
          //   )
          // ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddHousePage())),
          label: Text('Add House'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body: new Container(
          child: allData.length == 0 ? new Text('No data Available'):
              new ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  itemCount: allData.length,
                  itemBuilder: (_,index){
                    return UI(
                        allData[index].nameHouse,
                        allData[index].addressHouse,
                        allData[index].numberHouse,
                        allData[index].floorHouse,
                    );
              }),
        )
    );
  }
}

Widget UI(String nameHouse,String addressHouse,String numberHouse,String floorHouse){
    /// Item card
  return new Container(
    child: Padding
      (
      padding: EdgeInsets.only(bottom: 16.0),
      child: Align
        (
        alignment: Alignment.topCenter,
        child: SizedBox.fromSize
          (
            size: Size.fromHeight(172.0),
            child: Stack
              (
              fit: StackFit.expand,
              children: <Widget>
              [
                /// Item description inside a material
                Container
                  (
                  margin: EdgeInsets.only(top: 24.0),
                  child: Material
                    (
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(12.0),
                    shadowColor: Color(0x802196F3),
                    color: Colors.white,
                    child: Padding
                      (
                      padding: EdgeInsets.all(24.0),
                      child: Column
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          /// Title and rating
                          Column
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Text('$nameHouse', style: TextStyle(color: Colors.blueAccent)),
                              Row
                                (
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>
                                [
                                  Text('$addressHouse', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                                ],
                              ),
                            ],
                          ),
                          /// Infos
                          Row
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>
                            [
                              Text('Số phòng: ', style: TextStyle()),
                              Padding
                                (
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text('${numberHouse.toString()}', style: TextStyle(fontWeight: FontWeight.w700)),
                              ),
                              Text('(Số lầu: ${floorHouse.toString()})', style: TextStyle()),
                              Padding
                                (
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Material
                                  (
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.green,
                                  child: Padding
                                    (
                                    padding: EdgeInsets.all(4.0),
                                    child: Text('Tốt', style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                /// Item image
                Align
                  (
                  alignment: Alignment.topRight,
                  child: Padding
                    (
                    padding: EdgeInsets.only(right: 16.0),
                    child: SizedBox.fromSize
                      (
                      size: Size.fromRadius(54.0),
                      child: Material
                        (
                        elevation: 20.0,
                        shadowColor: Color(0x802196F3),
                        shape: CircleBorder(),
                        child: Image.asset('assets/images/ic_house_error.png'),
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    ),
  );
}

class BadShopItem extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Padding
      (
      padding: EdgeInsets.only(bottom: 16.0),
      child: Stack
        (
        children: <Widget>
        [
          /// Item card
          Align
            (
            alignment: Alignment.topCenter,
            child: SizedBox.fromSize
              (
                size: Size.fromHeight(172.0),
                child: Stack
                  (
                  fit: StackFit.expand,
                  children: <Widget>
                  [
                    /// Item description inside a material
                    Container
                      (
                      margin: EdgeInsets.only(top: 24.0),
                      child: Material
                        (
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: Color(0x802196F3),
                        color: Colors.transparent,
                        child: Container
                          (
                          decoration: BoxDecoration
                            (
                              gradient: LinearGradient
                                (
                                  colors: [ Color(0xFFDA4453), Color(0xFF89216B) ]
                              )
                          ),
                          child: Padding
                            (
                            padding: EdgeInsets.all(24.0),
                            child: Column
                              (
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>
                              [
                                /// Title and rating
                                Column
                                  (
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>
                                  [
                                    Text('Nhà trọ example 2', style: TextStyle(color: Colors.white)),
                                    Row
                                      (
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>
                                      [
                                        Text('Đường 10, Gia Lạc', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w700, fontSize: 24.0)),
                                        /*Icon(Icons.star, color: Colors.amber, size: 24.0),*/
                                      ],
                                    ),
                                  ],
                                ),
                                /// Infos
                                Row
                                  (
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>
                                  [
                                    Text('Số phòng:', style: TextStyle(color: Colors.white)),
                                    Padding
                                      (
                                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text('20', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                                    ),
                                    Text('(Phòng hiện trống: 2)', style: TextStyle(color: Colors.white)),
                                    Padding
                                      (
                                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Material
                                        (
                                        borderRadius: BorderRadius.circular(8.0),
                                        color: Colors.red,
                                        child: Padding
                                          (
                                          padding: EdgeInsets.all(4.0),
                                          child: Text('Sắp đầy', style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    /// Item image
                    Align
                      (
                      alignment: Alignment.topRight,
                      child: Padding
                        (
                        padding: EdgeInsets.only(right: 16.0),
                        child: SizedBox.fromSize
                          (
                          size: Size.fromRadius(54.0),
                          child: Material
                            (
                            elevation: 20.0,
                            shadowColor: Color(0x802196F3),
                            shape: CircleBorder(),
                            child: Image.asset('assets/images/ic_house_error.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
          /// Review
          Padding
            (
            padding: EdgeInsets.only(top: 160.0, right: 32.0,),
            child: Material
              (
              elevation: 12.0,
              color: Colors.white,
              borderRadius: BorderRadius.only
                (
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NewShopItem extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Padding
      (
      padding: EdgeInsets.only(bottom: 16.0),
      child: Align
        (
        alignment: Alignment.topCenter,
        child: SizedBox.fromSize
          (
            size: Size.fromHeight(172.0),
            child: Stack
              (
              fit: StackFit.expand,
              children: <Widget>
              [
                /// Item description inside a material
                Container
                  (
                  margin: EdgeInsets.only(top: 24.0),
                  child: Material
                    (
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(12.0),
                    shadowColor: Color(0x802196F3),
                    color: Colors.white,
                    child: Padding
                      (
                      padding: EdgeInsets.all(24.0),
                      child: Column
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          /// Title and rating
                          Column
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Text('[New] Nike Jordan III', style: TextStyle(color: Colors.blueAccent)),
                              Row
                                (
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>
                                [
                                  Text('No reviews', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                ],
                              ),
                            ],
                          ),
                          /// Infos
                          Row
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>
                            [
                              Text('Bought', style: TextStyle()),
                              Padding
                                (
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text('0', style: TextStyle(fontWeight: FontWeight.w700)),
                              ),
                              Text('times for a profit of', style: TextStyle()),
                              Padding
                                (
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Material
                                  (
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.green,
                                  child: Padding
                                    (
                                    padding: EdgeInsets.all(4.0),
                                    child: Text('\$ 0', style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                /// Item image
                Align
                  (
                  alignment: Alignment.topRight,
                  child: Padding
                    (
                    padding: EdgeInsets.only(right: 16.0),
                    child: SizedBox.fromSize
                      (
                      size: Size.fromRadius(54.0),
                      child: Material
                        (
                        elevation: 20.0,
                        shadowColor: Color(0x802196F3),
                        shape: CircleBorder(),
                        child: Image.asset('res/shoes1.png'),
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}