import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/soft_icon.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<_OnboardingSlide> _slides = const [
    _OnboardingSlide(
      title: 'Welcome to OneJourney',
      subtitle: 'Plan direct rides and smart combined journeys across Indian cities from one premium mobility hub.',
      icon: Icons.route_rounded,
      color: AppColors.primary,
    ),
    _OnboardingSlide(
      title: 'Smart Comparison',
      subtitle: 'Compare Faster, Cheaper, Safer, Premium, and Carbonless options before you book.',
      icon: Icons.compare_arrows_rounded,
      color: AppColors.blue,
    ),
    _OnboardingSlide(
      title: '100% Prepaid',
      subtitle: 'Pay once in the app with clear pricing. No cash to driver, no last-minute surprises.',
      icon: Icons.payments_rounded,
      color: AppColors.success,
    ),
    _OnboardingSlide(
      title: 'Safe Travel + Carbon Rewards',
      subtitle: 'See safety scores, track journey steps, and earn carbon points for cleaner choices.',
      icon: Icons.verified_user_rounded,
      color: AppColors.purple,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _continue() {
    if (_index == _slides.length - 1) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                  child: const Text('Skip'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (value) => setState(() => _index = value),
                  itemCount: _slides.length,
                  itemBuilder: (_, index) => _OnboardingPage(slide: _slides[index]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (dot) => AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    height: 8.h,
                    width: dot == _index ? 28.w : 8.w,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: dot == _index ? AppColors.primary : AppColors.line,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              PrimaryButton(
                label: _index == _slides.length - 1 ? 'Get Started' : 'Continue',
                onPressed: _continue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.slide});

  final _OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 260.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: slide.color.withOpacity(0.09),
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 34.h,
                left: 34.w,
                child: _PulseDot(color: slide.color, size: 18),
              ),
              Positioned(
                right: 42.w,
                bottom: 38.h,
                child: _PulseDot(color: slide.color, size: 28),
              ),
              SoftIcon(icon: slide.icon, color: slide.color, size: 116),
            ],
          ),
        ),
        SizedBox(height: 42.h),
        Text(
          slide.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        SizedBox(height: 14.h),
        Text(
          slide.subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.muted,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

class _PulseDot extends StatelessWidget {
  const _PulseDot({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.h,
      width: size.h,
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}
