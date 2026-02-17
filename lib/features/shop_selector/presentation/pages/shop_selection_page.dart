import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/company_dashboard_page.dart';
import 'package:smart_furniture/features/shop_selector/data/models/branch_model.dart';
import 'package:smart_furniture/features/shop_selector/domain/entities/shop.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/branch_bloc.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';
import 'package:smart_furniture/features/shop_selector/presentation/widgets/shop_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class ShopSelectionPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const ShopSelectionPage());

  const ShopSelectionPage({super.key});

  @override
  State<ShopSelectionPage> createState() => _ShopSelectionPageState();
}

class _ShopSelectionPageState extends State<ShopSelectionPage> {
  @override
  void initState() {
    super.initState();
    context.read<BranchBloc>().add(LoadBranchesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, strings),
              const SizedBox(height: 24),

              /// CONTENT
              Expanded(
                child: BlocConsumer<BranchBloc, BranchState>(
                  listener: (context, state) {
                    if (state is BranchError) {
                      AppNotifier.showToast(
                        state.message,
                        type: MessageType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is BranchLoading) {
                      return const Center(child: Loader());
                    }

                    if (state is BranchError) {
                      return ErrorStateWidget(
                        title: 'Failed to Load Branches',
                        message: state.message,
                      );
                    }

                    if (state is BranchLoaded) {
                      final branches = state.branches?.branches ?? [];

                      if (branches.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Branches Found',
                          message: "We couldn't find any branches. Please try again later.",
                        );
                      }

                      return _buildShopGrid(context, branches);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),

              const SizedBox(height: 12),

              /// NEXT BUTTON
              _buildNextButton(context, strings),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // HEADER
  // ----------------------------------------------------------

  Widget _buildHeader(BuildContext context, AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          strings.selectShopTitle,
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          strings.selectShopSubtitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // GRID
  // ----------------------------------------------------------

  Widget _buildShopGrid(
      BuildContext context, List<BranchData> branches) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// BRANCH GRID
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.15,
            ),
            itemCount: branches.length,
            itemBuilder: (context, index) {
              return ShopCard(branch: branches[index]);
            },
          ),

          const SizedBox(height: 20),

          /// FULL WIDTH COMPANY CARD
          _companyCard(context),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // COMPANY CARD
  // ----------------------------------------------------------

  Widget _companyCard(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          width: 1.4,
          color: AppColors.borderColor,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardColor,
            blurRadius: 20,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CompanyDashboardPage()));
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                    AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.asset(
                    AppImages.store,
                    color: AppColors.primaryColor,
                    scale: 5,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Text(
                    strings.company,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),

                const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // NEXT BUTTON
  // ----------------------------------------------------------

  Widget _buildNextButton(BuildContext context, AppLocalizations strings) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<ShopSelectionCubit, BranchData?>(
        builder: (context, selectedBranch) {
          return ElevatedButton.icon(
            icon: const Icon(HugeIcons.strokeRoundedArrowRight02),
            iconAlignment: IconAlignment.end,
            label: Text(strings.nextScreenBtn),
            onPressed: selectedBranch == null
                ? null
                : () {
                    final shop = ShopModel.fromBranchData(selectedBranch);

                    Navigator.pushAndRemoveUntil(
                      context,
                      DashboardPage.route(shop: shop),
                      (_) => false,
                    );
                  },
          );
        },
      ),
    );
  }
}
