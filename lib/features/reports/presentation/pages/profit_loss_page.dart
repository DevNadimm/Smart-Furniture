// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:smart_furniture/core/constants/error_messages.dart';
// import 'package:smart_furniture/core/services/localization_service.dart';
// import 'package:smart_furniture/core/utils/enums/message_type.dart';
// import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
// import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
// import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
// import 'package:smart_furniture/core/utils/widgets/loader.dart';
// import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
// import 'package:smart_furniture/features/administration/presentation/blocs/customer_list/customer_list_bloc.dart';
// import 'package:smart_furniture/features/reports/presentation/blocs/profit_loss/profit_loss_bloc.dart';
// import 'package:smart_furniture/features/reports/presentation/widgets/profit_loss_card.dart';
// import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';
// import 'package:smart_furniture/l10n/app_localizations.dart';
//
// class ProfitLossPage extends StatefulWidget {
//   static Route route() => MaterialPageRoute(builder: (context) => const ProfitLossPage());
//
//   const ProfitLossPage({super.key});
//
//   @override
//   State<ProfitLossPage> createState() => _ProfitLossPageState();
// }
//
// class _ProfitLossPageState extends State<ProfitLossPage> {
//   final TextEditingController _fromDateController = TextEditingController();
//   final TextEditingController _toDateController = TextEditingController();
//   final TextEditingController _customerNameController = TextEditingController();
//   final TextEditingController _customerIdController = TextEditingController();
//   Map<String, String> _customerNameToId = {};
//
//   @override
//   void initState() {
//     _fetchCustomers();
//     _fetchData();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _fromDateController.dispose();
//     _toDateController.dispose();
//     _customerNameController.dispose();
//     _customerIdController.dispose();
//     super.dispose();
//   }
//
//   void _fetchData() {
//     final selectedShop = context.read<ShopSelectionCubit>().state;
//     if (selectedShop != null) {
//       context.read<ProfitLossBloc>().add(
//         LoadProfitLossEvent(
//           shop: selectedShop.name,
//           customerId: _customerIdController.text,
//           fromDate: _fromDateController.text,
//           toDate: _toDateController.text,
//         ),
//       );
//     } else {
//       AppNotifier.showToast(ErrorMessages.networkError, type: MessageType.error);
//     }
//   }
//
//   void _fetchCustomers() {
//     final selectedShop = context.read<ShopSelectionCubit>().state;
//     if (selectedShop != null) {
//       context.read<CustomerListBloc>().add(
//         LoadCustomerListEvent(
//           selectedShop.name,
//         ),
//       );
//     } else {
//       AppNotifier.showToast(ErrorMessages.networkError, type: MessageType.error);
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2025),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       controller.text = DateFormat('yyyy-MM-dd').format(picked);
//     }
//   }
//
//   void _selectCustomerPicker(List<String> items, AppLocalizations strings) {
//     showBarModalBottomSheet(
//       context: context,
//       isDismissible: true,
//       builder: (_) {
//         return SearchableBottomSheet(
//           items: items,
//           title: strings.selectCustomerTitle,
//           subtitle: strings.selectCustomerSubtitle,
//           searchHint: strings.selectCustomerSearchHint,
//           selectedItem: _customerNameController.text,
//           onItemSelected: (String selectedName) {
//             _customerNameController.text = selectedName;
//             _customerIdController.text = _customerNameToId[selectedName] ?? '';
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final strings = AppLocalizations.of(context)!;
//     final locale = Localizations.localeOf(context).languageCode;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(strings.profitLossReportTitle),
//       ),
//       body: Column(
//         children: [
//           BlocBuilder<CustomerListBloc, CustomerListState>(
//               builder: (context, state) {
//                 if (state is CustomerListLoaded) {
//                   _customerNameToId = {
//                     for (var c in state.customerListModel.data!)
//                       (locale == 'bn' ? (c.customerNameBangla ?? '') : (c.customerName ?? '')): (c.id?.toString() ?? '')
//                   };
//                   return FilterBar(
//                     startDateController: _fromDateController,
//                     endDateController: _toDateController,
//                     showFilterPicker: true,
//                     filterPickerLabel: strings.customer,
//                     filterPickerController: _customerNameController,
//                     onFilterPickerTap: () => _selectCustomerPicker(state.customerListModel.data!.map((e) => LocalizationService.getText(context, en: e.customerName ?? '', bn: e.customerNameBangla ?? '')).toList(), strings),
//                     onSelectDate: _selectDate,
//                     onApplyFilter: _fetchData,
//                   );
//                 } else if (state is CustomerListLoading) {
//                   return FilterBar(
//                     startDateController: _fromDateController,
//                     endDateController: _toDateController,
//                     showFilterPicker: true,
//                     filterPickerLabel: strings.customer,
//                     filterPickerController: _customerNameController,
//                     onFilterPickerTap: () {},
//                     onSelectDate: _selectDate,
//                     onApplyFilter: () {},
//                   );
//                 } else if (state is CustomerListError) {
//                   return FilterBar(
//                     startDateController: _fromDateController,
//                     endDateController: _toDateController,
//                     showFilterPicker: true,
//                     filterPickerLabel: strings.customer,
//                     filterPickerController: _customerNameController,
//                     onFilterPickerTap: () {},
//                     onSelectDate: _selectDate,
//                     onApplyFilter: _fetchData,
//                   );
//                 } else {
//                   return const SizedBox.shrink();
//                 }
//               }
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: BlocConsumer<ProfitLossBloc, ProfitLossState>(
//                   listener: (context, state) {
//                     if (state is ProfitLossError) {
//                       AppNotifier.showToast(state.message, type: MessageType.error);
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is ProfitLossLoading) {
//                       return const Loader();
//                     } else if (state is ProfitLossError) {
//                       return const ErrorStateWidget(
//                         title: 'Failed to Load Profit & Loss',
//                         message: ErrorMessages.networkError,
//                       );
//                     } else if (state is ProfitLossLoaded) {
//                       final profitLoss = state.profitLossModel;
//                       return ProfitLossCard(profitLoss: profitLoss);
//                     } else {
//                       return const SizedBox.shrink();
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
