import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_expense_model.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/expense/employee_expense_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class EmployeeExpenseCard extends StatelessWidget {
  final bool isAdmin;
  final EmployeeExpenseData? expense;
  final VoidCallback? onEdit;

  const EmployeeExpenseCard({
    super.key,
    required this.isAdmin,
    required this.expense,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            /// Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: isAdmin ? const EdgeInsets.symmetric(vertical: 8.0) : const EdgeInsets.all(0),
                      child: Text(
                        LocalizationService.getText(context, en: expense?.expense?.head ?? strings.notAvailable, bn: expense?.expense?.nameBn),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.primaryColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  isAdmin ? const SizedBox.shrink() : Row(
                    children: [
                      /// Edit Button
                      IconButton(
                        onPressed: onEdit,
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedEdit04,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 4),
                      /// Delete Button
                      IconButton(
                        onPressed: () => _showDeleteConfirmation(context),
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedDelete03,
                          color: AppColors.error,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            /// Body
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Expense Description
                  if (expense?.expense?.description != null && expense!.expense!.description!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense!.expense!.description!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  /// Remarks
                  if (expense?.remarks != null && expense!.remarks!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense!.remarks!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),
                  /// Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        strings.amount,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      _infoTag(
                        '৳${CurrencyFormatter.format(num.tryParse(expense?.amount ?? '0'), context: context)}',
                        AppColors.primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  /// Transaction Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        strings.date,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        DateFormatters.readableDate(context, expense?.transactionDate),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTag(String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: color,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            strings.deleteExpenseTitle,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          content: Text(strings.deleteExpenseMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                strings.cancel,
                style: const TextStyle(color: AppColors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (expense?.id != null) {
                  context.read<EmployeeExpenseBloc>().add(
                    DeleteEmployeeExpenseEvent(expense!.id!),
                  );
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
              ),
              child: Text(strings.delete),
            ),
          ],
        );
      },
    );
  }
}