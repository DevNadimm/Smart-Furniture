import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/app.dart';
import 'package:smart_furniture/features/hr_and_payroll/presentation/blocs/employee_list/employee_list_bloc.dart';
import 'package:smart_furniture/features/hr_and_payroll/presentation/blocs/salary_payment/salary_payment_bloc.dart';
import 'package:smart_furniture/features/language_selector/presentation/cubit/language_cubit.dart';
import 'package:smart_furniture/features/sales/presentation/blocs/sales_record/sales_record_bloc.dart';
import 'package:smart_furniture/features/sales/presentation/blocs/stock/stock_bloc.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(create: (_) => ShopSelectionCubit()),
        BlocProvider(create: (_) => SalesRecordBloc()),
        BlocProvider(create: (_) => StockBloc()),
        BlocProvider(create: (_) => SalaryPaymentBloc()),
        BlocProvider(create: (_) => EmployeeListBloc()),
      ],
      child: const MyApp(),
    ),
  );
}
