

class Validations {
  static bool isValidUser(String user){
    return user != null && user.length > 5 && user.contains("@");
  }
  static bool isValidPass(String pass){
    return pass != null && pass.length > 5;
  }
  static bool isValidFullname(String fullname){
    return fullname != null && fullname.length > 0;
  }
  static bool isValidEmail(String email){
    return email != null && email.length > 5 && email.contains("@");
  }
  static bool isValidPhone(String phone){
    return phone != null && phone.length > 0;
  }
  static bool isValidAddress(String address){
    return address != null && address.length > 0;
  }
  static bool isValidNumber(String number){
    return number != null && number.length > 0 && int.parse(number) > 0 && int.parse(number) < 21;
  }
  static bool isValidFloor(String floor){
    return floor != null && floor.length >0 && int.parse(floor) > 0 && int.parse(floor) < 6;
  }

}