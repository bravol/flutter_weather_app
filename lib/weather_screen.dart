import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/additonal_info_item.dart';
import 'package:flutter_weather_app/hourly_focused.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '300K',
                              style: TextStyle(fontSize: 32),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Icon(
                              Icons.cloud,
                              size: 64,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Rain',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),

            const Text(
              'Weather Forecast',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  //card
                  HourlyFocusedItem(
                      icon: Icons.cloud, temperature: '301.22', time: '00:00'),
                  HourlyFocusedItem(
                      icon: Icons.sunny, temperature: '300.52', time: '03:00'),
                  HourlyFocusedItem(
                      icon: Icons.cloud, temperature: '302.22', time: '06:00'),
                  HourlyFocusedItem(
                      icon: Icons.wb_sunny_sharp,
                      temperature: '300.22',
                      time: '09:00'),
                  HourlyFocusedItem(
                      icon: Icons.cloud, temperature: '304.12', time: '12:00'),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            const Text(
              'Additional Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItem(
                    icon: Icons.water_drop, label: 'Humidity', value: '91'),
                AdditionalInfoItem(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  value: '7.5',
                ),
                AdditionalInfoItem(
                    icon: Icons.beach_access, label: 'Pressure', value: '1006'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
