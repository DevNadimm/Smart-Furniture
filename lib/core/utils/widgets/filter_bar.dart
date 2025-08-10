import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final TextEditingController fromDateController;
  final TextEditingController toDateController;
  final VoidCallback onFilterPressed;
  final Future<void> Function(BuildContext context, TextEditingController controller) onSelectDate;

  const FilterBar({
    super.key,
    required this.fromDateController,
    required this.toDateController,
    required this.onFilterPressed,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: fromDateController,
                readOnly: true,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: 'From Date',
                  labelStyle: Theme.of(context)
                      .inputDecorationTheme
                      .labelStyle
                      ?.copyWith(fontSize: 14),
                ),
                onTap: () => onSelectDate(context, fromDateController),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: toDateController,
                readOnly: true,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: 'To Date',
                  labelStyle: Theme.of(context)
                      .inputDecorationTheme
                      .labelStyle
                      ?.copyWith(fontSize: 14),
                ),
                onTap: () => onSelectDate(context, toDateController),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: onFilterPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              child: const Text(
                'Filter',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
