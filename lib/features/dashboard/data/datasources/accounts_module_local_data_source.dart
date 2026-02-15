// import 'package:flutter/cupertino.dart';
// import 'package:smart_furniture/core/constants/image_paths.dart';
// import 'package:smart_furniture/features/accounts/presentation/pages/additional_payments_page.dart';
// import 'package:smart_furniture/features/accounts/presentation/pages/balance_sheet_page.dart';
// import 'package:smart_furniture/features/accounts/presentation/pages/bank_transaction_page.dart';
// import 'package:smart_furniture/features/accounts/presentation/pages/cash_transaction_page.dart';
// import 'package:smart_furniture/features/accounts/presentation/pages/pending_cheque_list_page.dart';
// import 'package:smart_furniture/features/accounts/presentation/pages/reminder_cheque_list_page.dart';
// import 'package:smart_furniture/features/dashboard/domain/entities/sub_module.dart';
// import 'package:smart_furniture/l10n/app_localizations.dart';
//
// class AccountsModuleLocalDataSource {
//   static List<SubModule> getAccountsModules(BuildContext context) {
//     final strings = AppLocalizations.of(context)!;
//
//     return [
//       SubModule(
//         title: strings.bankTransactionTitle,
//         subTitle: strings.bankTransactionSubtitle,
//         iconPath: AppImages.bankTransaction,
//         onTap: () {
//           Navigator.push(context, BankTransactionPage.route());
//         },
//       ),
//       SubModule(
//         title: strings.cashTransactionTitle,
//         subTitle: strings.cashTransactionSubtitle,
//         iconPath: AppImages.cashTransaction,
//         onTap: () {
//           Navigator.push(context, CashTransactionPage.route());
//         },
//       ),
//       SubModule(
//         title: strings.pendingChequeListTitle,
//         subTitle: strings.pendingChequeListSubtitle,
//         iconPath: AppImages.cheque,
//         onTap: () {
//           Navigator.push(context, PendingChequeListPage.route());
//         },
//       ),
//       SubModule(
//         title: strings.reminderChequeListTitle,
//         subTitle: strings.reminderChequeListSubtitle,
//         iconPath: AppImages.cheque,
//         onTap: () {
//           Navigator.push(context, ReminderChequeListPage.route());
//         },
//       ),
//       SubModule(
//         title: strings.balanceSheetTitle,
//         subTitle: strings.balanceSheetSubtitle,
//         iconPath: AppImages.reports,
//         onTap: () {
//           Navigator.push(context, BalanceSheetPage.route());
//         },
//       ),
//       SubModule(
//         title: strings.additionalPaymentsTitle,
//         subTitle: strings.additionalPaymentsSubtitle,
//         iconPath: AppImages.additionalPayments,
//         onTap: () {
//           Navigator.push(context, AdditionalPaymentsPage.route());
//         },
//       ),
//     ];
//   }
// }
