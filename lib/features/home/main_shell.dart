import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../journey/journey_provider.dart';
import '../journey/search_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'trips_screen.dart';
import 'wallet_screen.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  static const List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(isEmbedded: true),
    WalletScreen(),
    TripsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JourneyProvider>();

    return Scaffold(
      body: _pages[provider.bottomTabIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: provider.bottomTabIndex,
        onDestinationSelected: provider.setBottomTab,
        indicatorColor: AppColors.primary.withOpacity(0.14),
        backgroundColor: Colors.white,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            selectedIcon: Icon(Icons.search_rounded, color: AppColors.primary),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_number_outlined),
            selectedIcon: Icon(Icons.confirmation_number_rounded, color: AppColors.primary),
            label: 'Trips',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded, color: AppColors.primary),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
