import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en')
  ];

  /// No description provided for @appBarTxt.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Language'**
  String get appBarTxt;

  /// No description provided for @nextScreenBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get nextScreenBtn;

  /// No description provided for @languageScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select the language you’re most comfortable with to personalize your app experience.'**
  String get languageScreenSubtitle;

  /// No description provided for @selectShopTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a Shop'**
  String get selectShopTitle;

  /// No description provided for @selectShopSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a shop to view data and insights.'**
  String get selectShopSubtitle;

  /// No description provided for @changeShopBtn.
  ///
  /// In en, this message translates to:
  /// **'Switch Shop'**
  String get changeShopBtn;

  /// No description provided for @shopSmartFurniture.
  ///
  /// In en, this message translates to:
  /// **'Smart Furniture'**
  String get shopSmartFurniture;

  /// No description provided for @shopNoorjahanFurniture.
  ///
  /// In en, this message translates to:
  /// **'Noorjahan Furniture'**
  String get shopNoorjahanFurniture;

  /// No description provided for @shopNaimFurniture.
  ///
  /// In en, this message translates to:
  /// **'Naim Furniture'**
  String get shopNaimFurniture;

  /// No description provided for @shopNoorjahanSteel.
  ///
  /// In en, this message translates to:
  /// **'Noorjahan Steel'**
  String get shopNoorjahanSteel;

  /// No description provided for @adminLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login to Your Account'**
  String get adminLoginTitle;

  /// No description provided for @companyOverview.
  ///
  /// In en, this message translates to:
  /// **'Company Overview'**
  String get companyOverview;

  /// No description provided for @searchCategory.
  ///
  /// In en, this message translates to:
  /// **'Search category...'**
  String get searchCategory;

  /// Text shown when data is not available
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailable;

  /// Label for grand total amount
  ///
  /// In en, this message translates to:
  /// **'Grand Total'**
  String get grandTotal;

  /// Label for paid amount
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// Label for due amount
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get due;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Status label for completed purchases
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// Status label for pending purchases
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @deleteExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Expense'**
  String get deleteExpenseTitle;

  /// No description provided for @purchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get purchases;

  /// Label for product category
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @selectCategorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a category from the list'**
  String get selectCategorySubtitle;

  /// No description provided for @purchaseLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Purchases'**
  String get purchaseLoadError;

  /// No description provided for @noPurchasesFound.
  ///
  /// In en, this message translates to:
  /// **'No Purchases Found'**
  String get noPurchasesFound;

  /// No description provided for @noPurchasesMessage.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting filters or selecting another period.'**
  String get noPurchasesMessage;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @totalPurchases.
  ///
  /// In en, this message translates to:
  /// **'Total Purchases'**
  String get totalPurchases;

  /// Label for purchase date
  ///
  /// In en, this message translates to:
  /// **'Purchase Date'**
  String get purchaseDate;

  /// Button text to view details
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// Status label for partially paid purchases
  ///
  /// In en, this message translates to:
  /// **'Partial'**
  String get statusPartial;

  /// Status label for due purchases
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get statusDue;

  /// No description provided for @purchaseDetails.
  ///
  /// In en, this message translates to:
  /// **'Purchase Details'**
  String get purchaseDetails;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @purchaseDetailsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Purchase Details'**
  String get purchaseDetailsLoadError;

  /// No description provided for @supplierInformation.
  ///
  /// In en, this message translates to:
  /// **'Supplier Information'**
  String get supplierInformation;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @receivedBy.
  ///
  /// In en, this message translates to:
  /// **'Received By'**
  String get receivedBy;

  /// No description provided for @purchaseItems.
  ///
  /// In en, this message translates to:
  /// **'Purchase Items'**
  String get purchaseItems;

  /// Label for product quantity
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @unitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get unitPrice;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @paymentSummary.
  ///
  /// In en, this message translates to:
  /// **'Payment Summary'**
  String get paymentSummary;

  /// Label for subtotal amount
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get subTotal;

  /// Label for discount field
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// Label for paid amount field
  ///
  /// In en, this message translates to:
  /// **'Paid Amount'**
  String get paidAmount;

  /// Label for due amount
  ///
  /// In en, this message translates to:
  /// **'Due Amount'**
  String get dueAmount;

  /// No description provided for @suppliers.
  ///
  /// In en, this message translates to:
  /// **'Suppliers'**
  String get suppliers;

  /// No description provided for @supplierLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Suppliers'**
  String get supplierLoadError;

  /// No description provided for @noSuppliersFound.
  ///
  /// In en, this message translates to:
  /// **'No Suppliers Found'**
  String get noSuppliersFound;

  /// No description provided for @noSuppliersMessage.
  ///
  /// In en, this message translates to:
  /// **'No supplier matches your search.'**
  String get noSuppliersMessage;

  /// No description provided for @searchSupplier.
  ///
  /// In en, this message translates to:
  /// **'Search supplier (English / বাংলা)'**
  String get searchSupplier;

  /// No description provided for @supplierDuesLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Supplier Dues'**
  String get supplierDuesLoadError;

  /// No description provided for @noSupplierDuesFound.
  ///
  /// In en, this message translates to:
  /// **'No Supplier Dues Found'**
  String get noSupplierDuesFound;

  /// No description provided for @noSupplierDuesMessage.
  ///
  /// In en, this message translates to:
  /// **'Currently no supplier has any pending dues.'**
  String get noSupplierDuesMessage;

  /// No description provided for @totalDues.
  ///
  /// In en, this message translates to:
  /// **'Total Dues'**
  String get totalDues;

  /// No description provided for @totalSuppliers.
  ///
  /// In en, this message translates to:
  /// **'Total Suppliers'**
  String get totalSuppliers;

  /// No description provided for @totalPurchasesLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Purchases'**
  String get totalPurchasesLabel;

  /// No description provided for @duePurchases.
  ///
  /// In en, this message translates to:
  /// **'Due Purchases'**
  String get duePurchases;

  /// No description provided for @supplierDueDetails.
  ///
  /// In en, this message translates to:
  /// **'Supplier Due Details'**
  String get supplierDueDetails;

  /// No description provided for @supplierDueDetailsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Supplier Due Details'**
  String get supplierDueDetailsLoadError;

  /// No description provided for @noPurchaseDues.
  ///
  /// In en, this message translates to:
  /// **'No Purchase Dues'**
  String get noPurchaseDues;

  /// No description provided for @noPurchaseDuesMessage.
  ///
  /// In en, this message translates to:
  /// **'This supplier has no outstanding purchase dues.'**
  String get noPurchaseDuesMessage;

  /// No description provided for @totalDueAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Due Amount'**
  String get totalDueAmount;

  /// No description provided for @purchaseDuesTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase Dues'**
  String get purchaseDuesTitle;

  /// No description provided for @statusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statusPaid;

  /// No description provided for @finishedProductsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Finished Products'**
  String get finishedProductsLoadError;

  /// No description provided for @noFinishedProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No Finished Products Found'**
  String get noFinishedProductsFound;

  /// No description provided for @noFinishedProductsMessage.
  ///
  /// In en, this message translates to:
  /// **'Currently no finished product information is available.'**
  String get noFinishedProductsMessage;

  /// Label for unit of measurement
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @employeeLoginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Access your sales updates, schedules, and business activities anytime.'**
  String get employeeLoginWelcome;

  /// No description provided for @deleteExpenseMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this expense?'**
  String get deleteExpenseMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @head.
  ///
  /// In en, this message translates to:
  /// **'Head'**
  String get head;

  /// No description provided for @selectHead.
  ///
  /// In en, this message translates to:
  /// **'Select Head'**
  String get selectHead;

  /// No description provided for @selectHeadSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please choose a head from the list'**
  String get selectHeadSubtitle;

  /// No description provided for @searchHead.
  ///
  /// In en, this message translates to:
  /// **'Search head...'**
  String get searchHead;

  /// No description provided for @expenseLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Expenses'**
  String get expenseLoadError;

  /// No description provided for @noExpensesFound.
  ///
  /// In en, this message translates to:
  /// **'No Expenses Found'**
  String get noExpensesFound;

  /// No description provided for @noExpensesMessage.
  ///
  /// In en, this message translates to:
  /// **'Currently no expense information is available.'**
  String get noExpensesMessage;

  /// No description provided for @switchShop.
  ///
  /// In en, this message translates to:
  /// **'Switch Shop'**
  String get switchShop;

  /// No description provided for @companySalesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View company-wide sales'**
  String get companySalesSubtitle;

  /// No description provided for @companyExpenseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage company expenses'**
  String get companyExpenseSubtitle;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// No description provided for @purchaseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check purchase details'**
  String get purchaseSubtitle;

  /// No description provided for @supplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get supplier;

  /// No description provided for @supplierSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check supplier details'**
  String get supplierSubtitle;

  /// No description provided for @supplierDues.
  ///
  /// In en, this message translates to:
  /// **'Supplier Dues'**
  String get supplierDues;

  /// No description provided for @supplierDuesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check supplier dues'**
  String get supplierDuesSubtitle;

  /// No description provided for @finishedProducts.
  ///
  /// In en, this message translates to:
  /// **'Finished Product Stocks'**
  String get finishedProducts;

  /// No description provided for @finishedProductsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and manage sellable product stocks across branches'**
  String get finishedProductsSubtitle;

  /// No description provided for @companyRawMaterials.
  ///
  /// In en, this message translates to:
  /// **'Company Raw Materials'**
  String get companyRawMaterials;

  /// No description provided for @companyRawMaterialsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monitor raw materials and warehouse inventory'**
  String get companyRawMaterialsSubtitle;

  /// No description provided for @adminLoginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Manage branches, sales, and operations seamlessly from your admin dashboard.'**
  String get adminLoginWelcome;

  /// No description provided for @adminLoginEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get adminLoginEmail;

  /// No description provided for @adminLoginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get adminLoginEmailHint;

  /// No description provided for @adminLoginPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get adminLoginPassword;

  /// No description provided for @adminLoginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get adminLoginPasswordHint;

  /// No description provided for @adminLoginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get adminLoginForgotPassword;

  /// No description provided for @adminLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get adminLoginButton;

  /// No description provided for @chooseUserRoleHeader.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Role'**
  String get chooseUserRoleHeader;

  /// No description provided for @chooseUserRoleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please select the role that best represents how you will use this application.'**
  String get chooseUserRoleSubtitle;

  /// No description provided for @adminRole.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get adminRole;

  /// No description provided for @employeeRole.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get employeeRole;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @furnitureManagementSystem.
  ///
  /// In en, this message translates to:
  /// **'Furniture Management System'**
  String get furnitureManagementSystem;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get quickAccess;

  /// No description provided for @sales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get sales;

  /// No description provided for @salesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track sales and revenue'**
  String get salesSubtitle;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @expenseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monitor expenses and costs'**
  String get expenseSubtitle;

  /// Label for stock quantity
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @stockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check current inventory'**
  String get stockSubtitle;

  /// No description provided for @customerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage customers and profiles'**
  String get customerSubtitle;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @adminLoginHeader.
  ///
  /// In en, this message translates to:
  /// **'Enter Admin PIN'**
  String get adminLoginHeader;

  /// No description provided for @adminLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the administrator PIN provided to access the admin panel securely.'**
  String get adminLoginSubtitle;

  /// No description provided for @adminPinLabel.
  ///
  /// In en, this message translates to:
  /// **'Admin PIN'**
  String get adminPinLabel;

  /// No description provided for @adminLoginError.
  ///
  /// In en, this message translates to:
  /// **'Invalid PIN. Please try again.'**
  String get adminLoginError;

  /// No description provided for @salesSubTitle.
  ///
  /// In en, this message translates to:
  /// **'View sales entries and records'**
  String get salesSubTitle;

  /// No description provided for @purchaseSubTitle.
  ///
  /// In en, this message translates to:
  /// **'View purchase entries and records'**
  String get purchaseSubTitle;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @accountsSubTitle.
  ///
  /// In en, this message translates to:
  /// **'View account balances and dues'**
  String get accountsSubTitle;

  /// No description provided for @administration.
  ///
  /// In en, this message translates to:
  /// **'Administration'**
  String get administration;

  /// No description provided for @administrationSubTitle.
  ///
  /// In en, this message translates to:
  /// **'View products and inventory'**
  String get administrationSubTitle;

  /// No description provided for @hr.
  ///
  /// In en, this message translates to:
  /// **'HR & Payroll'**
  String get hr;

  /// No description provided for @hrSubTitle.
  ///
  /// In en, this message translates to:
  /// **'View staff information and attendance'**
  String get hrSubTitle;

  /// No description provided for @dailyReports.
  ///
  /// In en, this message translates to:
  /// **'Daily Reports'**
  String get dailyReports;

  /// No description provided for @dailyReportsSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Check daily income and expenses'**
  String get dailyReportsSubTitle;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @reportsSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Check monthly and yearly reports'**
  String get reportsSubTitle;

  /// No description provided for @switchShopSubTitle.
  ///
  /// In en, this message translates to:
  /// **'View a different shop'**
  String get switchShopSubTitle;

  /// No description provided for @salesRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Sales Record'**
  String get salesRecordTitle;

  /// No description provided for @salesRecordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all sales entries'**
  String get salesRecordSubtitle;

  /// No description provided for @salesReturnTitle.
  ///
  /// In en, this message translates to:
  /// **'Sales Return'**
  String get salesReturnTitle;

  /// No description provided for @salesReturnSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View returned sales entries'**
  String get salesReturnSubtitle;

  /// No description provided for @stockTitle.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stockTitle;

  /// No description provided for @purchaseRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase Record'**
  String get purchaseRecordTitle;

  /// No description provided for @purchaseRecordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all purchase entries'**
  String get purchaseRecordSubtitle;

  /// No description provided for @purchaseReturnTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase Return'**
  String get purchaseReturnTitle;

  /// No description provided for @purchaseReturnSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View returned purchases'**
  String get purchaseReturnSubtitle;

  /// No description provided for @salaryPaymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Salary Payments'**
  String get salaryPaymentsTitle;

  /// No description provided for @salaryPaymentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View employee salary details'**
  String get salaryPaymentsSubtitle;

  /// No description provided for @employeeListTitle.
  ///
  /// In en, this message translates to:
  /// **'Employee List'**
  String get employeeListTitle;

  /// No description provided for @employeeListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all employees'**
  String get employeeListSubtitle;

  /// No description provided for @productListTitle.
  ///
  /// In en, this message translates to:
  /// **'Product List'**
  String get productListTitle;

  /// No description provided for @productListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all available products'**
  String get productListSubtitle;

  /// No description provided for @damageListTitle.
  ///
  /// In en, this message translates to:
  /// **'Damage List'**
  String get damageListTitle;

  /// No description provided for @damageListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View damaged products'**
  String get damageListSubtitle;

  /// No description provided for @customerListTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer List'**
  String get customerListTitle;

  /// No description provided for @customerListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all customers'**
  String get customerListSubtitle;

  /// No description provided for @supplierListTitle.
  ///
  /// In en, this message translates to:
  /// **'Supplier List'**
  String get supplierListTitle;

  /// No description provided for @supplierListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all suppliers'**
  String get supplierListSubtitle;

  /// No description provided for @productLedgerTitle.
  ///
  /// In en, this message translates to:
  /// **'Product Ledger'**
  String get productLedgerTitle;

  /// No description provided for @productLedgerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View product transaction history'**
  String get productLedgerSubtitle;

  /// No description provided for @bankTransactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Bank Transaction'**
  String get bankTransactionTitle;

  /// No description provided for @bankTransactionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all bank transactions'**
  String get bankTransactionSubtitle;

  /// No description provided for @cashTransactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Cash Transaction'**
  String get cashTransactionTitle;

  /// No description provided for @cashTransactionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all cash transactions'**
  String get cashTransactionSubtitle;

  /// No description provided for @pendingChequeListTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending Cheque List'**
  String get pendingChequeListTitle;

  /// No description provided for @pendingChequeListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all pending cheques'**
  String get pendingChequeListSubtitle;

  /// No description provided for @reminderChequeListTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder Cheque List'**
  String get reminderChequeListTitle;

  /// No description provided for @reminderChequeListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all reminder cheques'**
  String get reminderChequeListSubtitle;

  /// No description provided for @balanceSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Balance Sheet'**
  String get balanceSheetTitle;

  /// No description provided for @balanceSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View overall balance details'**
  String get balanceSheetSubtitle;

  /// No description provided for @additionalPaymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional Payments'**
  String get additionalPaymentsTitle;

  /// No description provided for @additionalPaymentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all additional payments'**
  String get additionalPaymentsSubtitle;

  /// No description provided for @supplierPaymentsReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Supplier Payments'**
  String get supplierPaymentsReportTitle;

  /// No description provided for @supplierPaymentsReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all supplier payments details'**
  String get supplierPaymentsReportSubtitle;

  /// No description provided for @customerPaymentsReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Payments'**
  String get customerPaymentsReportTitle;

  /// No description provided for @customerPaymentsReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all customer payments details'**
  String get customerPaymentsReportSubtitle;

  /// No description provided for @profitLossReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Profit & Loss'**
  String get profitLossReportTitle;

  /// No description provided for @profitLossReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View profit and loss summary'**
  String get profitLossReportSubtitle;

  /// No description provided for @cashPayments.
  ///
  /// In en, this message translates to:
  /// **'Cash Payments'**
  String get cashPayments;

  /// No description provided for @employeePayments.
  ///
  /// In en, this message translates to:
  /// **'Employee Payments'**
  String get employeePayments;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @deducted.
  ///
  /// In en, this message translates to:
  /// **'Deducted'**
  String get deducted;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// Label for customer field
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @selectProduct.
  ///
  /// In en, this message translates to:
  /// **'Select Product'**
  String get selectProduct;

  /// No description provided for @selectSupplier.
  ///
  /// In en, this message translates to:
  /// **'Select Supplier'**
  String get selectSupplier;

  /// No description provided for @purchasePrice.
  ///
  /// In en, this message translates to:
  /// **'Purchase Price'**
  String get purchasePrice;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @returnRate.
  ///
  /// In en, this message translates to:
  /// **'Return Rate'**
  String get returnRate;

  /// No description provided for @returnQuantity.
  ///
  /// In en, this message translates to:
  /// **'Return Quantity'**
  String get returnQuantity;

  /// No description provided for @returnAmount.
  ///
  /// In en, this message translates to:
  /// **'Return Amount'**
  String get returnAmount;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @totalPurchased.
  ///
  /// In en, this message translates to:
  /// **'Total Purchased'**
  String get totalPurchased;

  /// No description provided for @totalSold.
  ///
  /// In en, this message translates to:
  /// **'Total Sold'**
  String get totalSold;

  /// No description provided for @currentStocks.
  ///
  /// In en, this message translates to:
  /// **'Current Stocks'**
  String get currentStocks;

  /// No description provided for @pcs.
  ///
  /// In en, this message translates to:
  /// **'pcs'**
  String get pcs;

  /// No description provided for @searchStocks.
  ///
  /// In en, this message translates to:
  /// **'Search Stocks...'**
  String get searchStocks;

  /// Hint text for product search field
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get searchProducts;

  /// No description provided for @deduction.
  ///
  /// In en, this message translates to:
  /// **'Deduction'**
  String get deduction;

  /// No description provided for @joinDate.
  ///
  /// In en, this message translates to:
  /// **'Join Date'**
  String get joinDate;

  /// No description provided for @salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @txn.
  ///
  /// In en, this message translates to:
  /// **'Txn'**
  String get txn;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @previousDue.
  ///
  /// In en, this message translates to:
  /// **'Previous Due'**
  String get previousDue;

  /// No description provided for @creditLimit.
  ///
  /// In en, this message translates to:
  /// **'Credit Limit'**
  String get creditLimit;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountName;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @issueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue Date'**
  String get issueDate;

  /// No description provided for @reminderDate.
  ///
  /// In en, this message translates to:
  /// **'Reminder Date'**
  String get reminderDate;

  /// No description provided for @submitDate.
  ///
  /// In en, this message translates to:
  /// **'Submit Date'**
  String get submitDate;

  /// No description provided for @chequeNo.
  ///
  /// In en, this message translates to:
  /// **'Cheque No'**
  String get chequeNo;

  /// No description provided for @balanceSheetSummary.
  ///
  /// In en, this message translates to:
  /// **'Balance Sheet Summary'**
  String get balanceSheetSummary;

  /// No description provided for @totalSales.
  ///
  /// In en, this message translates to:
  /// **'Total Sales'**
  String get totalSales;

  /// No description provided for @totalPurchase.
  ///
  /// In en, this message translates to:
  /// **'Total Purchase'**
  String get totalPurchase;

  /// No description provided for @cashReceived.
  ///
  /// In en, this message translates to:
  /// **'Cash Received'**
  String get cashReceived;

  /// No description provided for @cashPaid.
  ///
  /// In en, this message translates to:
  /// **'Cash Paid'**
  String get cashPaid;

  /// No description provided for @bankDeposit.
  ///
  /// In en, this message translates to:
  /// **'Bank Deposit'**
  String get bankDeposit;

  /// No description provided for @bankWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Bank Withdraw'**
  String get bankWithdraw;

  /// No description provided for @supplierPaymentPaid.
  ///
  /// In en, this message translates to:
  /// **'Supplier Payment Paid'**
  String get supplierPaymentPaid;

  /// No description provided for @supplierPaymentReceive.
  ///
  /// In en, this message translates to:
  /// **'Supplier Payment Received'**
  String get supplierPaymentReceive;

  /// No description provided for @customerPaymentPaid.
  ///
  /// In en, this message translates to:
  /// **'Customer Payment Paid'**
  String get customerPaymentPaid;

  /// No description provided for @customerPaymentReceive.
  ///
  /// In en, this message translates to:
  /// **'Customer Payment Received'**
  String get customerPaymentReceive;

  /// No description provided for @employeePayment.
  ///
  /// In en, this message translates to:
  /// **'Employee Payment'**
  String get employeePayment;

  /// No description provided for @cashIn.
  ///
  /// In en, this message translates to:
  /// **'Cash In'**
  String get cashIn;

  /// No description provided for @cashOut.
  ///
  /// In en, this message translates to:
  /// **'Cash Out'**
  String get cashOut;

  /// No description provided for @cashBalance.
  ///
  /// In en, this message translates to:
  /// **'Cash Balance'**
  String get cashBalance;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @purchaseRate.
  ///
  /// In en, this message translates to:
  /// **'Purchase Rate'**
  String get purchaseRate;

  /// No description provided for @transferSales.
  ///
  /// In en, this message translates to:
  /// **'Transfer Sales'**
  String get transferSales;

  /// No description provided for @salesRate.
  ///
  /// In en, this message translates to:
  /// **'Sales Rate'**
  String get salesRate;

  /// No description provided for @transferRate.
  ///
  /// In en, this message translates to:
  /// **'Transfer Rate'**
  String get transferRate;

  /// No description provided for @wholesaleRate.
  ///
  /// In en, this message translates to:
  /// **'Wholesale Rate'**
  String get wholesaleRate;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @inQuantity.
  ///
  /// In en, this message translates to:
  /// **'In'**
  String get inQuantity;

  /// No description provided for @outQuantity.
  ///
  /// In en, this message translates to:
  /// **'Out'**
  String get outQuantity;

  /// No description provided for @profitLossSummary.
  ///
  /// In en, this message translates to:
  /// **'Profit & Loss Summary'**
  String get profitLossSummary;

  /// No description provided for @totalDiscount.
  ///
  /// In en, this message translates to:
  /// **'Total Discount'**
  String get totalDiscount;

  /// No description provided for @totalReturned.
  ///
  /// In en, this message translates to:
  /// **'Total Returned'**
  String get totalReturned;

  /// No description provided for @totalDamaged.
  ///
  /// In en, this message translates to:
  /// **'Total Damaged'**
  String get totalDamaged;

  /// No description provided for @totalCashTransaction.
  ///
  /// In en, this message translates to:
  /// **'Total Cash Transaction'**
  String get totalCashTransaction;

  /// No description provided for @totalEmployeePayment.
  ///
  /// In en, this message translates to:
  /// **'Total Employee Payment'**
  String get totalEmployeePayment;

  /// No description provided for @totalProfit.
  ///
  /// In en, this message translates to:
  /// **'Total Profit'**
  String get totalProfit;

  /// No description provided for @selectSupplierTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Supplier'**
  String get selectSupplierTitle;

  /// No description provided for @selectSupplierSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a supplier from the list'**
  String get selectSupplierSubtitle;

  /// No description provided for @selectSupplierSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search Supplier'**
  String get selectSupplierSearchHint;

  /// Title for customer selection bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Select Customer'**
  String get selectCustomerTitle;

  /// Subtitle for customer selection bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Please choose a customer from the list'**
  String get selectCustomerSubtitle;

  /// No description provided for @selectCustomerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search Customer'**
  String get selectCustomerSearchHint;

  /// No description provided for @selectTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Type'**
  String get selectTypeTitle;

  /// No description provided for @selectTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a type from the list'**
  String get selectTypeSubtitle;

  /// No description provided for @selectTypeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search Type'**
  String get selectTypeSearchHint;

  /// No description provided for @selectBankAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Bank Account'**
  String get selectBankAccountTitle;

  /// No description provided for @selectBankAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a bank account from the list'**
  String get selectBankAccountSubtitle;

  /// No description provided for @selectBankAccountSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search Bank Account'**
  String get selectBankAccountSearchHint;

  /// No description provided for @selectProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Product'**
  String get selectProductTitle;

  /// No description provided for @selectProductSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a product from the list'**
  String get selectProductSubtitle;

  /// No description provided for @selectProductSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search Product'**
  String get selectProductSearchHint;

  /// No description provided for @selectCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategoryTitle;

  /// No description provided for @selectCategorySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search Category'**
  String get selectCategorySearchHint;

  /// No description provided for @totalPurchasesQuantity.
  ///
  /// In en, this message translates to:
  /// **'Total Purchases Quantity'**
  String get totalPurchasesQuantity;

  /// No description provided for @totalSalesQuantity.
  ///
  /// In en, this message translates to:
  /// **'Total Sales Quantity'**
  String get totalSalesQuantity;

  /// No description provided for @totalCurrentQuantity.
  ///
  /// In en, this message translates to:
  /// **'Total Current Quantity'**
  String get totalCurrentQuantity;

  /// No description provided for @totalPurchasesAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Purchases Amount'**
  String get totalPurchasesAmount;

  /// No description provided for @totalSalesAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Sales Amount'**
  String get totalSalesAmount;

  /// Title for create sales page
  ///
  /// In en, this message translates to:
  /// **'Create Sales'**
  String get createSales;

  /// Label for sale date field
  ///
  /// In en, this message translates to:
  /// **'Sale Date'**
  String get saleDate;

  /// Hint text for sale date field
  ///
  /// In en, this message translates to:
  /// **'Select sale date'**
  String get selectSaleDate;

  /// Hint text for customer field
  ///
  /// In en, this message translates to:
  /// **'Select customer'**
  String get selectCustomer;

  /// Hint text for customer search field
  ///
  /// In en, this message translates to:
  /// **'Search customer...'**
  String get searchCustomer;

  /// Label for products section
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// Button text to add products
  ///
  /// In en, this message translates to:
  /// **'Add Products'**
  String get addProducts;

  /// Message when no products are added
  ///
  /// In en, this message translates to:
  /// **'No products added!\n\nTap on the \"Add Products\" button to select products.'**
  String get noProductsAdded;

  /// Label for discount amount
  ///
  /// In en, this message translates to:
  /// **'Discount Amount'**
  String get discountAmount;

  /// Label for payment type field
  ///
  /// In en, this message translates to:
  /// **'Payment Type'**
  String get paymentType;

  /// Hint text for payment type field
  ///
  /// In en, this message translates to:
  /// **'Select payment type'**
  String get selectPaymentType;

  /// Title for payment type selection bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Select Payment Type'**
  String get selectPaymentTypeTitle;

  /// Subtitle for payment type selection bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Please choose a payment type from the list'**
  String get selectPaymentTypeSubtitle;

  /// Hint text for payment type search field
  ///
  /// In en, this message translates to:
  /// **'Search payment type...'**
  String get searchPaymentType;

  /// Label for payment info field
  ///
  /// In en, this message translates to:
  /// **'Payment Info'**
  String get paymentInfo;

  /// Hint text for payment info field
  ///
  /// In en, this message translates to:
  /// **'Transaction ID, Reference, etc. (Optional)'**
  String get paymentInfoHint;

  /// Button text to create sale
  ///
  /// In en, this message translates to:
  /// **'Create Sale'**
  String get createSale;

  /// Error message when customer is not selected
  ///
  /// In en, this message translates to:
  /// **'Please select a customer'**
  String get pleaseSelectCustomer;

  /// Error message when no products are added
  ///
  /// In en, this message translates to:
  /// **'Please add at least one product'**
  String get pleaseAddProduct;

  /// Success message when sale is created
  ///
  /// In en, this message translates to:
  /// **'Sale created successfully'**
  String get saleCreatedSuccess;

  /// Error message for invalid amount
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get invalidAmount;

  /// Error message when discount exceeds subtotal
  ///
  /// In en, this message translates to:
  /// **'Cannot exceed subtotal'**
  String get cannotExceedSubtotal;

  /// Error message when paid amount is not entered
  ///
  /// In en, this message translates to:
  /// **'Paid amount is required'**
  String get paidAmountRequired;

  /// Error message for invalid amount format
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get enterValidAmount;

  /// Error message when paid amount exceeds grand total
  ///
  /// In en, this message translates to:
  /// **'Paid amount cannot exceed grand total'**
  String get paidAmountExceedsTotal;

  /// Payment type: Cash
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// Payment type: QR Code
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qrCode;

  /// Payment type: Debit/Credit Cards
  ///
  /// In en, this message translates to:
  /// **'Debit/Credit Cards'**
  String get debitCreditCards;

  /// Payment type: Digital Wallet
  ///
  /// In en, this message translates to:
  /// **'Digital Wallet'**
  String get digitalWallet;

  /// Title for product selection page
  ///
  /// In en, this message translates to:
  /// **'Select Products'**
  String get selectProducts;

  /// Text showing number of selected items
  ///
  /// In en, this message translates to:
  /// **'selected'**
  String get selected;

  /// Label for all categories filter
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Message when no products are available
  ///
  /// In en, this message translates to:
  /// **'No products available'**
  String get noProductsAvailable;

  /// Button text to add selected items
  ///
  /// In en, this message translates to:
  /// **'Add {count} item'**
  String addItems(int count);

  /// Button text to add multiple selected items
  ///
  /// In en, this message translates to:
  /// **'Add {count} items'**
  String addItemsPlural(int count);

  /// No description provided for @createExpense.
  ///
  /// In en, this message translates to:
  /// **'Create Expense'**
  String get createExpense;

  /// No description provided for @expenseHead.
  ///
  /// In en, this message translates to:
  /// **'Expense Head'**
  String get expenseHead;

  /// No description provided for @selectExpenseHead.
  ///
  /// In en, this message translates to:
  /// **'Select expense head'**
  String get selectExpenseHead;

  /// No description provided for @selectExpenseHeadTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Expense Head'**
  String get selectExpenseHeadTitle;

  /// No description provided for @selectExpenseHeadSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please choose an expense head'**
  String get selectExpenseHeadSubtitle;

  /// No description provided for @searchExpenseHead.
  ///
  /// In en, this message translates to:
  /// **'Search expense head...'**
  String get searchExpenseHead;

  /// No description provided for @expenseDate.
  ///
  /// In en, this message translates to:
  /// **'Expense Date'**
  String get expenseDate;

  /// No description provided for @selectExpenseDate.
  ///
  /// In en, this message translates to:
  /// **'Select expense date'**
  String get selectExpenseDate;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @remarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get remarks;

  /// No description provided for @enterRemarks.
  ///
  /// In en, this message translates to:
  /// **'Enter remarks (Optional)'**
  String get enterRemarks;

  /// No description provided for @expenseCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Expense created successfully'**
  String get expenseCreatedSuccess;

  /// No description provided for @editExpense.
  ///
  /// In en, this message translates to:
  /// **'Edit Expense'**
  String get editExpense;

  /// No description provided for @expenseEditedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Expense edited successfully'**
  String get expenseEditedSuccess;

  /// No description provided for @customers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customers;

  /// No description provided for @failedToLoadCustomers.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Customers'**
  String get failedToLoadCustomers;

  /// No description provided for @noCustomersFound.
  ///
  /// In en, this message translates to:
  /// **'No Customers Found'**
  String get noCustomersFound;

  /// No description provided for @noCustomerMatches.
  ///
  /// In en, this message translates to:
  /// **'No customer matches your search.'**
  String get noCustomerMatches;

  /// No description provided for @searchCustomerPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search customer (English / বাংলা / Phone)'**
  String get searchCustomerPlaceholder;

  /// No description provided for @branch.
  ///
  /// In en, this message translates to:
  /// **'Branch'**
  String get branch;

  /// No description provided for @deleteCustomer.
  ///
  /// In en, this message translates to:
  /// **'Delete Customer'**
  String get deleteCustomer;

  /// No description provided for @deleteCustomerConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this customer?'**
  String get deleteCustomerConfirm;

  /// No description provided for @createCustomer.
  ///
  /// In en, this message translates to:
  /// **'Create Customer'**
  String get createCustomer;

  /// No description provided for @addCustomer.
  ///
  /// In en, this message translates to:
  /// **'Add Customer'**
  String get addCustomer;

  /// No description provided for @editCustomer.
  ///
  /// In en, this message translates to:
  /// **'Edit Customer'**
  String get editCustomer;

  /// No description provided for @enterCustomerName.
  ///
  /// In en, this message translates to:
  /// **'Enter customer name'**
  String get enterCustomerName;

  /// No description provided for @nameBangla.
  ///
  /// In en, this message translates to:
  /// **'Name (Bangla)'**
  String get nameBangla;

  /// No description provided for @enterCustomerNameBangla.
  ///
  /// In en, this message translates to:
  /// **'Enter customer name in Bangla'**
  String get enterCustomerNameBangla;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @enterEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get enterEmailAddress;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter address'**
  String get enterAddress;

  /// No description provided for @customerCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Customer created successfully'**
  String get customerCreatedSuccess;

  /// No description provided for @customerEditedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Customer edited successfully'**
  String get customerEditedSuccess;

  /// No description provided for @customerDues.
  ///
  /// In en, this message translates to:
  /// **'Customer Dues'**
  String get customerDues;

  /// No description provided for @failedToLoadCustomerDues.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Customer Dues'**
  String get failedToLoadCustomerDues;

  /// No description provided for @noCustomerDuesFound.
  ///
  /// In en, this message translates to:
  /// **'No Customer Dues Found'**
  String get noCustomerDuesFound;

  /// No description provided for @noCustomerDuesMessage.
  ///
  /// In en, this message translates to:
  /// **'Currently no customer has any pending dues.'**
  String get noCustomerDuesMessage;

  /// No description provided for @totalCustomers.
  ///
  /// In en, this message translates to:
  /// **'Total Customers'**
  String get totalCustomers;

  /// No description provided for @dueSales.
  ///
  /// In en, this message translates to:
  /// **'Due Sales'**
  String get dueSales;

  /// No description provided for @failedToLoadPurchaseDues.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Purchase Dues'**
  String get failedToLoadPurchaseDues;

  /// No description provided for @noDueSalesFound.
  ///
  /// In en, this message translates to:
  /// **'No Due Sales Found'**
  String get noDueSalesFound;

  /// No description provided for @noDueSalesMessage.
  ///
  /// In en, this message translates to:
  /// **'This customer has no pending due payments.'**
  String get noDueSalesMessage;

  /// No description provided for @totalDue.
  ///
  /// In en, this message translates to:
  /// **'Total Due'**
  String get totalDue;

  /// No description provided for @payDue.
  ///
  /// In en, this message translates to:
  /// **'Pay Due'**
  String get payDue;

  /// No description provided for @duePayment.
  ///
  /// In en, this message translates to:
  /// **'Due Payment'**
  String get duePayment;

  /// No description provided for @paymentDate.
  ///
  /// In en, this message translates to:
  /// **'Payment Date'**
  String get paymentDate;

  /// No description provided for @selectPaymentDate.
  ///
  /// In en, this message translates to:
  /// **'Select payment date'**
  String get selectPaymentDate;

  /// No description provided for @paymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Payment Amount'**
  String get paymentAmount;

  /// No description provided for @paymentAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'Payment amount is required'**
  String get paymentAmountRequired;

  /// No description provided for @amountGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than 0'**
  String get amountGreaterThanZero;

  /// No description provided for @amountCannotExceedDue.
  ///
  /// In en, this message translates to:
  /// **'Amount cannot exceed due amount'**
  String get amountCannotExceedDue;

  /// No description provided for @transactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionId;

  /// No description provided for @transactionIdHint.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID, Reference, etc. (Optional)'**
  String get transactionIdHint;

  /// No description provided for @payingAmount.
  ///
  /// In en, this message translates to:
  /// **'Paying Amount'**
  String get payingAmount;

  /// No description provided for @remainingDue.
  ///
  /// In en, this message translates to:
  /// **'Remaining Due'**
  String get remainingDue;

  /// No description provided for @submitPayment.
  ///
  /// In en, this message translates to:
  /// **'Submit Payment'**
  String get submitPayment;

  /// No description provided for @saleInformation.
  ///
  /// In en, this message translates to:
  /// **'Sale Information'**
  String get saleInformation;

  /// No description provided for @manageCustomerDues.
  ///
  /// In en, this message translates to:
  /// **'Manage customer dues'**
  String get manageCustomerDues;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// No description provided for @salesDetails.
  ///
  /// In en, this message translates to:
  /// **'Sales Details'**
  String get salesDetails;

  /// No description provided for @salesDetailsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Sales Details'**
  String get salesDetailsLoadError;

  /// No description provided for @customerInformation.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get customerInformation;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created By'**
  String get createdBy;

  /// No description provided for @saleItems.
  ///
  /// In en, this message translates to:
  /// **'Sale Items'**
  String get saleItems;

  /// No description provided for @failedToLoadStock.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Stock'**
  String get failedToLoadStock;

  /// No description provided for @noStockFound.
  ///
  /// In en, this message translates to:
  /// **'No Stock Found'**
  String get noStockFound;

  /// No description provided for @noStockAvailable.
  ///
  /// In en, this message translates to:
  /// **'Currently no stock information is available.'**
  String get noStockAvailable;

  /// No description provided for @searchStock.
  ///
  /// In en, this message translates to:
  /// **'Search by product name or category...'**
  String get searchStock;

  /// No description provided for @customOrders.
  ///
  /// In en, this message translates to:
  /// **'Custom Orders'**
  String get customOrders;

  /// No description provided for @noCustomOrdersFound.
  ///
  /// In en, this message translates to:
  /// **'No Custom Orders Found'**
  String get noCustomOrdersFound;

  /// No description provided for @noCustomOrdersMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any custom orders for the selected filters. Try adjusting your date range or status.'**
  String get noCustomOrdersMessage;

  /// No description provided for @expectedDelivery.
  ///
  /// In en, this message translates to:
  /// **'Expected Delivery'**
  String get expectedDelivery;

  /// No description provided for @amountRequired.
  ///
  /// In en, this message translates to:
  /// **'Amount is required'**
  String get amountRequired;

  /// No description provided for @amountExceedsDue.
  ///
  /// In en, this message translates to:
  /// **'Amount cannot exceed the due amount'**
  String get amountExceedsDue;

  /// No description provided for @selectStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Status'**
  String get selectStatusTitle;

  /// No description provided for @selectStatusSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose an order status to filter'**
  String get selectStatusSubtitle;

  /// No description provided for @searchStatus.
  ///
  /// In en, this message translates to:
  /// **'Search status...'**
  String get searchStatus;

  /// No description provided for @statusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get statusProcessing;

  /// No description provided for @customOrderDetails.
  ///
  /// In en, this message translates to:
  /// **'Custom Order Details'**
  String get customOrderDetails;

  /// No description provided for @deliveryInformation.
  ///
  /// In en, this message translates to:
  /// **'Delivery Information'**
  String get deliveryInformation;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @orderItems.
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get orderItems;

  /// No description provided for @actualDelivery.
  ///
  /// In en, this message translates to:
  /// **'Actual Delivery'**
  String get actualDelivery;

  /// No description provided for @orderedQuantity.
  ///
  /// In en, this message translates to:
  /// **'Ordered Qty'**
  String get orderedQuantity;

  /// No description provided for @customOrderDuePayment.
  ///
  /// In en, this message translates to:
  /// **'Custom Order Due Payment'**
  String get customOrderDuePayment;

  /// No description provided for @orderInformation.
  ///
  /// In en, this message translates to:
  /// **'Order Information'**
  String get orderInformation;

  /// No description provided for @customOrderTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom Order'**
  String get customOrderTitle;

  /// No description provided for @customOrderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage custom order'**
  String get customOrderSubtitle;

  /// No description provided for @createCustomOrder.
  ///
  /// In en, this message translates to:
  /// **'Create Custom Order'**
  String get createCustomOrder;

  /// No description provided for @orderDate.
  ///
  /// In en, this message translates to:
  /// **'Order Date'**
  String get orderDate;

  /// No description provided for @selectOrderDate.
  ///
  /// In en, this message translates to:
  /// **'Select order date'**
  String get selectOrderDate;

  /// No description provided for @selectExpectedDelivery.
  ///
  /// In en, this message translates to:
  /// **'Select expected delivery date'**
  String get selectExpectedDelivery;

  /// No description provided for @enterDeliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter delivery address'**
  String get enterDeliveryAddress;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @enterNotes.
  ///
  /// In en, this message translates to:
  /// **'e.g. Urgent delivery needed'**
  String get enterNotes;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @editItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get editItem;

  /// No description provided for @updateItem.
  ///
  /// In en, this message translates to:
  /// **'Update Item'**
  String get updateItem;

  /// No description provided for @noItemsAdded.
  ///
  /// In en, this message translates to:
  /// **'No items added yet'**
  String get noItemsAdded;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @enterProductName.
  ///
  /// In en, this message translates to:
  /// **'e.g. Custom Wedding Dress'**
  String get enterProductName;

  /// No description provided for @itemImage.
  ///
  /// In en, this message translates to:
  /// **'Item Image (Optional)'**
  String get itemImage;

  /// No description provided for @tapToUploadImage.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload image'**
  String get tapToUploadImage;

  /// No description provided for @pricingSummary.
  ///
  /// In en, this message translates to:
  /// **'Pricing Summary'**
  String get pricingSummary;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get required;

  /// No description provided for @selectImageSource.
  ///
  /// In en, this message translates to:
  /// **'Select Image Source'**
  String get selectImageSource;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @totalQuantity.
  ///
  /// In en, this message translates to:
  /// **'Total Quantity'**
  String get totalQuantity;

  /// No description provided for @searchFinishedProducts.
  ///
  /// In en, this message translates to:
  /// **'Search finished products'**
  String get searchFinishedProducts;

  /// No description provided for @productTransfer.
  ///
  /// In en, this message translates to:
  /// **'Product Transfer'**
  String get productTransfer;

  /// No description provided for @productTransfers.
  ///
  /// In en, this message translates to:
  /// **'Product Transfers'**
  String get productTransfers;

  /// No description provided for @transferDetails.
  ///
  /// In en, this message translates to:
  /// **'Transfer Details'**
  String get transferDetails;

  /// No description provided for @transferLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Transfers'**
  String get transferLoadError;

  /// No description provided for @transferDetailsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Transfer Details'**
  String get transferDetailsLoadError;

  /// No description provided for @noTransfersFound.
  ///
  /// In en, this message translates to:
  /// **'No Transfers Found'**
  String get noTransfersFound;

  /// No description provided for @noTransfersMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any transfer records for the selected date range. Try adjusting your filters or selecting a different time period.'**
  String get noTransfersMessage;

  /// No description provided for @totalTransferAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Transfer Amount'**
  String get totalTransferAmount;

  /// No description provided for @totalTransferQuantity.
  ///
  /// In en, this message translates to:
  /// **'Total Transfer Quantity'**
  String get totalTransferQuantity;

  /// No description provided for @fromLocation.
  ///
  /// In en, this message translates to:
  /// **'From Location'**
  String get fromLocation;

  /// No description provided for @toBranch.
  ///
  /// In en, this message translates to:
  /// **'To Branch'**
  String get toBranch;

  /// No description provided for @transferItems.
  ///
  /// In en, this message translates to:
  /// **'Transfer Items'**
  String get transferItems;

  /// No description provided for @transferSummary.
  ///
  /// In en, this message translates to:
  /// **'Transfer Summary'**
  String get transferSummary;

  /// No description provided for @productTransferSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage product transfers'**
  String get productTransferSubtitle;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @failedToLoadProduct.
  ///
  /// In en, this message translates to:
  /// **'Failed to load products'**
  String get failedToLoadProduct;

  /// No description provided for @noProductFound.
  ///
  /// In en, this message translates to:
  /// **'No Product Found'**
  String get noProductFound;

  /// No description provided for @noProductAvailable.
  ///
  /// In en, this message translates to:
  /// **'No products available'**
  String get noProductAvailable;

  /// No description provided for @productPurchasePrice.
  ///
  /// In en, this message translates to:
  /// **'Product Purchase/Production Price'**
  String get productPurchasePrice;

  /// No description provided for @productPurchase.
  ///
  /// In en, this message translates to:
  /// **'Product Purchase'**
  String get productPurchase;

  /// No description provided for @productSales.
  ///
  /// In en, this message translates to:
  /// **'Product Sales'**
  String get productSales;

  /// No description provided for @pendingAmount.
  ///
  /// In en, this message translates to:
  /// **'Pending Amount'**
  String get pendingAmount;

  /// No description provided for @pendingOrders.
  ///
  /// In en, this message translates to:
  /// **'Pending Orders'**
  String get pendingOrders;

  /// No description provided for @deliveredAmount.
  ///
  /// In en, this message translates to:
  /// **'Delivered Amount'**
  String get deliveredAmount;

  /// No description provided for @deliveredOrders.
  ///
  /// In en, this message translates to:
  /// **'Delivered Orders'**
  String get deliveredOrders;

  /// No description provided for @profitLoss.
  ///
  /// In en, this message translates to:
  /// **'Profit & Loss'**
  String get profitLoss;

  /// No description provided for @salesOverview.
  ///
  /// In en, this message translates to:
  /// **'Sales Overview'**
  String get salesOverview;

  /// No description provided for @costOverview.
  ///
  /// In en, this message translates to:
  /// **'Cost Overview'**
  String get costOverview;

  /// No description provided for @expenseOverview.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenseOverview;

  /// No description provided for @totalSalesReturn.
  ///
  /// In en, this message translates to:
  /// **'Sales Return'**
  String get totalSalesReturn;

  /// No description provided for @netSales.
  ///
  /// In en, this message translates to:
  /// **'Net Sales'**
  String get netSales;

  /// No description provided for @totalPurchaseCost.
  ///
  /// In en, this message translates to:
  /// **'Total Purchase Cost'**
  String get totalPurchaseCost;

  /// No description provided for @grossProfit.
  ///
  /// In en, this message translates to:
  /// **'Gross Profit'**
  String get grossProfit;

  /// No description provided for @totalExpenses.
  ///
  /// In en, this message translates to:
  /// **'Total Expenses'**
  String get totalExpenses;

  /// No description provided for @netProfit.
  ///
  /// In en, this message translates to:
  /// **'Net Profit'**
  String get netProfit;

  /// No description provided for @netLoss.
  ///
  /// In en, this message translates to:
  /// **'Net Loss'**
  String get netLoss;

  /// No description provided for @noProfitLossFound.
  ///
  /// In en, this message translates to:
  /// **'No Data Found'**
  String get noProfitLossFound;

  /// No description provided for @noProfitLossMessage.
  ///
  /// In en, this message translates to:
  /// **'No profit/loss data found for the selected date range. Try adjusting your filters.'**
  String get noProfitLossMessage;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @costs.
  ///
  /// In en, this message translates to:
  /// **'Costs'**
  String get costs;

  /// No description provided for @profit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get profit;

  /// No description provided for @salesReturn.
  ///
  /// In en, this message translates to:
  /// **'Sales Return'**
  String get salesReturn;

  /// No description provided for @rawMaterials.
  ///
  /// In en, this message translates to:
  /// **'Raw Materials'**
  String get rawMaterials;

  /// No description provided for @rawMaterialsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Raw Materials'**
  String get rawMaterialsLoadError;

  /// No description provided for @noRawMaterialsFound.
  ///
  /// In en, this message translates to:
  /// **'No Raw Materials Found'**
  String get noRawMaterialsFound;

  /// No description provided for @noRawMaterialsMessage.
  ///
  /// In en, this message translates to:
  /// **'Currently no raw material information is available.'**
  String get noRawMaterialsMessage;

  /// No description provided for @searchRawMaterials.
  ///
  /// In en, this message translates to:
  /// **'Search raw materials...'**
  String get searchRawMaterials;

  /// No description provided for @fixedProductions.
  ///
  /// In en, this message translates to:
  /// **'Fixed Productions'**
  String get fixedProductions;

  /// No description provided for @fixedProductionsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Fixed Productions'**
  String get fixedProductionsLoadError;

  /// No description provided for @noFixedProductionsFound.
  ///
  /// In en, this message translates to:
  /// **'No Fixed Productions Found'**
  String get noFixedProductionsFound;

  /// No description provided for @noFixedProductionsMessage.
  ///
  /// In en, this message translates to:
  /// **'No fixed production data available for the selected period.'**
  String get noFixedProductionsMessage;

  /// No description provided for @bomNumber.
  ///
  /// In en, this message translates to:
  /// **'BOM Number'**
  String get bomNumber;

  /// No description provided for @recipeNumber.
  ///
  /// In en, this message translates to:
  /// **'Recipe Number'**
  String get recipeNumber;

  /// No description provided for @recipeVersion.
  ///
  /// In en, this message translates to:
  /// **'Recipe Version'**
  String get recipeVersion;

  /// No description provided for @materialsCount.
  ///
  /// In en, this message translates to:
  /// **'Materials Count'**
  String get materialsCount;

  /// No description provided for @totalMaterialCost.
  ///
  /// In en, this message translates to:
  /// **'Total Material Cost'**
  String get totalMaterialCost;

  /// No description provided for @totalBoms.
  ///
  /// In en, this message translates to:
  /// **'Total BOMs'**
  String get totalBoms;

  /// No description provided for @totalMaterialsUsed.
  ///
  /// In en, this message translates to:
  /// **'Total Materials Used'**
  String get totalMaterialsUsed;

  /// No description provided for @customProductions.
  ///
  /// In en, this message translates to:
  /// **'Custom Productions'**
  String get customProductions;

  /// No description provided for @customProductionsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Custom Productions'**
  String get customProductionsLoadError;

  /// No description provided for @noCustomProductionsFound.
  ///
  /// In en, this message translates to:
  /// **'No Custom Productions Found'**
  String get noCustomProductionsFound;

  /// No description provided for @noCustomProductionsMessage.
  ///
  /// In en, this message translates to:
  /// **'No custom production data available for the selected period.'**
  String get noCustomProductionsMessage;

  /// No description provided for @customProductionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all custom production records'**
  String get customProductionsSubtitle;

  /// No description provided for @fixedProductionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all fixed production records'**
  String get fixedProductionsSubtitle;

  /// No description provided for @stockRegister.
  ///
  /// In en, this message translates to:
  /// **'Stock Register'**
  String get stockRegister;

  /// No description provided for @stockRegisterLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Stock Register'**
  String get stockRegisterLoadError;

  /// No description provided for @noStockRegisterFound.
  ///
  /// In en, this message translates to:
  /// **'No Stock Register Found'**
  String get noStockRegisterFound;

  /// No description provided for @noStockRegisterMessage.
  ///
  /// In en, this message translates to:
  /// **'No stock movement data available for this product.'**
  String get noStockRegisterMessage;

  /// No description provided for @currentStock.
  ///
  /// In en, this message translates to:
  /// **'Current Stock'**
  String get currentStock;

  /// No description provided for @movements.
  ///
  /// In en, this message translates to:
  /// **'Movements'**
  String get movements;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get reference;

  /// No description provided for @balanceAfter.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balanceAfter;

  /// No description provided for @totalIn.
  ///
  /// In en, this message translates to:
  /// **'Total In'**
  String get totalIn;

  /// No description provided for @totalOut.
  ///
  /// In en, this message translates to:
  /// **'Total Out'**
  String get totalOut;

  /// No description provided for @stockMovementType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get stockMovementType;

  /// No description provided for @selectBranch.
  ///
  /// In en, this message translates to:
  /// **'Select Branch'**
  String get selectBranch;

  /// No description provided for @selectBranchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a branch from the list'**
  String get selectBranchSubtitle;

  /// No description provided for @searchBranch.
  ///
  /// In en, this message translates to:
  /// **'Search Branch'**
  String get searchBranch;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn': return AppLocalizationsBn();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
