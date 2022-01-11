import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/network/Api/api_handler.dart';
import 'package:weather_app/network/Response/state_weather_model.dart';
import 'package:weather_app/network/Response/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  bool isFetching = true;

  WeatherModel _getWeatherModel = WeatherModel();


  setWeather(WeatherModel data) {
    _getWeatherModel = data;
    print('temp'+_getWeatherModel.current!.temp.toString());

    isFetching = false;
    notifyListeners();
  }

  WeatherModel getUserDetailsRes() {
    return _getWeatherModel;
  }


  void fetchWeather(
      BuildContext context,
      String lat,String lon,
      ) async {

    try {
      await ApiHandler.fetchWeather(
        context,
        lat,lon
      );

    } catch (e) {
    }
  }



  StateWeatherModel _getStateWeatherModel = StateWeatherModel();
  double? temp;


  setStateWeather(StateWeatherModel data) {
    _getStateWeatherModel = data;
    // print('temp'+_getWeatherModel.current!.temp.toString());

    isFetching = false;
    notifyListeners();
  }

  StateWeatherModel getStateWeather() {
    return _getStateWeatherModel;
  }

  setTemp(double data) {
    temp = data;
    // print('temp'+_getWeatherModel.current!.temp.toString());

    isFetching = false;
    notifyListeners();
  }

  double? getTemp() {
    return temp;
  }


  void fetchStateWeather(
      BuildContext context,
      String state
      ) async {

    try {
      await ApiHandler.fetchStateWeather(
          context,
          state
      );

    } catch (e) {
    }
  }


}
