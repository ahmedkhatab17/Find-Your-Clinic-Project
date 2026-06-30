import 'package:find_your_clinic/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../cubits/health_record_cubit.dart';
import '../cubits/health_record_state.dart';

class HealthRecordDetailScreen extends StatelessWidget {
  final String recordId;

  const HealthRecordDetailScreen({super.key, required this.recordId});


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final typeLabels = <String, String>{
      'bloodPressure': context.l10n.typeBloodPressure,
      'heartRate': context.l10n.typeHeartRate,
      'labResult': context.l10n.typeLabResult,
      'prescription': context.l10n.typePrescription,
      'other': context.l10n.typeOther,
      'bloodTest': context.l10n.typeBloodTest,
      'radiology': context.l10n.typeRadiology,
      'vaccination': context.l10n.typeVaccination,
      'bloodSugar': context.l10n.typeBloodSugar,
      'temperature': context.l10n.typeTemperature,
      'weight': context.l10n.typeWeight,
      'spO2': context.l10n.typeSpO2,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.recordDetail),
        actions: [
          BlocBuilder<HealthRecordCubit, HealthRecordState>(
            builder: (context, state) {
              if (state is! HealthRecordDetailLoaded) return const SizedBox();
              final record = state.record;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Semantics(
                    label: 'Edit ${record.title}',
                    child: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      tooltip: context.l10n.editTooltip,
                      onPressed: () async {
                        await context.pushNamed(
                          RouteNames.addHealthRecord,
                          extra: record,
                        );
                        if (context.mounted) {
                          context
                              .read<HealthRecordCubit>()
                              .loadRecordDetail(recordId);
                        }
                      },
                    ),
                  ),
                  Semantics(
                    label: 'Delete ${record.title}',
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: context.l10n.deleteTooltip,
                      color: Colors.red.shade400,
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(context.l10n.deleteRecordQ),
                            content: Text(
                                context.l10n.removeRecordPermanent(record.title)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: Text(context.l10n.cancelButton),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: Text(
                                  context.l10n.delete,
                                  style:
                                      TextStyle(color: Colors.red.shade400),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true && context.mounted) {
                          await context
                              .read<HealthRecordCubit>()
                              .deleteRecord(record.id);
                          if (context.mounted) context.pop();
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<HealthRecordCubit, HealthRecordState>(
        listener: (context, state) {
          if (state is HealthRecordActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is HealthRecordLoading || state is HealthRecordInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HealthRecordError) {
            return Center(child: Text(state.message));
          }

          if (state is HealthRecordDetailLoaded) {
            final record = state.record;
            final typeLabel = typeLabels[record.type.name] ?? record.type.name;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      typeLabel,
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    record.title,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (record.value != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          record.value!,
                          style: textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        if (record.unit != null) ...[
                          const SizedBox(width: 6),
                          Text(
                            record.unit!,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  _DetailRow(
                    icon: Icons.calendar_today_outlined,
                    label: context.l10n.recorded,
                    value: DateFormat('MMMM d, y')
                        .format(record.recordedAt.toLocal()),
                  ),
                  if (record.notes != null && record.notes!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.notes,
                      style: textTheme.labelLarge?.copyWith(
                        color:
                            colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(record.notes!, style: textTheme.bodyMedium),
                  ],
                  if (record.fileUrl != null && record.fileUrl!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(
                      context.l10n.attachmentTitle,
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _AttachmentPreview(
                      url: record.fileUrl!,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                      l10n: context.l10n,
                    ),
                  ],
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 18, color: colorScheme.onSurface.withValues(alpha: 0.5)),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        Text(value, style: textTheme.bodyMedium),
      ],
    );
  }
}

class _AttachmentPreview extends StatelessWidget {
  final String url;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final AppLocalizations l10n;

  const _AttachmentPreview({
    required this.url,
    required this.colorScheme,
    required this.textTheme,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final isPdf = url.toLowerCase().endsWith('.pdf') || url.contains('/raw/upload/');

    if (isPdf) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.picture_as_pdf_outlined,
              size: 28,
              color: colorScheme.error,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.pdfDocument,
                    style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    l10n.tapToViewDocument,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            IconButton.filledTonal(
              icon: const Icon(Icons.open_in_new_rounded),
              onPressed: () => _safeLaunch(
                context,
                Uri.parse(url),
                errorMessage: l10n.couldNotOpenDocument,
                mode: LaunchMode.externalApplication,
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      backgroundColor: Colors.black,
                      iconTheme: const IconThemeData(color: Colors.white),
                    ),
                    body: Center(
                      child: InteractiveViewer(
                        panEnabled: true,
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: Image.network(
                          url,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(color: Colors.white),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 200),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
                ),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image_outlined, size: 32, color: colorScheme.error),
                          const SizedBox(height: 8),
                          Text(l10n.failedToLoadImage, style: textTheme.bodyMedium),
                        ],
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.tapImageFullScreen,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      );
    }
  }
}

Future<void> _safeLaunch(
  BuildContext context,
  Uri uri, {
  required String errorMessage,
  LaunchMode mode = LaunchMode.platformDefault,
}) async {
  try {
    final ok = await launchUrl(uri, mode: mode);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
