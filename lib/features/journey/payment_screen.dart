import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../models/route_option.dart';
import '../../widgets/app_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/soft_icon.dart';
import 'journey_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _method = 'OneJourney Wallet';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JourneyProvider>();
    final route = provider.selectedRoute ?? provider.routes.first;

    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
          children: [
            _PaymentHeader(route: route),
            SizedBox(height: 20.h),
            Text('Pay with', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
            SizedBox(height: 12.h),
            ...[
              _PaymentMethod(icon: Icons.account_balance_wallet_rounded, title: 'OneJourney Wallet', subtitle: 'Balance Rs. 1,240'),
              _PaymentMethod(icon: Icons.account_balance_rounded, title: 'UPI - onejourney@upi', subtitle: 'Mock instant payment'),
              _PaymentMethod(icon: Icons.qr_code_2_rounded, title: 'Scan UPI QR', subtitle: 'Use any UPI app'),
            ].map(
              (method) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: AppCard(
                  onTap: () => setState(() => _method = method.title),
                  child: Row(
                    children: [
                      SoftIcon(icon: method.icon, color: _method == method.title ? AppColors.primary : AppColors.blue),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(method.title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900)),
                            Text(method.subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.muted)),
                          ],
                        ),
                      ),
                      Radio<String>(
                        value: method.title,
                        groupValue: _method,
                        activeColor: AppColors.primary,
                        onChanged: (value) => setState(() => _method = value ?? _method),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            AppCard(
              child: Row(
                children: [
                  const Icon(Icons.lock_rounded, color: AppColors.success),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      '100% prepaid. Driver and operators receive confirmation after secure payment.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.muted,
                            height: 1.45,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            PrimaryButton(
              label: 'Pay Securely',
              icon: Icons.verified_user_rounded,
              onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.qrTicket),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentHeader extends StatelessWidget {
  const _PaymentHeader({required this.route});

  final RouteOption route;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          const SoftIcon(icon: Icons.receipt_long_rounded, color: Colors.white),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  route.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                Text(
                  '${route.duration} - ${route.arrival}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          Text(
            'Rs. ${route.price}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethod {
  const _PaymentMethod({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}
