import 'package:get/get.dart';

class LoginModel{

  //Individual variable observable
  var individualObsString = "check".obs;
  var individualObsInt = 10.obs;

  //Whole class make observable
  var countryCode;
  var mobileName;

  LoginModel({this.countryCode,this.mobileName});
}