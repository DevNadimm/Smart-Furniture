import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';

class ReportSection<T> extends StatelessWidget {
  final String title;
  final List<T>? items;
  final Widget Function(T item) itemBuilder;

  const ReportSection({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(width: 1.5, color: AppColors.borderColor),
      ),
      color: AppColors.backgroundColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            if (items == null || items!.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    'No Data!',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.start,
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = items![index];
                  return itemBuilder(item);
                },
              ),
          ],
        ),
      ),
    );
  }
}
