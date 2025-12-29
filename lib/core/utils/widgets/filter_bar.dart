import 'package:flutter/material.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class FilterBar extends StatelessWidget {
  final TextEditingController? startDateController;
  final TextEditingController? endDateController;
  final String? startDateLabel;
  final String? endDateLabel;

  /// Optional picker for filtering (e.g., supplier, customer)
  final bool showFilterPicker;
  final TextEditingController? filterPickerController;
  final VoidCallback? onFilterPickerTap;
  final String? filterPickerLabel;

  final VoidCallback onApplyFilter;
  final Future<void> Function(BuildContext context, TextEditingController controller)? onSelectDate;

  const FilterBar({
    super.key,
    this.startDateController,
    this.endDateController,
    this.startDateLabel,
    this.endDateLabel,
    this.showFilterPicker = false,
    this.filterPickerController,
    this.onFilterPickerTap,
    this.filterPickerLabel,
    required this.onApplyFilter,
    this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (startDateController != null) _buildDateField(context, startDateLabel ?? strings.startDate, startDateController!),
          if (startDateController != null) const SizedBox(width: 8),

          if (endDateController != null) _buildDateField(context, endDateLabel ?? strings.endDate, endDateController!),
          if (endDateController != null) const SizedBox(width: 8),

          if (showFilterPicker) ...[
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: filterPickerController,
                  readOnly: true,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: filterPickerLabel ?? strings.select,
                    labelStyle: Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(fontSize: 14),
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
              child: Text(
                strings.filter,
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
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
          onTap: onSelectDate != null
              ? () => onSelectDate!(context, controller)
              : null,
        ),
      ),
    );
  }
}
