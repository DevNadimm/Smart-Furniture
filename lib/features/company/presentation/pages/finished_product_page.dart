import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/company/presentation/blocs/finished_product/finished_product_bloc.dart';
import 'package:smart_furniture/features/company/presentation/widgets/finished_product_card.dart';

class FinishedProductPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const FinishedProductPage());

  const FinishedProductPage({super.key});

  @override
  State<FinishedProductPage> createState() => _FinishedProductPageState();
}

class _FinishedProductPageState extends State<FinishedProductPage> {
  @override
  void initState() {
    super.initState();
    _fetchFinishedProducts();
  }

  void _fetchFinishedProducts() {
    context.read<FinishedProductBloc>().add(LoadFinishedProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finished Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<FinishedProductBloc, FinishedProductState>(
          listener: (context, state) {
            if (state is FinishedProductError) {
              AppNotifier.showToast(state.message, type: MessageType.error);
            }
          },
          builder: (context, state) {
            if (state is FinishedProductLoading) {
              return const Loader();
            }

            if (state is FinishedProductError) {
              return const ErrorStateWidget(
                title: 'Failed to Load Finished Products',
                message: ErrorMessages.networkError,
              );
            }

            if (state is FinishedProductLoaded) {
              if (state.finishedProducts.isEmpty) {
                return const EmptyStateWidget(
                  title: 'No Finished Products Found',
                  message: 'Currently no finished product information is available.',
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.finishedProducts.length,
                itemBuilder: (context, index) {
                  return FinishedProductCard(
                    finishedProduct: state.finishedProducts[index],
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