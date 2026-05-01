import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/widgets/avatar_picker.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/token_storage.dart';
import '../../domain/entities/doctor_profile_entities.dart';
import '../cubits/edit_doctor_profile_cubit.dart';
import '../cubits/edit_doctor_profile_state.dart';

class DoctorEditProfileScreen extends StatefulWidget {
  const DoctorEditProfileScreen({super.key});

  @override
  State<DoctorEditProfileScreen> createState() =>
      _DoctorEditProfileScreenState();
}

class _DoctorEditProfileScreenState extends State<DoctorEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mapController = MapController();

  late final TextEditingController _bioCtrl;
  late final TextEditingController _feeCtrl;
  late final TextEditingController _experienceCtrl;
  late final TextEditingController _clinicNameCtrl;
  late final TextEditingController _clinicAddressCtrl;
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _phoneCtrl;

  String _specialty = '';
  String _specialtyId = '';
  double? _lat;
  double? _lng;
  String? _pickedImagePath;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _bioCtrl = TextEditingController();
    _feeCtrl = TextEditingController();
    _experienceCtrl = TextEditingController();
    _clinicNameCtrl = TextEditingController();
    _clinicAddressCtrl = TextEditingController();
    _firstNameCtrl = TextEditingController();
    _lastNameCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final userId = await sl<TokenStorage>().getUserId();
    if (userId != null && mounted) {
      context.read<EditDoctorProfileCubit>().loadProfile(userId);
    }
  }

  void _populateFields(DoctorDetails details) {
    if (_initialized) return;
    _initialized = true;
    _specialty = details.specialty;
    _specialtyId = details.specialtyId;
    _bioCtrl.text = details.bio ?? '';
    _feeCtrl.text = details.consultationFee.toStringAsFixed(0);
    _experienceCtrl.text = details.experienceYears.toString();
    _clinicNameCtrl.text = details.clinicName ?? '';
    _clinicAddressCtrl.text = details.clinicAddress ?? '';
    _firstNameCtrl.text = details.firstName;
    _lastNameCtrl.text = details.lastName;
    _phoneCtrl.text = details.phoneNumber ?? '';
    _lat = details.latitude;
    _lng = details.longitude;
  }

  @override
  void dispose() {
    _bioCtrl.dispose();
    _feeCtrl.dispose();
    _experienceCtrl.dispose();
    _clinicNameCtrl.dispose();
    _clinicAddressCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    _mapController.dispose();
    super.dispose();
  }

  String get _initials {
    final f = _firstNameCtrl.text.trim();
    final l = _lastNameCtrl.text.trim();
    if (f.isNotEmpty && l.isNotEmpty) return '${f[0]}${l[0]}'.toUpperCase();
    if (f.isNotEmpty) return f[0].toUpperCase();
    return 'D';
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_specialtyId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile not loaded yet. Please wait.')),
      );
      return;
    }
    context.read<EditDoctorProfileCubit>().saveProfile(
          UpdateDoctorProfileParams(
            firstName: _firstNameCtrl.text.trim(),
            lastName: _lastNameCtrl.text.trim(),
            phoneNumber: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
            specialtyId: _specialtyId,
            consultationFee: double.tryParse(_feeCtrl.text.trim()) ?? 0,
            experienceYears: int.tryParse(_experienceCtrl.text.trim()) ?? 0,
            bio: _bioCtrl.text.trim().isEmpty ? null : _bioCtrl.text.trim(),
            clinicName: _clinicNameCtrl.text.trim().isEmpty
                ? null
                : _clinicNameCtrl.text.trim(),
            clinicAddress: _clinicAddressCtrl.text.trim().isEmpty
                ? null
                : _clinicAddressCtrl.text.trim(),
            latitude: _lat,
            longitude: _lng,
          ),
          imagePath: _pickedImagePath,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: BlocConsumer<EditDoctorProfileCubit, EditDoctorProfileState>(
        listener: (context, state) {
          if (state is EditDoctorProfileLoaded) {
            _populateFields(state.details);
            setState(() {});
          }
          if (state is EditDoctorProfileSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            context.pop();
          }
          if (state is EditDoctorProfileError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is EditDoctorProfileLoading ||
              state is EditDoctorProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is EditDoctorProfileError &&
              state is! EditDoctorProfileLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  FilledButton(
                      onPressed: _loadProfile, child: const Text('Retry')),
                ],
              ),
            );
          }

          final saving = state is EditDoctorProfileSaving;
          final cs = Theme.of(context).colorScheme;

          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: cs.surface,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: AvatarPicker(
                      initialImageUrl: state is EditDoctorProfileLoaded
                          ? state.details.profileImageUrl
                          : (state is EditDoctorProfileSaving
                              ? state.current.profileImageUrl
                              : null),
                      initials: _initials,
                      isLoading: saving,
                      onImagePicked: (file) => setState(() {
                        _pickedImagePath = file.path;
                      }),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ─── Personal info ───
                  _FormCard(cs: cs, children: [
                    Text('Personal Information',
                        style: AppTextStyles.bodyMd
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameCtrl,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(),
                            ),
                            textCapitalization: TextCapitalization.words,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Required'
                                : null,
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(),
                            ),
                            textCapitalization: TextCapitalization.words,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Required'
                                : null,
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    _ReadOnlyField(label: 'Specialty', value: _specialty),
                  ]),

                  const SizedBox(height: 12),

                  // ─── Professional info ───
                  _FormCard(cs: cs, children: [
                    Text('Professional Information',
                        style: AppTextStyles.bodyMd
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _bioCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Bio',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      maxLength: 1000,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _experienceCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Years of Experience',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Required';
                              }
                              if (int.tryParse(v) == null) {
                                return 'Enter a valid number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _feeCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Fee (EGP)',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType:
                                const TextInputType.numberWithOptions(
                                    decimal: true),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Required';
                              }
                              if (double.tryParse(v) == null) {
                                return 'Enter a valid number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),

                  const SizedBox(height: 12),

                  // ─── Clinic info ───
                  _FormCard(cs: cs, children: [
                    Text('Clinic Information',
                        style: AppTextStyles.bodyMd
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _clinicNameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Clinic Name',
                        border: OutlineInputBorder(),
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _clinicAddressCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Clinic Address',
                        border: OutlineInputBorder(),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ]),

                  const SizedBox(height: 12),

                  // ─── Map location picker ───
                  _FormCard(cs: cs, children: [
                    Row(
                      children: [
                        Text('Clinic Location',
                            style: AppTextStyles.bodyMd
                                .copyWith(fontWeight: FontWeight.w600)),
                        const Spacer(),
                        if (_lat != null && _lng != null)
                          Flexible(
                            child: Text(
                              '${_lat!.toStringAsFixed(4)}, ${_lng!.toStringAsFixed(4)}',
                              style: AppTextStyles.bodySm.copyWith(
                                  color: cs.onSurface.withAlpha(120)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap on the map to pin your clinic location',
                      style: AppTextStyles.bodySm
                          .copyWith(color: cs.onSurface.withAlpha(140)),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 220,
                        child: FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter: _lat != null && _lng != null
                                ? LatLng(_lat!, _lng!)
                                : const LatLng(30.0444, 31.2357),
                            initialZoom: 13,
                            onTap: (_, point) => setState(() {
                              _lat = point.latitude;
                              _lng = point.longitude;
                            }),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.findyourclinic.app',
                            ),
                            if (_lat != null && _lng != null)
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: LatLng(_lat!, _lng!),
                                    width: 36,
                                    height: 36,
                                    child: const Icon(
                                      Icons.location_pin,
                                      color: AppColors.primary,
                                      size: 36,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (_lat != null && _lng != null)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          icon: const Icon(Icons.clear, size: 16),
                          label: const Text('Clear pin'),
                          onPressed: () =>
                              setState(() => _lat = _lng = null),
                        ),
                      ),
                  ]),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FilledButton(
                      onPressed: saving ? null : _save,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: saving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Save Changes',
                              style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  final List<Widget> children;
  final ColorScheme cs;
  const _FormCard({required this.children, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outline.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  const _ReadOnlyField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyles.bodySm
                .copyWith(color: cs.onSurface.withAlpha(160))),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outline.withAlpha(60)),
          ),
          child: Text(
            value.isNotEmpty ? value : '—',
            style: AppTextStyles.bodyMd
                .copyWith(color: cs.onSurface.withAlpha(160)),
          ),
        ),
      ],
    );
  }
}
