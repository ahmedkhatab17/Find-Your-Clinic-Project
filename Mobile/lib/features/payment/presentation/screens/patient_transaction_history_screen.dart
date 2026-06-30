import 'package:flutter/material.dart';
import '../../../../core/di/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../cubits/payment_history_cubit.dart';
import '../widgets/transaction_tile.dart';

class PatientTransactionHistoryScreen extends StatelessWidget {
  const PatientTransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PaymentHistoryCubit>()..load(),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.transactionHistoryTitle),
        centerTitle: true,
      ),
      body: BlocBuilder<PaymentHistoryCubit, PaymentHistoryState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => context.read<PaymentHistoryCubit>().refresh(),
            child: switch (state) {
              PaymentHistoryInitial() ||
              PaymentHistoryLoading() =>
                const TransactionListSkeleton(),
              PaymentHistoryError(:final message) => ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ErrorView(
                        message: message,
                        onRetry: () =>
                            context.read<PaymentHistoryCubit>().refresh(),
                      ),
                    ),
                  ],
                ),
              PaymentHistoryLoaded(:final transactions) =>
                transactions.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: EmptyStateView(
                              icon: Icons.receipt_long_outlined,
                              title: context.l10n.noTransactions,
                              subtitle:
                                  'Your payments and receipts will appear here.', // Could also add this to arb later
                            ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 24),
                        itemCount: transactions.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, i) => TransactionTile(
                          tx: transactions[i],
                          isPatient: true,
                          receiptRoute: '/patient/payments/receipt',
                        ),
                      ),
            },
          );
        },
      ),
    );
  }
}
