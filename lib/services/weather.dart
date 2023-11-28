import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';


class Weather{

 Future getLocationWeather() async{
    location locaton = location();
    await locaton.getCarrentLocation();
    NetworkHelper networkhelper = NetworkHelper(
        '${kOWMBaseUrl}?units=metric&lat=${locaton.latitude}&lon=${locaton.longitude}&appid=$kApiKey');
    return await networkhelper.getData();
  }

  Future<dynamic> getCityWeather (String cityName) async{
   NetworkHelper newWorkHelper = NetworkHelper(
     '$kOWMBaseUrl?q=$cityName&appid=$kApiKey&units=metric');
   var weatherData =await newWorkHelper.getData();
   return weatherData;
  }
}