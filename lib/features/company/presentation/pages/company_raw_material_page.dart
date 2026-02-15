import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/company/presentation/blocs/company_raw_material/company_raw_material_bloc.dart';
import 'package:smart_furniture/features/company/presentation/widgets/company_raw_material_card.dart';

class CompanyRawMaterialPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const CompanyRawMaterialPage());

  const CompanyRawMaterialPage({super.key});

  @override
  State<CompanyRawMaterialPage> createState() => _CompanyRawMaterialPageState();
}

class _CompanyRawMaterialPageState extends State<CompanyRawMaterialPage> {
  @override
  void initState() {
    super.initState();
    _fetchCompanyRawMaterials();
  }

  void _fetchCompanyRawMaterials() {
    context.read<CompanyRawMaterialBloc>().add(LoadCompanyRawMaterialsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raw Materials'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<CompanyRawMaterialBloc, CompanyRawMaterialState>(
          listener: (context, state) {
            if (state is CompanyRawMaterialError) {
              AppNotifier.showToast(state.message, type: MessageType.error);
            }
          },
          builder: (context, state) {
            if (state is CompanyRawMaterialLoading) {
              return const Loader();
            }

            if (state is CompanyRawMaterialError) {
              return const ErrorStateWidget(
                title: 'Failed to Load Raw Materials',
                message: ErrorMessages.networkError,
              );
            }

            if (state is CompanyRawMaterialLoaded) {
              if (state.rawMaterials.isEmpty) {
                return const EmptyStateWidget(
                  title: 'No Raw Materials Found',
                  message: 'Currently no raw material information is available.',
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.rawMaterials.length,
                itemBuilder: (context, index) {
                  return CompanyRawMaterialCard(
                    rawMaterial: state.rawMaterials[index],
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}