import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/app.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/product_transfer/product_transfer_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/product_transfer_details/product_transfer_details_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/profit_loss/profit_loss_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/purchase/purchase_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/purchase_details/purchase_details_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/supplier/supplier_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/supplier_due_details/supplier_due_details_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/supplier_dues/supplier_dues_bloc.dart';
import 'package:smart_furniture/features/auth/presentation/blocs/employee_login/login_bloc.dart';
import 'package:smart_furniture/features/company/presentation/blocs/company_raw_material/company_raw_material_bloc.dart';
import 'package:smart_furniture/features/company/presentation/blocs/custom_production/custom_production_bloc.dart';
import 'package:smart_furniture/features/company/presentation/blocs/finished_product/finished_product_bloc.dart';
import 'package:smart_furniture/features/company/presentation/blocs/fixed_production/fixed_production_bloc.dart';
import 'package:smart_furniture/features/custom_order/presentation/blocs/custom_order/custom_order_bloc.dart';
import 'package:smart_furniture/features/custom_order/presentation/blocs/store_custom_order/store_custom_order_bloc.dart';
import 'package:smart_furniture/features/custom_order/presentation/blocs/store_due_payment/store_due_payment_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer/customer_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer_dues/customer_dues_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer_purchase_dues/customer_purchase_dues_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/due_payment/due_payment_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/employee_sales_details/employee_sales_details_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/expense/employee_expense_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/expense_head/expense_head_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/finished_product_category/finished_product_category_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/raw_material_category/raw_material_category_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/sales/employee_sales_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/sales_details/sales_details_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/stock/employee_stock_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/stock_register/stock_register_bloc.dart';
import 'package:smart_furniture/features/language_selector/presentation/cubit/language_cubit.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/branch_bloc.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';
import 'package:smart_furniture/features/user_role_selector/presentation/cubit/user_role_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(create: (_) => ShopSelectionCubit()),
        BlocProvider(create: (_) => ProfitLossBloc()),
        BlocProvider(create: (_) => UserRoleCubit()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => EmployeeStockBloc()),
        BlocProvider(create: (_) => EmployeeSalesDetailsBloc()),
        BlocProvider(create: (_) => SalesDetailsBloc()),
        BlocProvider(create: (_) => EmployeeSalesBloc()),
        BlocProvider(create: (_) => ExpenseHeadBloc()),
        BlocProvider(create: (_) => EmployeeExpenseBloc()),
        BlocProvider(create: (_) => CustomerBloc()),
        BlocProvider(create: (_) => BranchBloc()),
        BlocProvider(create: (_) => CustomerDuesBloc()),
        BlocProvider(create: (_) => CustomerPurchaseDuesBloc()),
        BlocProvider(create: (_) => DuePaymentBloc()),
        BlocProvider(create: (_) => FinishedProductBloc()),
        BlocProvider(create: (_) => CompanyRawMaterialBloc()),
        BlocProvider(create: (_) => PurchaseBloc()),
        BlocProvider(create: (_) => PurchaseDetailsBloc()),
        BlocProvider(create: (_) => SupplierBloc()),
        BlocProvider(create: (_) => SupplierDuesBloc()),
        BlocProvider(create: (_) => SupplierDueDetailsBloc()),
        BlocProvider(create: (_) => FinishedProductCategoryBloc()),
        BlocProvider(create: (_) => CustomOrderBloc()),
        BlocProvider(create: (_) => StoreCustomOrderBloc()),
        BlocProvider(create: (_) => StoreDuePaymentBloc()),
        BlocProvider(create: (_) => ProductTransferBloc()),
        BlocProvider(create: (_) => ProductTransferDetailsBloc()),
        BlocProvider(create: (_) => ProfitLossBloc()),
        BlocProvider(create: (_) => RawMaterialCategoryBloc()),
        BlocProvider(create: (_) => CustomProductionBloc()),
        BlocProvider(create: (_) => FixedProductionBloc()),
        BlocProvider(create: (_) => StockRegisterBloc()),
      ],
      child: const MyApp(),
    ),
  );
}
