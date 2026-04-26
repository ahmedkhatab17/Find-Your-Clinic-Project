import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/onboarding_entities.dart';
import '../cubits/onboarding_cubit.dart';
import '../cubits/onboarding_state.dart';

const _documentTypes = [
  'medical_license',
  'national_id',
  'degree_certificate',
  'specialty_certificate',
];

const _documentLabels = {
  'medical_license': 'Medical License',
  'national_id': 'National ID',
  'degree_certificate': 'Degree Certificate',
  'specialty_certificate': 'Specialty Certificate',
};

class DoctorDocumentUploadScreen extends StatefulWidget {
  final String pendingToken;
  const DoctorDocumentUploadScreen({super.key, required this.pendingToken});

  @override
  State<DoctorDocumentUploadScreen> createState() =>
      _DoctorDocumentUploadScreenState();
}

class _DoctorDocumentUploadScreenState
    extends State<DoctorDocumentUploadScreen> {
  final _picker = ImagePicker();
  final Map<String, String> _selectedFiles = {};

  Future<void> _pickFile(String documentType) async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() => _selectedFiles[documentType] = file.path);
    }
  }

  void _submit() {
    if (_selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one document.')),
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
                      text: 'Submit Documents',
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
      decoration: const BoxDecoration(
        gradient: AppTheme.headerGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.upload_file_outlined, size: 52, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            'Verify Your License',
            style: AppTextStyles.heading1.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            'Upload your medical documents for review',
            style: AppTextStyles.bodyMd.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Our team reviews submitted documents within 1-2 business days. '
              'Accepted formats: JPG, PNG, PDF. Max 5MB per file.',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentTile(String type) {
    final label = _documentLabels[type] ?? type;
    final picked = _selectedFiles.containsKey(type);
    final filename = picked
        ? _selectedFiles[type]!.split('/').last
        : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _pickFile(type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: picked
                ? AppColors.primary.withValues(alpha: 0.06)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: picked ? AppColors.primary : AppColors.divider,
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
                      ? AppColors.primary
                      : AppColors.divider.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  picked ? Icons.check_rounded : Icons.upload_rounded,
                  color: picked ? Colors.white : AppColors.textSecondary,
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
                      picked ? filename! : 'Tap to select file',
                      style: AppTextStyles.bodySm.copyWith(
                        color: picked
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleState(BuildContext context, OnboardingState state) {
    if (state is OnboardingDocumentsUploaded) {
      context.goNamed(RouteNames.doctorPending);
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
}
