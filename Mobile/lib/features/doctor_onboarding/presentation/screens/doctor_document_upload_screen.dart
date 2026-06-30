import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../core/widgets/avatar_viewer.dart';
import '../../domain/entities/onboarding_entities.dart';
import '../cubits/onboarding_cubit.dart';
import '../cubits/onboarding_state.dart';

const _documentTypes = [
  'medical_license',
  'national_id',
  'degree_certificate',
  'specialty_certificate',
];

String _getDocumentLabel(BuildContext context, String type) {
  switch (type) {
    case 'medical_license': return context.l10n.medicalLicense;
    case 'national_id': return context.l10n.nationalId;
    case 'degree_certificate': return context.l10n.degreeCertificate;
    case 'specialty_certificate': return context.l10n.specialtyCertificate;
    default: return type;
  }
}

class DoctorDocumentUploadScreen extends StatefulWidget {
  final String pendingToken;
  final bool isResubmission;
  const DoctorDocumentUploadScreen({
    super.key,
    required this.pendingToken,
    this.isResubmission = false,
  });

  @override
  State<DoctorDocumentUploadScreen> createState() =>
      _DoctorDocumentUploadScreenState();
}

class _DoctorDocumentUploadScreenState
    extends State<DoctorDocumentUploadScreen> {
  final _picker = ImagePicker();
  final Map<String, String> _selectedFiles = {};
  final Map<String, String> _uploadedFiles = {};

  // Profile-update mode: doctor is already approved and editing their docs.
  // Resubmission mode: doctor was rejected and is re-uploading to retry review.
  bool get _isProfileUpdateMode =>
      widget.pendingToken.isEmpty && !widget.isResubmission;

  @override
  void initState() {
    super.initState();
    if (_isProfileUpdateMode || widget.isResubmission) {
      context.read<OnboardingCubit>().loadMyDocuments();
    }
  }

  Future<void> _pickFile(String documentType) async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() => _selectedFiles[documentType] = file.path);
    }
  }

  void _submit() {
    if (_selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.pleaseAddDoc)),
      );
      return;
    }
    final docs = _selectedFiles.entries
        .map((e) => DoctorDocument(localPath: e.value, documentType: e.key))
        .toList();

    context.read<OnboardingCubit>().uploadDocuments(
          documents: docs,
          pendingToken: widget.pendingToken,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listener: _handleState,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  _buildInfoCard(),
                  const SizedBox(height: 24),
                  ..._documentTypes.map((type) => _buildDocumentTile(type)),
                  const SizedBox(height: 32),
                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) => AppButton(
                      text: widget.isResubmission
                          ? context.l10n.resubmitReview
                          : _isProfileUpdateMode
                              ? context.l10n.updateDocs
                              : context.l10n.submitDocs,
                      isLoading: state is OnboardingLoading,
                      onPressed: _submit,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 28),
      decoration: BoxDecoration(
        gradient: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.headerGradientDark
            : AppTheme.headerGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.upload_file_outlined, size: 52, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            context.l10n.verifyLicense,
            style: AppTextStyles.heading1.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            context.l10n.uploadDocsReview,
            style: AppTextStyles.bodyMd.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.l10n.docReviewInfo,
              style: AppTextStyles.bodySm.copyWith(color: colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentTile(String type) {
    final label = _getDocumentLabel(context, type);
    final picked = _selectedFiles.containsKey(type);
    final uploaded = _uploadedFiles.containsKey(type);
    final filename = picked ? _selectedFiles[type]!.split('/').last : null;
    final colorScheme = Theme.of(context).colorScheme;
    final dividerColor =
        Theme.of(context).dividerTheme.color ?? AppColors.divider;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _pickFile(type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: picked
                ? colorScheme.primary.withValues(alpha: 0.06)
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: picked ? colorScheme.primary : dividerColor,
              width: picked ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: picked
                      ? colorScheme.primary
                      : dividerColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  picked ? Icons.check_rounded : Icons.upload_rounded,
                  color: picked ? Colors.white : colorScheme.onSurfaceVariant,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: AppTextStyles.label),
                    const SizedBox(height: 2),
                    Text(
                      picked
                          ? context.l10n.docSelected(filename ?? '')
                          : uploaded
                              ? context.l10n.docUploaded
                              : context.l10n.tapToSelectDoc,
                      style: AppTextStyles.bodySm.copyWith(
                        color: picked
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (picked || uploaded)
                    IconButton(
                      onPressed: () => _viewDocument(type),
                      icon: Icon(
                        Icons.visibility_outlined,
                        color: colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      tooltip: context.l10n.viewDocument,
                    ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleState(BuildContext context, OnboardingState state) {
    if (state is OnboardingDocumentsLoaded) {
      setState(() {
        _uploadedFiles
          ..clear()
          ..addEntries(
            state.documents.map((doc) => MapEntry(doc.documentType, doc.url)),
          );
      });
    } else if (state is OnboardingDocumentsUploaded) {
      setState(() {
        for (final doc in state.documents) {
          _uploadedFiles[doc.documentType] = doc.url;
        }
        _selectedFiles.clear();
      });
      if (widget.isResubmission) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(context.l10n.docsResubmitted),
              behavior: SnackBarBehavior.floating,
            ),
          );
        context.goNamed(RouteNames.doctorPending);
      } else if (_isProfileUpdateMode) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(context.l10n.docsUpdated),
              behavior: SnackBarBehavior.floating,
            ),
          );
      } else {
        context.goNamed(RouteNames.doctorPending);
      }
    } else if (state is OnboardingError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
        );
    }
  }

  Future<void> _viewDocument(String type) async {
    final localPath = _selectedFiles[type];
    final remoteUrl = _uploadedFiles[type];

    if (localPath != null && File(localPath).existsSync()) {
      AvatarViewer.show(context, FileImage(File(localPath)));
      return;
    }

    if (remoteUrl != null && remoteUrl.isNotEmpty) {
      if (_isLikelyImage(remoteUrl)) {
        AvatarViewer.show(context, NetworkImage(remoteUrl));
        return;
      }

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(_getDocumentLabel(context, type)),
          content: Text(
            context.l10n.fileNoPreview,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: remoteUrl));
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.l10n.linkCopied)),
                );
              },
              child: Text(context.l10n.copyLink),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(context.l10n.closeWord),
            ),
          ],
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.noDocAvailable)),
    );
  }

  bool _isLikelyImage(String url) {
    final u = url.toLowerCase();
    return u.endsWith('.jpg') ||
        u.endsWith('.jpeg') ||
        u.endsWith('.png') ||
        u.endsWith('.webp') ||
        u.contains('/image/upload/');
  }
}
