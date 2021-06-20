import 'package:http/http.dart' as http;
import 'package:weather_app/data/models/weather_model.dart';
import 'dart:convert';

class WeatherRepository {
  Future<WeatherModel> getWeatherInfo(String city) async {
    // TODO: add API KEY here
    var apiKey = '';

    var url = Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=' +
        city +
        '&appid=' +
        apiKey.toString());

    final response = await http.get(url);

    Map<String, dynamic> parsedJson = json.decode(response.body);
    
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(parsedJson);
    } else {
      if (parsedJson.containsKey('message')) {
        throw Exception(parsedJson['message']);
      }
      throw Exception('Failed to fetch weather');
    }
  }
}
