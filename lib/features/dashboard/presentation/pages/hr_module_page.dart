// import 'package:flutter/material.dart';
// import 'package:smart_furniture/features/dashboard/data/datasources/hr_module_local_data_source.dart';
// import 'package:smart_furniture/features/dashboard/presentation/widgets/sub_module_tile.dart';
// import 'package:smart_furniture/l10n/app_localizations.dart';
//
// class HrModulePage extends StatelessWidget {
//   static Route route() => MaterialPageRoute(builder: (context) => const HrModulePage());
//
//   const HrModulePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final hrModules = HrModuleLocalDataSource.getHrModules(context);
//     final strings = AppLocalizations.of(context)!;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(strings.hr),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: ListView.separated(
//           itemCount: hrModules.length,
//           separatorBuilder: (_, __) => const SizedBox(height: 16),
//           itemBuilder: (context, index) {
//             final module = hrModules[index];
//             return SubModuleTile(module: module);
//           },
//         ),
//       ),
//     );
//   }
// }
