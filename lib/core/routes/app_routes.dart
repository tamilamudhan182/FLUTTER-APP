import 'package:flutter/material.dart';

import '../../features/auth/login_screen.dart';
import '../../features/home/main_shell.dart';
import '../../features/journey/payment_screen.dart';
import '../../features/journey/qr_ticket_screen.dart';
import '../../features/journey/route_results_screen.dart';
import '../../features/journey/search_screen.dart';
import '../../features/journey/trip_details_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/splash/splash_screen.dart';

class AppRoutes {
  const AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String search = '/search';
  static const String results = '/results';
  static const String tripDetails = '/trip-details';
  static const String payment = '/payment';
  static const String qrTicket = '/qr-ticket';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        onboarding: (_) => const OnboardingScreen(),
        login: (_) => const LoginScreen(),
        home: (_) => const MainShell(),
        search: (_) => const SearchScreen(),
        results: (_) => const RouteResultsScreen(),
        tripDetails: (_) => const TripDetailsScreen(),
        payment: (_) => const PaymentScreen(),
        qrTicket: (_) => const QrTicketScreen(),
      };
}
