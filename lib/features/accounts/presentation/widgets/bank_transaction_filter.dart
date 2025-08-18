import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BankTransactionFilter extends StatelessWidget {
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController typeController;
  final TextEditingController accountNameController;
  final VoidCallback onApplyFilter;
  final VoidCallback onAccountPickerTap;
  final VoidCallback onTypePickerTap;
  final Future<void> Function(BuildContext context, TextEditingController controller)? onSelectDate;

  const BankTransactionFilter({
    super.key,
    required this.startDateController,
    required this.endDateController,
    required this.typeController,
    required this.accountNameController,
    required this.onApplyFilter,
    required this.onSelectDate,
    required this.onAccountPickerTap,
    required this.onTypePickerTap,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildDateField(context, strings.startDate, startDateController),
          const SizedBox(width: 8),

          _buildDateField(context, strings.endDate, endDateController),
          const SizedBox(width: 8),

          _buildFilterPickerField(context, strings.account, accountNameController, onAccountPickerTap),
          const SizedBox(width: 8),

          _buildFilterPickerField(context, strings.type, typeController, onTypePickerTap),
          const SizedBox(width: 8),

          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: onApplyFilter,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              child: Text(
                strings.filter,
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
            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          ),
          onTap: onSelectDate != null ? () => onSelectDate!(context, controller) : null,
        ),
      ),
    );
  }

  Expanded _buildFilterPickerField (BuildContext context, String label, TextEditingController controller, VoidCallback onTapPicker) {
    return  Expanded(
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: controller,
          readOnly: true,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          ),
          onTap: onTapPicker,
        ),
      ),
    );
  }
}
