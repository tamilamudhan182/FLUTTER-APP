import 'package:flutter/material.dart';

import '../../models/journey_mode.dart';
import '../../models/route_option.dart';

class JourneyProvider extends ChangeNotifier {
  JourneyMode _mode = JourneyMode.combined;
  RouteOption? _selectedRoute;
  int _bottomTabIndex = 0;
  String _language = 'English';

  JourneyMode get mode => _mode;
  RouteOption? get selectedRoute => _selectedRoute;
  int get bottomTabIndex => _bottomTabIndex;
  String get language => _language;

  List<RouteOption> get routes => _mode == JourneyMode.direct ? directRoutes : combinedRoutes;

  void setMode(JourneyMode mode) {
    _mode = mode;
    _selectedRoute = null;
    notifyListeners();
  }

  void selectRoute(RouteOption route) {
    _selectedRoute = route;
    notifyListeners();
  }

  void setBottomTab(int index) {
    _bottomTabIndex = index;
    notifyListeners();
  }

  void setLanguage(String language) {
    _language = language;
    notifyListeners();
  }

  static const List<RouteOption> directRoutes = [
    RouteOption(
      title: 'Fastest',
      arrival: 'Arrives 9:32 AM',
      duration: '28 min',
      price: 286,
      modes: [Icons.local_taxi_rounded],
      carbonSaved: '0.4 kg',
      score: 86,
      isRecommended: true,
    ),
    RouteOption(
      title: 'Cheapest',
      arrival: 'Arrives 9:44 AM',
      duration: '40 min',
      price: 128,
      modes: [Icons.two_wheeler_rounded],
      carbonSaved: '0.7 kg',
      score: 78,
    ),
    RouteOption(
      title: 'Premium',
      arrival: 'Arrives 9:38 AM',
      duration: '34 min',
      price: 412,
      modes: [Icons.airline_seat_recline_extra_rounded],
      carbonSaved: '0.3 kg',
      score: 95,
    ),
  ];

  static const List<RouteOption> combinedRoutes = [
    RouteOption(
      title: 'Fastest',
      arrival: 'Arrives 9:36 AM',
      duration: '32 min',
      price: 74,
      modes: [Icons.train_rounded, Icons.directions_bus_rounded, Icons.electric_rickshaw_rounded],
      carbonSaved: '2.8 kg',
      score: 92,
      isRecommended: true,
    ),
    RouteOption(
      title: 'Cheapest',
      arrival: 'Arrives 9:51 AM',
      duration: '47 min',
      price: 42,
      modes: [Icons.train_rounded, Icons.directions_walk_rounded],
      carbonSaved: '3.1 kg',
      score: 84,
    ),
    RouteOption(
      title: 'Premium',
      arrival: 'Arrives 9:40 AM',
      duration: '36 min',
      price: 138,
      modes: [Icons.train_rounded, Icons.local_taxi_rounded],
      carbonSaved: '2.2 kg',
      score: 96,
    ),
  ];
}
