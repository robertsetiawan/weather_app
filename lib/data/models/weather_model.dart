class WeatherModel {
  Main main;
  List<WeatherItem> weather;
  
  WeatherModel({this.main, this.weather});

  factory WeatherModel.fromJson(Map<String, dynamic> parsedJson) {
    List<WeatherItem> _weather = [];
    for (int i = 0; i < parsedJson['weather'].length; i++) {
      WeatherItem result = WeatherItem(parsedJson['weather'][i]);
      _weather.add(result);
    }
    return WeatherModel(weather: _weather, main: Main(parsedJson['main']));
  }
}

class Main {
  double temp;
  double tempMin;
  int humidity;
  int pressure;
  double tempMax;

  Main(parsedJson) {
    temp = parsedJson['temp'];
    tempMin = parsedJson['temp_min'];
    humidity = parsedJson['humidity'];
    pressure = parsedJson['pressure'];
    tempMax = parsedJson['temp_max'];
  }
}

class WeatherItem {
  String icon;
  String description;
  String main;
  int id;

  WeatherItem(parsedJson) {
    icon = parsedJson['icon'];
    description = parsedJson['desctiption'];
    main = parsedJson['main'];
    id = parsedJson['id'];
  }
}
