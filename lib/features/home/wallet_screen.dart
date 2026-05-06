import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/app_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/soft_icon.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            AppCard(
              child: Row(
                children: [
                  const SoftIcon(icon: Icons.account_balance_wallet_rounded),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('OneJourney Balance', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.muted)),
                        Text('Rs. 1,240', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            PrimaryButton(label: 'Add Money', icon: Icons.add_rounded, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
