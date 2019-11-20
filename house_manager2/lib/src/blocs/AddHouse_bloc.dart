import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:house_manager2/src/fire_base/fire_base_house_service.dart';
import 'package:house_manager2/src/validators/validations.dart';
import 'package:house_manager2/src/fire_base/fire_base_auth.dart';

class AddHouseBloc {
  var _FirHouseServices = FirHouseServices();

  StreamController _nameHouseController = new StreamController();
  StreamController _addressHouseController = new StreamController();
  StreamController _numberHouseController = new StreamController();
  StreamController _floorHouseController = new StreamController();

  Stream get NameHouseStream  => _nameHouseController.stream;
  Stream get AddressHouseStream  => _addressHouseController.stream;
  Stream get NumberHouseStream  => _numberHouseController.stream;
  Stream get FloorHouseStream  => _floorHouseController.stream;

  bool isValidInfo(String nameHouse, String addressHouse,String numberHouse,String floorHouse){
    if(!Validations.isValidFullname(nameHouse)){
      _nameHouseController.sink.addError("Tên không được để trống");
      return false;
    }
    _nameHouseController.sink.add("OK");
    if(!Validations.isValidAddress(addressHouse)){
      _addressHouseController.sink.addError("Địa chỉ không được để trống");
      return false;
    }
    _addressHouseController.sink.add("OK");
    if(!Validations.isValidNumber(numberHouse)){
      _numberHouseController.sink.addError("Số lượng phòng >20 hoặc đang để trống");
      return false;
    }
    _numberHouseController.sink.add("OK");
    if(!Validations.isValidFloor(floorHouse)){
      _floorHouseController.sink.addError("Số tầng lớn hơn 0 và không quá 5 tầng");
      return false;
    }
    _floorHouseController.sink.add("OK");
    return true;
  }
  void addHouse(String nameHouse,String addressHouse,String numberHouse,String floorHouse,Function onSuccess,Function(String) onAddhouseError){
    _FirHouseServices.createHouse(nameHouse, addressHouse, numberHouse, floorHouse,onSuccess,onAddhouseError);
  }

  void dispose(){
    _nameHouseController.close();
    _addressHouseController.close();
    _numberHouseController.close();
    _floorHouseController.close();
  }
}