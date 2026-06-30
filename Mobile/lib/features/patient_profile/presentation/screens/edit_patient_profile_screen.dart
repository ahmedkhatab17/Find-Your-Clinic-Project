import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/avatar_picker.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubits/patient_profile_cubit.dart';
import '../cubits/patient_profile_state.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../../../core/locale/l10n_extension.dart';

class EditPatientProfileScreen extends StatefulWidget {
  const EditPatientProfileScreen({super.key});

  @override
  State<EditPatientProfileScreen> createState() =>
      _EditPatientProfileScreenState();
}

class _EditPatientProfileScreenState extends State<EditPatientProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Personal info controllers
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _addressCtrl;

  // Emergency contact controllers
  late final TextEditingController _emergencyNameCtrl;
  late final TextEditingController _emergencyPhoneCtrl;

  // Dropdown state
  String? _gender;
  String? _bloodType;
  DateTime? _dateOfBirth;
  String? _pickedImagePath;

  bool _initialized = false;

  static const _genders = ['Male', 'Female'];
  static const _bloodTypes = ['A+', 'A−', 'B+', 'B−', 'AB+', 'AB−', 'O+', 'O−'];

  @override
  void initState() {
    super.initState();
    _firstNameCtrl = TextEditingController();
    _lastNameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _addressCtrl = TextEditingController();
    _emergencyNameCtrl = TextEditingController();
    _emergencyPhoneCtrl = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final s = context.read<PatientProfileCubit>().state;
      if (s is PatientProfileLoaded) _populate(s);
    });
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _emergencyNameCtrl.dispose();
    _emergencyPhoneCtrl.dispose();
    super.dispose();
  }

  void _populate(PatientProfileLoaded s) {
    if (_initialized) return;
    _initialized = true;
    final p = s.profile;
    _firstNameCtrl.text = p.firstName;
    _lastNameCtrl.text = p.lastName;
    _emailCtrl.text = p.email;
    _phoneCtrl.text = p.phoneNumber ?? '';
    _addressCtrl.text = p.address ?? '';
    _emergencyNameCtrl.text = p.emergencyContactName ?? '';
    _emergencyPhoneCtrl.text = p.emergencyContactPhone ?? '';
    setState(() {
      _gender = _genders.contains(p.gender) ? p.gender : null;
      _bloodType = _bloodTypes.contains(p.bloodType) ? p.bloodType : null;
      _dateOfBirth = p.dateOfBirth;
    });
  }

  String _initialsFrom(UserProfileEntity profile) {
    final name = '${profile.firstName} ${profile.lastName}';
    final parts = name.split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : 'P';
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<PatientProfileCubit>().updateProfile(
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      phoneNumber: _phoneCtrl.text.trim().isEmpty
          ? null
          : _phoneCtrl.text.trim(),
      dateOfBirth: _dateOfBirth,
      gender: _gender,
      bloodType: _bloodType,
      address: _addressCtrl.text.trim().isEmpty
          ? null
          : _addressCtrl.text.trim(),
      emergencyContactName: _emergencyNameCtrl.text.trim().isEmpty
          ? null
          : _emergencyNameCtrl.text.trim(),
      emergencyContactPhone: _emergencyPhoneCtrl.text.trim().isEmpty
          ? null
          : _emergencyPhoneCtrl.text.trim(),
      imagePath: _pickedImagePath,
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _dateOfBirth = picked);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientProfileCubit, PatientProfileState>(
      listener: (context, state) {
        if (state is PatientProfileLoaded) _populate(state);
        if (state is PatientProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.profileUpdated)),
          );
          context.pop();
        }
        if (state is PatientProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isUpdating = state is PatientProfileUpdating;
        return Scaffold(
          appBar: AppBar(title: Text(context.l10n.editProfile)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AvatarPicker(
                    initialImageUrl: state is PatientProfileLoaded
                        ? state.profile.profileImageUrl
                        : (state is PatientProfileUpdating
                              ? state.profile.profileImageUrl
                              : null),
                    initials: state is PatientProfileLoaded
                        ? _initialsFrom(state.profile)
                        : (state is PatientProfileUpdating
                              ? _initialsFrom(state.profile)
                              : 'P'),
                    isLoading: isUpdating,
                    onImagePicked: (file) => setState(() {
                      _pickedImagePath = file.path;
                    }),
                  ),
                  const SizedBox(height: 24),
                  _Section(
                    title: context.l10n.personalInformation,
                    children: [
                      _row(
                        AppTextField(
                          label: context.l10n.firstName,
                          controller: _firstNameCtrl,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? context.l10n.required
                              : null,
                        ),
                        AppTextField(
                          label: context.l10n.lastName,
                          controller: _lastNameCtrl,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? context.l10n.required
                              : null,
                        ),
                      ),
                      AppTextField(
                        label: context.l10n.email,
                        controller: _emailCtrl,
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      AppTextField(
                        label: context.l10n.phoneNumber,
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                      ),
                      _DateField(
                        label: context.l10n.dateOfBirth,
                        value: _dateOfBirth,
                        onTap: _pickDate,
                      ),
                      _row(
                        _DropdownField(
                          key: ValueKey('gender_$_gender'),
                          label: context.l10n.gender,
                          initialValue: _gender,
                          items: _genders,
                          itemLabelBuilder: (e) => e == 'Male' ? context.l10n.genderMale : (e == 'Female' ? context.l10n.genderFemale : e),
                          onChanged: (v) => setState(() => _gender = v),
                        ),
                        _DropdownField(
                          key: ValueKey('blood_$_bloodType'),
                          label: context.l10n.bloodType,
                          initialValue: _bloodType,
                          items: _bloodTypes,
                          onChanged: (v) => setState(() => _bloodType = v),
                        ),
                      ),
                      AppTextField(
                        label: context.l10n.address,
                        controller: _addressCtrl,
                        maxLines: 3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _Section(
                    title: context.l10n.emergencyContact,
                    children: [
                      AppTextField(
                        label: context.l10n.contactName,
                        controller: _emergencyNameCtrl,
                      ),
                      AppTextField(
                        label: context.l10n.contactPhone,
                        controller: _emergencyPhoneCtrl,
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: AppColors.divider),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(context.l10n.cancel),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FilledButton(
                          onPressed: isUpdating ? null : _save,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isUpdating
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Text(context.l10n.saveChanges),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _row(Widget a, Widget b) => Row(
    children: [
      Expanded(child: a),
      const SizedBox(width: 12),
      Expanded(child: b),
    ],
  );
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.label),
          const SizedBox(height: 16),
          ...children.map(
            (w) =>
                Padding(padding: const EdgeInsets.only(bottom: 12), child: w),
          ),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final text = value != null
        ? '${value!.day}/${value!.month}/${value!.year}'
        : '';
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          readOnly: true,
          controller: TextEditingController(text: text),
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
            suffixIcon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.textHint,
            ),
          ),
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final List<String> items;
  final String Function(String)? itemLabelBuilder;
  final ValueChanged<String?> onChanged;
  const _DropdownField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.items,
    this.itemLabelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: initialValue,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(itemLabelBuilder?.call(e) ?? e)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
