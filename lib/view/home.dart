import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/view_model/weather_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

import '../main.dart';
import '../network/Response/git_model.dart';

/// Example [Widget] showing the functionalities of the geolocator plugin
class GeolocatorWidget extends StatefulWidget {
  /// Utility method to create a page with the Baseflow templating.

  @override
  _GeolocatorWidgetState createState() => _GeolocatorWidgetState();
}

class _GeolocatorWidgetState extends State<GeolocatorWidget> {
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position>? _positionStreamSubscription;
  var _weather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weather = Provider.of<WeatherProvider>(context, listen: false);

    hitWeatherAPI();
    // _toggleListening();
  }
  List<Placemark>? placemarks;
  hitWeatherAPI() async {

    // placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
    await Geolocator.getCurrentPosition().then((value) async {
      // print('current'+placemarks.toString());
      await _weather.fetchWeather(
          context,value.latitude.toString(),value.longitude.toString()
      );
      return {
        _positionItems.add(_PositionItem(
            _PositionItemType.position, value.toString()))
      };
    });

    setState(
          () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                    top: 60,
                    child: FutureBuilder<Repo?>(
                      future: dao!.findAllRepo(),
                      builder: (_, snapshot) {

                        if (!snapshot.hasData)
                         {  dao!.insertRepo(Repo(
                        id: 0,
                        name: '',));
                          return Text('');}

                        final tasks = snapshot.requireData;

                        return
                          Text('Hello ${tasks!.name}',style: const TextStyle(
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
                    top: 120,
                    right: 60,
                    child: Column(
                      children: [
                        Text(
                            '${weather.getUserDetailsRes().current!.temp!-273.000}'.substring(0,4)+' \u2103',
                            style: TextStyle(
                                fontSize: 64,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        Text(
                          '${weather.getUserDetailsRes().timezone.toString()}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              );
        }),
      ),

      // ListView.builder(
      //   itemCount: _positionItems.length,
      //   itemBuilder: (context, index) {
      //     final positionItem = _positionItems[index];
      //
      //     if (positionItem.type == _PositionItemType.permission) {
      //       return ListTile(
      //         title: Text('S'+positionItem.displayValue,
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.bold,
      //             )),
      //       );
      //     } else {
      //       return Card(
      //         child: ListTile(
      //           // tileColor: themeMaterialColor,
      //           title: Text(
      //             positionItem.displayValue,
      //             style: TextStyle(color: Colors.black),
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // ),
      /*
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: () => setState(_positionItems.clear),
              label: Text("clear"),
            ),
          ),
          Positioned(
            bottom: 80.0,
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: () async {
                await Geolocator.getLastKnownPosition().then((value) => {
                  _positionItems.add(_PositionItem(
                      _PositionItemType.position, value.toString()))
                });

                setState(
                      () {},
                );
              },
              label: Text("Last Position"),
            ),
          ),
          Positioned(
            bottom: 150.0,
            right: 10.0,
            child: FloatingActionButton.extended(
                onPressed: () async {
                  await Geolocator.getCurrentPosition().then((value) async {
                    print('current'+value.latitude.toString());
                    await _weather.fetchWeather(
                        context,value.latitude.toString(),value.longitude.toString()
                    );
                    return {
                    _positionItems.add(_PositionItem(
                        _PositionItemType.position, value.toString()))
                  };
                  });

                  setState(
                        () {},
                  );
                },
                label: Text("Current Position")),
          ),
          Positioned(
            bottom: 220.0,
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: _toggleListening,
              label: Text(() {
                if (_positionStreamSubscription == null) {
                  return "Start stream";
                } else {
                  final buttonText = _positionStreamSubscription!.isPaused
                      ? "Resume"
                      : "Pause";

                  return "$buttonText stream";
                }
              }()),
              backgroundColor: _determineButtonColor(),
            ),
          ),
          Positioned(
            bottom: 290.0,
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: () async {
                await Geolocator.checkPermission().then((value) => {
                  _positionItems.add(_PositionItem(
                      _PositionItemType.permission, value.toString()))
                });
                setState(() {});
              },
              label: Text("Check Permission"),
            ),
          ),
          Positioned(
            bottom: 360.0,
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: () async {
                await Geolocator.requestPermission().then((value) => {
                  _positionItems.add(_PositionItem(
                      _PositionItemType.permission, value.toString()))
                });
                setState(() {});
              },
              label: Text("Request Permission"),
            ),
          ),
        ],
      ),*/
    );
  }

  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription!.isPaused);

  Color _determineButtonColor() {
    return _isListening() ? Colors.green : Colors.red;
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = Geolocator.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) async {
        // await _weather.fetchWeather(context, position.latitude.toString(),
        //     position.longitude.toString());
        print(position.latitude);
        setState(() => _positionItems.add(
            _PositionItem(_PositionItemType.position, position.toString())));
      });
      _positionStreamSubscription?.pause();
    }

    setState(() {
      if (_positionStreamSubscription == null) {
        return;
      }

      if (_positionStreamSubscription!.isPaused) {
        _positionStreamSubscription!.resume();
      } else {
        _positionStreamSubscription!.pause();
      }
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }
}

enum _PositionItemType {
  permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
