// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_furniture/core/constants/error_messages.dart';
// import 'package:smart_furniture/core/utils/enums/message_type.dart';
// import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
// import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
// import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
// import 'package:smart_furniture/core/utils/widgets/loader.dart';
// import 'package:smart_furniture/features/accounts/presentation/blocs/reminder_cheque_list/reminder_cheque_list_bloc.dart';
// import 'package:smart_furniture/features/accounts/presentation/widgets/reminder_cheque_card.dart';
// import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';
// import 'package:smart_furniture/l10n/app_localizations.dart';
//
// class ReminderChequeListPage extends StatefulWidget {
//   static Route route() => MaterialPageRoute(builder: (context) => const ReminderChequeListPage());
//
//   const ReminderChequeListPage({super.key});
//
//   @override
//   State<ReminderChequeListPage> createState() => _ReminderChequeListPageState();
// }
//
// class _ReminderChequeListPageState extends State<ReminderChequeListPage> {
//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }
//
//   void _fetchData() {
//     final selectedShop = context.read<ShopSelectionCubit>().state;
//     if (selectedShop != null) {
//       context.read<ReminderChequeListBloc>().add(
//         LoadReminderChequeListEvent(selectedShop.name),
//       );
//     } else {
//       AppNotifier.showToast(ErrorMessages.unknownError, type: MessageType.error);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final strings = AppLocalizations.of(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(strings!.reminderChequeListTitle),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: BlocConsumer<ReminderChequeListBloc, ReminderChequeListState>(
//                   listener: (context, state) {
//                     if (state is ReminderChequeListError) {
//                       AppNotifier.showToast(state.message, type: MessageType.error);
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is ReminderChequeListLoading) {
//                       return const Loader();
//                     }
//                     if (state is ReminderChequeListError) {
//                       return const ErrorStateWidget(
//                         title: 'Failed to Load Reminder Cheques',
//                         message: ErrorMessages.networkError,
//                       );
//                     }
//                     if (state is ReminderChequeListLoaded) {
//                       if (state.reminderChequeListModel.data?.isEmpty ?? true) {
//                         return const EmptyStateWidget(
//                           title: 'No Reminder Cheques Found',
//                           message: 'There are currently no reminder cheques available.',
//                         );
//                       } else {
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: state.reminderChequeListModel.data?.length ?? 0,
//                           itemBuilder: (context, index) {
//                             final reminderCheque = state.reminderChequeListModel.data![index];
//                             return ReminderChequeCard(chequeData: reminderCheque);
//                           },
//                         );
//                       }
//                     }
//                     return const SizedBox.shrink();
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
