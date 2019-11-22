import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:house_manager2/src/models/house.dart';
import 'package:house_manager2/src/resource/Product_page.dart';

import 'Add_house_page.dart';
import 'House_item_infor.dart';

class HousePage extends StatefulWidget{
  @override
  _HousePageState createState() => _HousePageState();
}
class _HousePageState extends State<HousePage>
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
        /*appBar: AppBar
          (
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Text('Nhà trọ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
          actions: <Widget>
          [
            Container
              (
              margin: EdgeInsets.only(right: 8.0),
              child: Row
                (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Text('com.tuandiep', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 14.0)),
                  Icon(Icons.arrow_drop_down, color: Colors.black54)
                ],
              ),
            )
          ],
        ),*/
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddHousePage())),
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body: new Container(
          child: allData.length == 0 ? new Text('No data Available'):
          new ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              itemCount: allData.length,
              itemBuilder: (_,index){
                return UI2(
                    allData[index].nameHouse,
                    allData[index].addressHouse,
                    allData[index].numberHouse,
                    allData[index].floorHouse,
                    context
                );
              }),
        )
    );
  }
}

Widget UI2(String nameHouse,String addressHouse,String numberHouse,String floorHouse,BuildContext context){
  HouseData newHouse = new HouseData(nameHouse, addressHouse, numberHouse, floorHouse);
  /// Item card
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
                      elevation: 12.0,
                      borderRadius: BorderRadius.circular(12.0),
                      shadowColor: Color(0x802196F3),
                      color: Colors.white,
                      child: InkWell
                        (
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => HouseItemInforPage(newHouse))),
                        child: Padding
                          (
                          padding: EdgeInsets.all(25.0),
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
                                      /*Icon(Icons.star, color: Colors.black, size: 24.0),*/
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
                                  Text('(Số tầng: ${floorHouse.toString()})', style: TextStyle()),
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
                  ),
                  /// Item image
                  Align
                    (
                    alignment: Alignment.topRight,
                    child: Padding
                      (
                      padding: EdgeInsets.fromLTRB(0,0,12.0,0),
                      child: SizedBox.fromSize
                        (
                        size: Size.fromRadius(46.0),
                        child: Material
                          (
                          elevation: 10.0,
                          shadowColor: Color(0x802196F3),
                          shape: CircleBorder(),
                          child: Image.asset('assets/images/ic_house_appbar64px.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
        /// Review
        /*Padding
          (
          padding: EdgeInsets.only(top: 160.0, left: 32.0),
          child: Material
            (
            elevation: 12.0,
            color: Colors.transparent,
            borderRadius: BorderRadius.only
              (
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Container
              (
              decoration: BoxDecoration
                (
                  gradient: LinearGradient
                    (
                      colors: [ Color(0xFF84fab0), Color(0xFF8fd3f4) ],
                      end: Alignment.topLeft,
                      begin: Alignment.bottomRight
                  )
              ),
              child: Container
                (
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile
                  (
                  leading: CircleAvatar
                    (
                    backgroundColor: Colors.purple,
                    child: Text('AI'),
                  ),
                  title: Text('Ivascu Adrian ★★★★★', style: TextStyle()),
                  subtitle: Text('The shoes were shipped one day before the shipping date, but this wasn\'t at all a problem :). The shoes are very comfortable and good looking', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle()),
                ),
              ),
            ),
          ),
        )*/
      ],
    ),
  );
}


Widget UI(String nameHouse,String addressHouse,String numberHouse,String floorHouse){
  /// Item card
  return new Container(
    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
