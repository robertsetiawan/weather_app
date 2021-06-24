class WeatherModel {
  final Main main;
  final List<WeatherItem> weather;

  WeatherModel({required this.main, required this.weather});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        main: Main.fromJson(json["main"]),
        weather: List<WeatherItem>.from(
          json["weather"].map(
            (x) => WeatherItem.fromJson(x),
          ),
        ),
      );
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble() ?? 0.0,
        feelsLike: json["feels_like"].toDouble() ?? 0.0,
        tempMin: json["temp_min"].toDouble() ?? 0.0,
        tempMax: json["temp_max"].toDouble() ?? 0.0,
        pressure: json["pressure"] ?? 0,
        humidity: json["humidity"] ?? 0,
        seaLevel: json["sea_level"] ?? 0,
        grndLevel: json["grnd_level"] ?? 0,
      );
}

class WeatherItem {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherItem(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  factory WeatherItem.fromJson(Map<String, dynamic> json) => WeatherItem(
        id: json["id"] ?? 000,
        main: json["main"] ?? "",
        description: json["description"] ?? "",
        icon: json["icon"] ?? "",
      );
}
