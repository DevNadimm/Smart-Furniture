import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final TextEditingController startDateController;
  final TextEditingController endDateController;

  /// Optional picker for filtering (e.g., supplier, customer)
  final bool showFilterPicker;
  final TextEditingController? filterPickerController;
  final VoidCallback? onFilterPickerTap;
  final String? filterPickerLabel;

  final VoidCallback onApplyFilter;
  final Future<void> Function(BuildContext context, TextEditingController controller) onSelectDate;

  const FilterBar({
    super.key,
    required this.startDateController,
    required this.endDateController,
    this.showFilterPicker = false,
    this.filterPickerController,
    this.onFilterPickerTap,
    this.filterPickerLabel,
    required this.onApplyFilter,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildDateField(context, 'Start Date', startDateController),
          const SizedBox(width: 8),
          _buildDateField(context, 'End Date', endDateController),
          const SizedBox(width: 8),

          if (showFilterPicker) ...[
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: filterPickerController,
                  readOnly: true,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: filterPickerLabel ?? 'Select',
                    labelStyle: Theme.of(context)
                        .inputDecorationTheme
                        .labelStyle
                        ?.copyWith(fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  ),
                  onTap: onFilterPickerTap,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],

          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: onApplyFilter,
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

  Expanded _buildDateField(BuildContext context, String label, TextEditingController controller) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: controller,
          readOnly: true,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: Theme.of(context)
                .inputDecorationTheme
                .labelStyle
                ?.copyWith(fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          ),
          onTap: () => onSelectDate(context, controller),
        ),
      ),
    );
  }
}
