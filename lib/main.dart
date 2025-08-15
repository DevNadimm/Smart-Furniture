import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/app.dart';
import 'package:smart_furniture/features/accounts/presentation/blocs/balance_sheet/balance_sheet_bloc.dart';
import 'package:smart_furniture/features/accounts/presentation/blocs/cash_transaction/cash_transaction_bloc.dart';
import 'package:smart_furniture/features/accounts/presentation/blocs/pending_cheque_list/pending_cheque_list_bloc.dart';
import 'package:smart_furniture/features/accounts/presentation/blocs/reminder_cheque_list/reminder_cheque_list_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/customer_list/customer_list_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/damage_list/damage_list_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/product_ledger/product_ledger_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:smart_furniture/features/hr_and_payroll/presentation/blocs/employee_list/employee_list_bloc.dart';
import 'package:smart_furniture/features/hr_and_payroll/presentation/blocs/salary_payment/salary_payment_bloc.dart';
import 'package:smart_furniture/features/language_selector/presentation/cubit/language_cubit.dart';
import 'package:smart_furniture/features/purchase/presentation/blocs/purchase_record/purchase_record_bloc.dart';
import 'package:smart_furniture/features/purchase/presentation/blocs/purchase_return/purchase_return_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/supplier_list/supplier_list_bloc.dart';
import 'package:smart_furniture/features/sales/presentation/blocs/sales_record/sales_record_bloc.dart';
import 'package:smart_furniture/features/sales/presentation/blocs/sales_return/sales_return_bloc.dart';
import 'package:smart_furniture/features/sales/presentation/blocs/stock/stock_bloc.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(create: (_) => ShopSelectionCubit()),
        BlocProvider(create: (_) => PurchaseRecordBloc()),
        BlocProvider(create: (_) => PurchaseReturnBloc()),
        BlocProvider(create: (_) => SalesRecordBloc()),
        BlocProvider(create: (_) => SalesReturnBloc()),
        BlocProvider(create: (_) => StockBloc()),
        BlocProvider(create: (_) => ProductListBloc()),
        BlocProvider(create: (_) => DamageListBloc()),
        BlocProvider(create: (_) => CustomerListBloc()),
        BlocProvider(create: (_) => SupplierListBloc()),
        BlocProvider(create: (_) => ProductLedgerBloc()),
        BlocProvider(create: (_) => SalaryPaymentBloc()),
        BlocProvider(create: (_) => EmployeeListBloc()),
        BlocProvider(create: (_) => CashTransactionBloc()),
        BlocProvider(create: (_) => PendingChequeListBloc()),
        BlocProvider(create: (_) => ReminderChequeListBloc()),
        BlocProvider(create: (_) => BalanceSheetBloc()),
      ],
      child: const MyApp(),
    ),
  );
}
