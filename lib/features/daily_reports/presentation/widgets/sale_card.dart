import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/features/daily_reports/data/models/daily_reports_model.dart';

class SaleCard extends StatelessWidget {
  final Sale? sale;

  const SaleCard({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final product = sale?.salesProduct?.isNotEmpty == true
        ? sale!.salesProduct!.first
        : null;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.primaryColor.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormatters.readableDate(sale?.saleDate ?? "").toString(),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    "Invoice: ${sale?.invoiceNo ?? '-'}",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Customer Info
                  Text(
                    sale?.customerName ?? 'Unknown Customer',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (sale?.customerContact != null)
                    Text(
                      sale!.customerContact!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.lightFontColor,
                      ),
                    ),
                  const SizedBox(height: 6),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product?.productName ?? 'N/A',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              product?.category?.name ?? 'N/A',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.lightFontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _priceTag(
                            "Paid",
                            "${CurrencyFormatter.format(int.tryParse(sale?.totalPaid ?? '0'))} Tk",
                          ),
                          _priceTag(
                            "Due",
                            "${CurrencyFormatter.format(int.tryParse(sale?.totalDue ?? '0'))} Tk",
                          ),
                          _priceTag(
                            "Total",
                            "${CurrencyFormatter.format(int.tryParse(sale?.totalAmount ?? '0'))} Tk",
                          ),
                        ],
                      )
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

  Widget _priceTag(String label, dynamic value) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
          "$label: ${value ?? '0.00'}",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.primaryColor,
            ),
          )
      ),
    );
  }
}
