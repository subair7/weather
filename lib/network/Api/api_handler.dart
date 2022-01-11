import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/network/Response/state_weather_model.dart';
import 'package:weather_app/network/Response/weather_model.dart';
import 'package:weather_app/view_model/weather_viewmodel.dart';
import 'package:provider/provider.dart';


class ApiHandler {
  ///Production URL
  static final String BASE_URL = "https://api.openweathermap.org/data/2.5/";

  static ApiHandler? _instance;
  static Dio? _api;

  static ApiHandler getInstance() {
    _instance ??= ApiHandler();
    return _instance!;
  }



  static Future<Dio?> getAPI(BuildContext context, String tok) async {

    _api = new Dio();
    _api!.options.baseUrl = BASE_URL;
    _api!.options.headers["Content-Type"] = "application/json";
    _api!.options.headers["Accept"] = "application/json";
    return _api;
  }
  static Future<WeatherModel?> fetchWeather(
      BuildContext context, String lat,String lon) async {
    try {
      // EasyLoading.show();
      var dio = await getAPI(context, '');
      var formData = FormData.fromMap({
        'lat': lat,
        'lon': lon,
        'appid':'d65dcea494a01e32e6a5b001d6765659'
      });
      var response = await dio!.get("onecall?lat=$lat&lon=$lon&appid=d65dcea494a01e32e6a5b001d6765659",);
      print('code : ${response}');
      if (response.statusCode == 401) {
        // ToastUtils.show('Email or Password is incorrect');
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      WeatherModel objectResponse = WeatherModel.fromJson(user);
      await Provider.of<WeatherProvider>(context, listen: false).setWeather(objectResponse);
      return objectResponse;
    } catch (e) {
    }
    return null;
  }

  static Future<StateWeatherModel?> fetchStateWeather(
      BuildContext context, String state) async {
    try {
      // EasyLoading.show();
      var dio = await getAPI(context, '');

      var response = await dio!.get("weather?appid=d65dcea494a01e32e6a5b001d6765659&unit=metric&q=$state",);
      print('code : ${response}');
      if (response.statusCode == 401) {
        // ToastUtils.show('Email or Password is incorrect');
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      StateWeatherModel objectResponse = StateWeatherModel.fromJson(user);
      await Provider.of<WeatherProvider>(context, listen: false).setStateWeather(objectResponse);
      // await Provider.of<WeatherProvider>(context, listen: false).setTemp(response.data['main']['temp']);

      return objectResponse;
    } catch (e) {
    }
    return null;
  }



}
