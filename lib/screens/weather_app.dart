// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/widget/building_transform.dart';
import 'package:weather_app/widget/single_weather_widget.dart';
import 'package:weather_app/models/weather_location.dart';
import '../widget/slider_dot.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:transformer_page_view/transformer_page_view.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
  late String bgImg;

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationList[_currentPage].weatherType == 'Sunny') {
      bgImg = 'assets/sunny.jpeg';
    } else if (locationList[_currentPage].weatherType == 'Night') {
      bgImg = 'assets/night.jpeg';
    } else if (locationList[_currentPage].weatherType == 'Rainy') {
      bgImg = 'assets/rainy.jpeg';
    } else if (locationList[_currentPage].weatherType == 'Cloudy') {
      bgImg = 'assets/cloudy.jpeg';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () => debugPrint('Menu clicked'),
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          )
        ],
      ),
      body: Container(
          child: Stack(children: [
        Image.asset(
          bgImg,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black38),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 140,
            left: 15,
          ),
          child: Row(
            children: [
              for (int i = 0; i < locationList.length; i++)
                if (i == _currentPage) SliderDot(true) else SliderDot(false)
            ],
          ),
        ),
        TransformerPageView(
            onPageChanged: _onPageChanged,
            scrollDirection: Axis.horizontal,
            transformer: ScaleAndFadeTransformer(),
            viewportFraction: 0.8,
            itemCount: locationList.length,
            itemBuilder: (ctx, i) => SingleWeather(i))
      ])),
    );
  }
}
