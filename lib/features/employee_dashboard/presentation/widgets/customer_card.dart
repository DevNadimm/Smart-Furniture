import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/customer_model.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer/customer_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CustomerCard extends StatelessWidget {
  final CustomerData? customer;
  final VoidCallback? onEdit;
  final bool isAdmin;

  const CustomerCard({
    super.key,
    required this.customer,
    this.onEdit,
    this.isAdmin = false,
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        customer?.name ?? strings.notAvailable,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.primaryColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (!isAdmin)
                    Row(
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
                  /// Bangla Name
                  if (customer?.nameBn != null && customer!.nameBn!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer!.nameBn!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.grey.withValues(alpha: 0.8),
                              ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),

                  /// Email
                  if (customer?.email != null && customer!.email!.isNotEmpty)
                    _buildInfoRow(
                      context,
                      icon: HugeIcons.strokeRoundedMail01,
                      label: strings.email,
                      value: customer!.email!,
                    ),

                  /// Phone
                  if (customer?.phone != null && customer!.phone!.isNotEmpty)
                    _buildInfoRow(
                      context,
                      icon: HugeIcons.strokeRoundedCall,
                      label: strings.phone,
                      value: customer!.phone!,
                    ),

                  /// Address
                  if (customer?.address != null &&
                      customer!.address!.isNotEmpty)
                    _buildInfoRow(
                      context,
                      icon: HugeIcons.strokeRoundedLocation01,
                      label: strings.address,
                      value: customer!.address!,
                      maxLines: 2,
                    ),

                  /// Branch ID
                  if (customer?.branchId != null &&
                      customer!.branchId!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            strings.branch,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          _infoTag(
                            'ID: ${customer!.branchId}',
                            AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HugeIcon(
            icon: icon,
            color: AppColors.primaryColor,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
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
          title: Text(strings.deleteCustomer,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          content: Text(strings.deleteCustomerConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(strings.cancel,
                  style: const TextStyle(color: AppColors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (customer?.id != null) {
                  context
                      .read<CustomerBloc>()
                      .add(DeleteCustomerEvent(customer!.id!));
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
