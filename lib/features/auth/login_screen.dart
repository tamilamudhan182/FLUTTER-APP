import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../features/journey/journey_provider.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_otpSent) {
      setState(() => _otpSent = true);
      return;
    }
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JourneyProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const AppLogo(size: 86),
                    SizedBox(height: 14.h),
                    Text(
                      'Sign in to OneJourney',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Book smarter rides with prepaid safety.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.muted,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36.h),
              Text('Mobile Number', style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800)),
              SizedBox(height: 10.h),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                decoration: const InputDecoration(
                  prefixText: '+91  ',
                  hintText: '98765 43210',
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 240),
                child: _otpSent
                    ? Padding(
                        key: const ValueKey('otp'),
                        padding: EdgeInsets.only(top: 18.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mock OTP', style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800)),
                            SizedBox(height: 10.h),
                            TextField(
                              controller: _otpController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                              decoration: const InputDecoration(
                                hintText: 'Enter any 6 digits',
                                suffixIcon: Icon(Icons.lock_clock_rounded),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(height: 22.h),
              Text('Preferred Language', style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800)),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: ['English', 'Tamil', 'Hindi', 'Malayalam'].map((language) {
                  final selected = provider.language == language;
                  return ChoiceChip(
                    label: Text(language),
                    selected: selected,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : AppColors.textDark,
                      fontWeight: FontWeight.w700,
                    ),
                    side: BorderSide(color: selected ? AppColors.primary : AppColors.line),
                    onSelected: (_) => provider.setLanguage(language),
                  );
                }).toList(),
              ),
              SizedBox(height: 28.h),
              PrimaryButton(
                label: _otpSent ? 'Verify & Continue' : 'Send OTP',
                icon: _otpSent ? Icons.verified_rounded : Icons.sms_rounded,
                onPressed: _submit,
              ),
              SizedBox(height: 20.h),
              AppCard(
                child: Row(
                  children: [
                    const Icon(Icons.shield_rounded, color: AppColors.success),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Your number is used only for trip updates, QR tickets, and safety alerts.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.muted,
                              height: 1.45,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
