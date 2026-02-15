// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hugeicons/hugeicons.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:smart_furniture/core/constants/error_messages.dart';
// import 'package:smart_furniture/core/utils/enums/message_type.dart';
// import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
// import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
// import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
// import 'package:smart_furniture/core/utils/widgets/loader.dart';
// import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
// import 'package:smart_furniture/features/accounts/presentation/blocs/bank_accounts/bank_accounts_bloc.dart';
// import 'package:smart_furniture/features/accounts/presentation/blocs/bank_transaction/bank_transaction_bloc.dart';
// import 'package:smart_furniture/features/accounts/presentation/widgets/bank_transaction_card.dart';
// import 'package:smart_furniture/features/accounts/presentation/widgets/bank_transaction_filter.dart';
// import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';
// import 'package:smart_furniture/l10n/app_localizations.dart';
//
// class BankTransactionPage extends StatefulWidget {
//   static Route route() => MaterialPageRoute(builder: (context) => const BankTransactionPage());
//
//   const BankTransactionPage({super.key});
//
//   @override
//   State<BankTransactionPage> createState() => _BankTransactionPageState();
// }
//
// class _BankTransactionPageState extends State<BankTransactionPage> {
//   final TextEditingController _fromDateController = TextEditingController();
//   final TextEditingController _toDateController = TextEditingController();
//   final TextEditingController _typeController = TextEditingController();
//   final TextEditingController _accountNameController = TextEditingController();
//   final TextEditingController _accountIdController = TextEditingController();
//   final List<String> _typeList = ['All - সব', 'Deposit - জমা', 'Withdraw - উত্তোলন'];
//   Map<String, String> _accountNameToId = {};
//
//   @override
//   void initState() {
//     _fetchBankAccounts();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _fromDateController.dispose();
//     _toDateController.dispose();
//     _typeController.dispose();
//     _accountNameController.dispose();
//     _accountIdController.dispose();
//     super.dispose();
//   }
//
//   void _fetchBankAccounts() {
//     final selectedShop = context.read<ShopSelectionCubit>().state;
//     if (selectedShop != null) {
//       context.read<BankAccountsBloc>().add(
//         LoadBankAccountsEvent(
//           selectedShop.name,
//         ),
//       );
//     } else {
//       AppNotifier.showToast(ErrorMessages.networkError, type: MessageType.error);
//     }
//   }
//
//   void _fetchData() {
//     final selectedShop = context.read<ShopSelectionCubit>().state;
//     if (selectedShop != null) {
//       context.read<BankTransactionBloc>().add(
//         LoadBankTransactionEvent(
//           shop: selectedShop.name,
//           accountId: _accountIdController.text,
//           type: _typeController.text,
//           fromDate: _fromDateController.text,
//           toDate: _toDateController.text,
//         ),
//       );
//     } else {
//       AppNotifier.showToast(ErrorMessages.networkError, type: MessageType.error);
//     }
//   }
//
//   void _resetBankTransaction() {
//     context.read<BankTransactionBloc>().add(ResetBankTransactionEvent());
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
//   void _selectTypePicker(List<String> items, AppLocalizations strings) {
//     showBarModalBottomSheet(
//       context: context,
//       isDismissible: true,
//       builder: (_) {
//         return SearchableBottomSheet(
//           items: items,
//           title: strings.selectTypeTitle,
//           subtitle: strings.selectTypeSubtitle,
//           searchHint: strings.selectTypeSearchHint,
//           selectedItem: _typeController.text,
//           onItemSelected: (String selectedName) {
//             _typeController.text = selectedName;
//           },
//         );
//       },
//     );
//   }
//
//   void _selectAccountPicker(List<String> items, AppLocalizations strings) {
//     showBarModalBottomSheet(
//       context: context,
//       isDismissible: true,
//       builder: (_) {
//         return SearchableBottomSheet(
//           items: items,
//           title: strings.selectBankAccountTitle,
//           subtitle: strings.selectBankAccountSubtitle,
//           searchHint: strings.selectBankAccountSearchHint,
//           selectedItem: _accountNameController.text,
//           onItemSelected: (String selectedName) {
//             _accountNameController.text = selectedName;
//             _accountIdController.text = _accountNameToId[selectedName] ?? '';
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final strings = AppLocalizations.of(context)!;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(strings.bankTransactionTitle),
//         leading: IconButton(
//           onPressed: () {
//             _resetBankTransaction();
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//       ),
//       body: Column(
//         children: [
//           BlocBuilder<BankAccountsBloc, BankAccountsState>(
//             builder: (context, state) {
//               if (state is BankAccountsLoaded) {
//                 _accountNameToId = {
//                   for (var a in state.bankAccountModel.data!)
//                     a.bankName ?? '': a.id?.toString() ?? ''
//                 };
//                 return BankTransactionFilter(
//                   startDateController: _fromDateController,
//                   endDateController: _toDateController,
//                   accountNameController: _accountNameController,
//                   typeController: _typeController,
//                   onAccountPickerTap: () => _selectAccountPicker(state.bankAccountModel.data!.map((e) => e.bankName ?? '').toList(), strings),
//                   onTypePickerTap: () => _selectTypePicker(_typeList, strings),
//                   onSelectDate: _selectDate,
//                   onApplyFilter: _fetchData,
//                 );
//               } else if (state is BankAccountsLoading) {
//                 return BankTransactionFilter(
//                   startDateController: _fromDateController,
//                   endDateController: _toDateController,
//                   accountNameController: _accountNameController,
//                   typeController: _typeController,
//                   onAccountPickerTap: () {},
//                   onTypePickerTap: () => _selectTypePicker(_typeList, strings),
//                   onSelectDate: _selectDate,
//                   onApplyFilter: () {},
//                 );
//               } else if (state is BankAccountsError) {
//                 return BankTransactionFilter(
//                   startDateController: _fromDateController,
//                   endDateController: _toDateController,
//                   accountNameController: _accountNameController,
//                   typeController: _typeController,
//                   onAccountPickerTap: () {},
//                   onTypePickerTap: () => _selectTypePicker(_typeList, strings),
//                   onSelectDate: _selectDate,
//                   onApplyFilter: _fetchData,
//                 );
//               } else {
//                 return const SizedBox.shrink();
//               }
//             }
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: BlocConsumer<BankTransactionBloc, BankTransactionState>(
//                   listener: (context, state) {
//                     if (state is BankTransactionError) {
//                       AppNotifier.showToast(state.message, type: MessageType.error);
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is BankTransactionLoading) {
//                       return const Loader();
//                     } else if (state is BankTransactionInitial) {
//                       return const EmptyStateWidget(
//                         icon: HugeIcons.strokeRoundedDateTime,
//                         title: 'Select All Filters',
//                         message: 'Please choose an account, transaction type, and set both the "Start" and "End" dates to view bank transaction details.',
//                       );
//                     } else if (state is BankTransactionError) {
//                       return const ErrorStateWidget(
//                         title: 'Failed to Load Transactions',
//                         message: ErrorMessages.networkError,
//                       );
//                     } else if (state is BankTransactionLoaded) {
//                       final bankTransactions = state.bankTransactionModel.data;
//                       if (bankTransactions?.isEmpty ?? false) {
//                         return const EmptyStateWidget(
//                           title: 'No Bank Transactions Found',
//                           message: 'We couldn’t find any bank transaction records for the selected account, type and date range. Try adjusting your filters or selecting a different time period.',
//                         );
//                       } else {
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: bankTransactions?.length ?? 0,
//                           itemBuilder: (context, index) {
//                             final data = bankTransactions?[index];
//                             return BankTransactionCard(transaction: data);
//                           },
//                         );
//                       }
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
