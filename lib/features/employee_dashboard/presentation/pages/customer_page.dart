import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer/customer_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/create_customer_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/edit_customer_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/customer_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CustomerPage extends StatefulWidget {
  static Route route({bool? isAdmin, int? branchId}) => MaterialPageRoute(builder: (_) => CustomerPage(isAdmin: isAdmin ?? false, branchId: branchId));

  final bool isAdmin;
  final int? branchId;

  const CustomerPage({super.key, required this.isAdmin, this.branchId});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  /// SEARCH CONTROLLER
  final TextEditingController _searchController = TextEditingController();

  /// DATA LISTS
  List customers = [];
  List filteredCustomers = [];

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// ================= FETCH =================

  void _fetchCustomers() {
    context.read<CustomerBloc>().add(LoadCustomersEvent(branchId: widget.branchId));
  }

  /// ================= SEARCH =================

  void _onSearch(String query) {
    final q = query.toLowerCase().trim();

    setState(() {
      filteredCustomers = customers.where((customer) {
        final nameEn = (customer.name ?? '').toString().toLowerCase();
        final nameBn = (customer.nameBn ?? '').toString().toLowerCase();
        final phone = (customer.phone ?? '').toString().toLowerCase();

        return nameEn.contains(q) || nameBn.contains(q) || phone.contains(q);
      }).toList();
    });
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.customers),
      ),
      floatingActionButton: !widget.isAdmin ? FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            CreateCustomerPage.route(),
          );
          _fetchCustomers();
        },
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        elevation: 2,
        child: const Icon(Icons.add),
      ) : null,
      body: BlocConsumer<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is CustomerError) {
            AppNotifier.showToast(
              state.message,
              type: MessageType.error,
            );
          }

          if (state is CustomerOperationSuccess) {
            AppNotifier.showToast(
              state.message,
              type: MessageType.success,
            );
            _fetchCustomers();
          }

          if (state is CustomerLoaded) {
            customers = state.customerModel.data ?? [];
            filteredCustomers = customers;
          }
        },
        builder: (context, state) {
          /// LOADING
          if (state is CustomerLoading) {
            return const Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          /// ERROR
          if (state is CustomerError) {
            return ErrorStateWidget(
              title: strings.failedToLoadCustomers,
              message: ErrorMessages.networkError,
            );
          }

          /// LOADED
          if (state is CustomerLoaded) {
            if (filteredCustomers.isEmpty) {
              return Column(
                children: [
                  _buildSearchBar(strings),
                  Expanded(
                    child: EmptyStateWidget(
                      title: strings.noCustomersFound,
                      message: strings.noCustomerMatches,
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                /// SEARCH BAR
                _buildSearchBar(strings),

                /// CUSTOMER LIST
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: filteredCustomers.length,
                      itemBuilder: (context, index) {
                        return CustomerCard(
                          isAdmin: widget.isAdmin,
                          customer: filteredCustomers[index],
                          onEdit: () async {
                            await Navigator.push(
                              context,
                              EditCustomerPage.route(
                                customer: filteredCustomers[index],
                              ),
                            );
                            _fetchCustomers();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          /// OPERATION LOADING
          if (state is CustomerOperationLoading) {
            return const Loader();
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  /// ================= SEARCH BAR =================

  Widget _buildSearchBar(AppLocalizations strings) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearch,
        decoration: InputDecoration(
          hintText: strings.searchCustomerPlaceholder,
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