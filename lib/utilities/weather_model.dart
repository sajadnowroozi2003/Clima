class WeatherModel {
  String description, icon, location;
  dynamic temperature, feelsLike, humidity, windSpeed;

  WeatherModel({
    required this.description,
    required this.icon,
    required this.location,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
  });
}
