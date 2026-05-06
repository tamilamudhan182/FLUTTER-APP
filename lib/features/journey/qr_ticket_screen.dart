import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../models/route_option.dart';
import '../../widgets/app_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/soft_icon.dart';
import 'journey_provider.dart';

class QrTicketScreen extends StatelessWidget {
  const QrTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JourneyProvider>();
    final route = provider.selectedRoute ?? provider.routes.first;
    final ticketData = 'ONEJOURNEY|CHENNAI|${route.title}|RS${route.price}|${DateTime.now().millisecondsSinceEpoch}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Ticket'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Home',
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false),
            icon: const Icon(Icons.home_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
          children: [
            AppCard(
              padding: EdgeInsets.all(22.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.primary, width: 4),
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                    child: QrImageView(
                      data: ticketData,
                      version: QrVersions.auto,
                      size: 220.w,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: AppColors.textDark,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'OneJourney Pass',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Show this QR at metro gates, bus boarding, or driver pickup.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.muted,
                          height: 1.45,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            _TicketDetails(route: route),
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share_rounded),
                    label: const Text('Share'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 52.h),
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                      textStyle: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_rounded),
                    label: const Text('Download'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 52.h),
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                      textStyle: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            PrimaryButton(
              label: 'Back to Home',
              icon: Icons.home_rounded,
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false),
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketDetails extends StatelessWidget {
  const _TicketDetails({required this.route});

  final RouteOption route;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          _DetailRow(icon: Icons.route_rounded, label: 'Route', value: 'Current Location to Chennai Airport'),
          const Divider(height: 24),
          _DetailRow(icon: Icons.schedule_rounded, label: 'Arrival', value: route.arrival),
          const Divider(height: 24),
          _DetailRow(icon: Icons.payments_rounded, label: 'Paid', value: 'Rs. ${route.price}'),
          const Divider(height: 24),
          _DetailRow(icon: Icons.eco_rounded, label: 'Carbon saved', value: route.carbonSaved),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SoftIcon(icon: icon, size: 40),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.muted)),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
