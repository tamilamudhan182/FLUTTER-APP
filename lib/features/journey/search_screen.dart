import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../models/journey_mode.dart';
import '../../widgets/app_card.dart';
import '../../widgets/mode_toggle.dart';
import '../../widgets/primary_button.dart';
import 'journey_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.isEmbedded = false});

  final bool isEmbedded;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _fromController = TextEditingController(text: 'Current Location');
  final TextEditingController _toController = TextEditingController(text: 'Chennai Airport');
  DateTime _date = DateTime.now();
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 00);
  final Set<String> _filters = {'Faster'};

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JourneyProvider>();
    final content = SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, widget.isEmbedded ? 14.h : 8.h, 20.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.isEmbedded)
              Text(
                'Search',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
              ),
            if (widget.isEmbedded) SizedBox(height: 16.h),
            AppCard(
              child: Column(
                children: [
                  TextField(
                    controller: _fromController,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      prefixIcon: Icon(Icons.my_location_rounded),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  TextField(
                    controller: _toController,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      prefixIcon: Icon(Icons.location_on_rounded),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: AppCard(
                    onTap: _pickDate,
                    child: _PickerTile(
                      icon: Icons.calendar_month_rounded,
                      label: 'Date',
                      value: '${_date.day}/${_date.month}/${_date.year}',
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AppCard(
                    onTap: _pickTime,
                    child: _PickerTile(
                      icon: Icons.schedule_rounded,
                      label: 'Time',
                      value: _time.format(context),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            ModeToggle(
              value: provider.mode,
              onChanged: provider.setMode,
            ),
            SizedBox(height: 20.h),
            Text('Filters', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: ['Faster', 'Cheaper', 'Safer', 'Carbonless', 'Premium'].map((filter) {
                final selected = _filters.contains(filter);
                return FilterChip(
                  label: Text(filter),
                  selected: selected,
                  selectedColor: AppColors.primary,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : AppColors.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                  side: BorderSide(color: selected ? AppColors.primary : AppColors.line),
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        _filters.add(filter);
                      } else {
                        _filters.remove(filter);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 26.h),
            PrimaryButton(
              label: provider.mode == JourneyMode.combined ? 'Find Combined Routes' : 'Find Direct Rides',
              icon: Icons.auto_awesome_rounded,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.results),
            ),
          ],
        ),
      ),
    );

    if (widget.isEmbedded) return content;

    return Scaffold(
      appBar: AppBar(title: const Text('Plan Journey')),
      body: content,
    );
  }
}

class _PickerTile extends StatelessWidget {
  const _PickerTile({
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
        Icon(icon, color: AppColors.primary),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.muted)),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
