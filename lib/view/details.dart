import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/view_model/weather_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

import '../main.dart';
import '../network/Response/git_model.dart';

class Details extends StatefulWidget {
  final String? value;
  Details(this.value);

  @override
  _DetailsState createState() => _DetailsState();
}



class _DetailsState extends State<Details> {

  var _weather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weather = Provider.of<WeatherProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      hitWeatherAPI();

    });
    // _toggleListening();
  }

  hitWeatherAPI() async {
    await _weather.fetchStateWeather(
        context, widget.value
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0,),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wallpaper.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<WeatherProvider>(builder: (context, weather, __) {
          // print('sss${weather.getUserDetailsRes().current!.temp.toString()}');
          return weather.isFetching
              ? Text('No Data')
              : Stack(
            children: [
              Positioned(
                left: 20,
                top: 100,
                child: FutureBuilder<Repo?>(
                  future: dao!.findAllRepo(),
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) {
                      dao!.insertRepo(Repo(
                        id: 0,
                        name: '',));
                      return Text('');
                    }

                    final tasks = snapshot.requireData;

                    return
                      Text('Hello ${tasks!.name}', style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),);
                  },
                ),
                //   Text(
                //     'Hello Subair',
                //     style: TextStyle(
                //         fontSize: 18,
                //         color: Colors.white,
                //         fontWeight: FontWeight.w500),
                //   ),
              ),
              Positioned(
                left: 60,
                top: 160,
                right: 60,
                child: Column(
                  children: [
                    Text(
                      weather.getStateWeather().main != null ? '${weather.getStateWeather().main!.temp! -
                          273.000}'.substring(0, 4) + ' \u2103' : '',
                      style: TextStyle(
                          fontSize: 64,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${widget.value}',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      weather
                          .getStateWeather()
                          .weather != null ? '${weather
                          .getStateWeather()
                          .weather![0]!.main}' : '',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 4,),

                    Text(
                      weather
                          .getStateWeather()
                          .weather != null ? '${weather
                          .getStateWeather()
                          .weather![0]!.description}' : '',

                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),

    );
  }

}