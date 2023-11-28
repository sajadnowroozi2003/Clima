import 'package:clima/components/details_widget.dart';
import 'package:clima/components/error_message.dart';
import 'package:clima/components/loading_widget.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/utilities/weather_icons.dart';
import 'package:clima/utilities/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDataLoaded = false;
  bool isErrorOccured = false;
  double? latitude, longitude;
  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  LocationPermission? permission;
  WeatherModel? weathermodle;
  int code = 0;
  Weather weather = Weather();
  var weatherData;
  String? title, message;

  void getpermissions() async {
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      print('permission is denied');

      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        if (permission == LocationPermission.deniedForever) {
          print('Permission denied forever ,user should enable location from device settings');
          setState(() {
            isDataLoaded = true;
            isErrorOccured =true;
            title = 'permission permanently denied';
            message = 'Please provide permission to the app from device setting';
          });

        } else {
        print('permission granted');
        updateUI();
      }
    }else{
        print('User denied the request');
        updateUI(cityName: 'herat');
      }
    }else{
      updateUI();
    }
  }

  void updateUI({String? cityName}) async {
    if (cityName == null || cityName == '') {
      if (!await geolocatorPlatform.isLocationServiceEnabled()) {
        setState(() {
          isErrorOccured = true;
          isDataLoaded = true;
          title = 'Location is turned off';
          message =
              'Please Enable the Location Service to see weather condition your location';
          return;
        });
      }
      weatherData = null;
      weatherData = await weather.getLocationWeather();
    } else {
      weatherData = await weather.getCityWeather(cityName);
    }
    if(weatherData == null){
      setState(() {
        title = 'City not found';
        message ='Please make sure you have entered the right city name';
        isDataLoaded = true;
        isErrorOccured = true;
        return;

      });
    }


    code = weatherData['weather'][0]['id'];
    weathermodle = WeatherModel(
      description: weatherData['weather'][0]['description'],
      location: weatherData['name'] + ', ' + weatherData['sys']['country'],
      temperature: weatherData['main']['temp'],
      humidity: weatherData['main']['humidity'],
      feelsLike: weatherData['main']['feels_like'],
      windSpeed: weatherData['wind']['speed'],
      icon:
          'images/weather-icons/${getIconPrefix(code)}${kWeatherIcons[code.toString()]!['icon']}.svg',
    );
    setState(() {
      isDataLoaded = true;
      isErrorOccured = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getpermissions();
    print('permission id not denide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataLoaded) {
      return const loadingWidget();
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kOverlayColor,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        decoration: kTextFieldDecotation,
                        onSubmitted: (String typedName) {
                          setState(() {
                            isDataLoaded = false;
                            updateUI(cityName: typedName);
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white12,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isDataLoaded = false;
                            getpermissions();
                          });
                        },
                        child: Container(
                          height: 60,
                          child: Row(
                            children: [
                              Text(
                                'My Location',
                                style: kTextFieldTestStyle,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.gps_fixed,
                                color: Colors.white60,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              isErrorOccured
                  ? ErrorMessage(title: title!, message: message!)
                  : Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_city,
                                  color: kMidlightColor,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  weathermodle!.location,
                                  style: kLocationTextStyle,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            SvgPicture.asset(
                              weathermodle!.icon,
                              height: 280,
                              colorFilter: ColorFilter.mode(
                                  kMidlightColor, BlendMode.srcIn),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              '${weathermodle!.temperature.round()}°',
                              style: kTempTextStyle,
                            ),
                            Text(
                              weathermodle!.description.toUpperCase(),
                              style: kLocationTextStyle,
                            ),
                          ]),
                    ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: kOverlayColor,
                  child: Container(
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DetailsWidget(
                          title: 'FEELS LIKE',
                          value:
                              '${weathermodle != null ? weathermodle!.feelsLike.round() : 0}°',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                        DetailsWidget(
                          title: 'HUMIDITY',
                          value:
                              '${weathermodle != null ? weathermodle!.humidity.round() : 0}%',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                        DetailsWidget(
                          title: 'WIND',
                          value:
                              '${weathermodle != null ? weathermodle!.windSpeed.round() : 0}',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
