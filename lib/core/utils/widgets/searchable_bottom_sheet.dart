import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';

class SearchableBottomSheet extends StatefulWidget {
  final List<String> items;
  final String title;
  final String subtitle;
  final String searchHint;
  final String selectedItem;
  final Function(String) onItemSelected;

  const SearchableBottomSheet({
    super.key,
    required this.items,
    required this.title,
    required this.subtitle,
    required this.searchHint,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  State<SearchableBottomSheet> createState() => _SearchableBottomSheetState();
}

class _SearchableBottomSheetState extends State<SearchableBottomSheet> {
  late TextEditingController _searchController;
  late List<String> _filteredItems;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = List.from(widget.items);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.secondaryFontColor,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: widget.searchHint,
              prefixIcon: const Icon(Icons.search_rounded),
            ),
            onChanged: _filterItems,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _filteredItems.isNotEmpty
                ? ListView.separated(
                    itemCount: _filteredItems.length,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) {
                      final String item = _filteredItems[index];
                      final bool isSelected = item == widget.selectedItem;

                      return SelectableListItem(
                        title: item,
                        isSelected: isSelected,
                        onTap: () {
                          widget.onItemSelected(item);
                          Navigator.pop(context);
                        },
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "No results found.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class SelectableListItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableListItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.1)
              : AppColors.inputBorderColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: isSelected ? 2 : 1.5,
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.inputBorderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.primaryColor : AppColors.primaryFontColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
