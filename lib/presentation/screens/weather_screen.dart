import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_app/presentation/widgets/additonal_info_item.dart';
import 'package:flutter_weather_app/presentation/widgets/hourly_focused.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched());
  }

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
            onPressed: () {
              context.read<WeatherBloc>().add(WeatherFetched());
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherFailure) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is! WeatherSuccess) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          final data = state.weatherModel;
          final currentSky = data.currentSky;
          final currentPresure = data.currentPresure;
          final currentHumidity = data.currentHumidity;

          return SingleChildScrollView(
            child: Padding(
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
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${data.currentTemp} K',
                                    style: const TextStyle(fontSize: 32),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Icon(
                                    currentSky == 'Clouds' ||
                                            currentSky == 'Rain'
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 64,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    currentSky,
                                    style: const TextStyle(fontSize: 20),
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
                            icon: Icons.cloud,
                            temperature: '301.22',
                            time: '00:00'),
                        HourlyFocusedItem(
                            icon: Icons.sunny,
                            temperature: '300.52',
                            time: '03:00'),
                        HourlyFocusedItem(
                            icon: Icons.cloud,
                            temperature: '302.22',
                            time: '06:00'),
                        HourlyFocusedItem(
                            icon: Icons.wb_sunny_sharp,
                            temperature: '300.22',
                            time: '09:00'),
                        HourlyFocusedItem(
                            icon: Icons.cloud,
                            temperature: '304.12',
                            time: '12:00'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          value: currentHumidity.toString()),
                      AdditionalInfoItem(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: data.currentWindSpeed.toString(),
                      ),
                      AdditionalInfoItem(
                          icon: Icons.beach_access,
                          label: 'Pressure',
                          value: currentPresure.toString()),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
