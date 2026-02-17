import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/supplier/supplier_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/widgets/supplier_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class SupplierPage extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const SupplierPage());

  const SupplierPage({super.key});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {

  /// SEARCH CONTROLLER
  final TextEditingController _searchController = TextEditingController();

  /// DATA LISTS
  List suppliers = [];
  List filteredSuppliers = [];

  @override
  void initState() {
    super.initState();
    _fetchSuppliers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// ================= FETCH =================

  void _fetchSuppliers() {
    context.read<SupplierBloc>().add(LoadSuppliersEvent());
  }

  /// ================= SEARCH =================

  void _onSearch(String query) {
    final q = query.toLowerCase().trim();

    setState(() {
      filteredSuppliers = suppliers.where((supplier) {
        final nameEn = (supplier.name ?? '').toString().toLowerCase();
        final nameBn = (supplier.nameBn ?? '').toString().toLowerCase();
        final phone = (supplier.phone ?? '').toString().toLowerCase();
        final email = (supplier.email ?? '').toString().toLowerCase();

        return nameEn.contains(q) ||
            nameBn.contains(q) ||
            phone.contains(q) ||
            email.contains(q);
      }).toList();
    });
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.suppliers),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchSuppliers,
            tooltip: strings.refresh,
          ),
        ],
      ),

      body: BlocConsumer<SupplierBloc, SupplierState>(
        listener: (context, state) {
          if (state is SupplierError) {
            AppNotifier.showToast(
              state.message,
              type: MessageType.error,
            );
          }

          if (state is SupplierLoaded) {
            suppliers = state.suppliers;
            filteredSuppliers = state.suppliers;
          }
        },

        builder: (context, state) {

          /// LOADING
          if (state is SupplierLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          /// ERROR
          if (state is SupplierError) {
            return ErrorStateWidget(
              title: strings.supplierLoadError,
              message: ErrorMessages.networkError,
            );
          }

          /// LOADED
          if (state is SupplierLoaded) {

            if (filteredSuppliers.isEmpty) {
              return Column(
                children: [
                  _buildSearchBar(strings),
                  Expanded(
                    child: EmptyStateWidget(
                      title: strings.noSuppliersFound,
                      message: strings.noSuppliersMessage,
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [

                /// SEARCH BAR
                _buildSearchBar(strings),

                /// LIST
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: filteredSuppliers.length,
                    itemBuilder: (context, index) {
                      return SupplierCard(
                        supplier: filteredSuppliers[index],
                        onTap: () {
                          // future details navigation
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  /// ================= SEARCH BAR WIDGET =================

  Widget _buildSearchBar(AppLocalizations strings) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearch,
        decoration: InputDecoration(
          hintText: strings.searchSupplier,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              _onSearch('');
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          isDense: true,
        ),
      ),
    );
  }
}