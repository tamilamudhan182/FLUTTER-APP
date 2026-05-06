import 'package:flutter/material.dart';

class RouteOption {
  const RouteOption({
    required this.title,
    required this.arrival,
    required this.duration,
    required this.price,
    required this.modes,
    required this.carbonSaved,
    required this.score,
    this.isRecommended = false,
  });

  final String title;
  final String arrival;
  final String duration;
  final int price;
  final List<IconData> modes;
  final String carbonSaved;
  final int score;
  final bool isRecommended;
}
