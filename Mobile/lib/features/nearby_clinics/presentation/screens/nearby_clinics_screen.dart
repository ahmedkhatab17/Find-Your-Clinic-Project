import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/string_extensions.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/di/service_locator.dart';
import '../../../accessibility/domain/entities/screen_context.dart';
import '../../../accessibility/presentation/cubits/voice_assistant_cubit.dart';
import '../../../accessibility/presentation/cubits/voice_assistant_visibility_cubit.dart';
import '../../../search/domain/entities/doctor_search_entities.dart';
import '../cubits/nearby_clinics_cubit.dart';
import '../cubits/nearby_clinics_state.dart';

class NearbyClinicsScreen extends StatefulWidget {
  const NearbyClinicsScreen({super.key});

  @override
  State<NearbyClinicsScreen> createState() => _NearbyClinicsScreenState();
}

class _NearbyClinicsScreenState extends State<NearbyClinicsScreen> {
  DoctorSearchResult? _selectedClinic;
  static const _screenContext = ScreenContext(screen: PatientScreen.nearbyClinics);

  @override
  void initState() {
    super.initState();
    context.read<NearbyClinicsCubit>().loadNearbyClinics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<VoiceAssistantCubit>().setScreenContext(
            _screenContext,
            summary: _buildScreenSummary,
            itemSelector: _itemSelector,
          );
    });
  }

  String _buildScreenSummary() {
    final state = context.read<NearbyClinicsCubit>().state;
    if (state is NearbyClinicsLoaded) {
      if (state.clinics.isEmpty) return 'No nearby clinics found.';
      final buffer = StringBuffer('Found ${state.clinics.length} nearby clinics. ');
      final readN = state.clinics.length > 5 ? 5 : state.clinics.length;
      for (var i = 0; i < readN; i++) {
        final c = state.clinics[i];
        buffer.write('${i + 1}: ${c.fullName.withDoctorPrefix}, ${c.specialty.translateSpecialty(context)}, ${c.distanceKm?.toStringAsFixed(1)} kilometers away. ');
      }
      return buffer.toString();
    }
    return context.l10n.nearbyClinics;
  }

  bool _itemSelector(int index) {
    final state = context.read<NearbyClinicsCubit>().state;
    if (state is! NearbyClinicsLoaded) return false;
    if (index < 0 || index >= state.clinics.length) return false;
    final clinic = state.clinics[index];
    context.pushNamed(
      'doctorDetails',
      pathParameters: {'id': clinic.doctorId},
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.nearbyClinics)),
      body: BlocBuilder<NearbyClinicsCubit, NearbyClinicsState>(
        builder: (context, state) => switch (state) {
          NearbyClinicsInitial() || NearbyClinicsLoading() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(context.l10n.findNearbyClinicsWait),
                ],
              ),
            ),
          NearbyClinicsError(:final message) => ErrorView(
              message: message,
              onRetry: () =>
                  context.read<NearbyClinicsCubit>().loadNearbyClinics(),
            ),
          NearbyClinicsLoaded(:final clinics, :final lat, :final lng) => sl<VoiceAssistantVisibilityCubit>().state
              ? ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: clinics.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final clinic = clinics[index];
                    return _ClinicCard(
                      clinic: clinic,
                      onTap: () => context.pushNamed(
                        'doctorDetails',
                        pathParameters: {'id': clinic.doctorId},
                      ),
                    );
                  },
                )
              : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(lat, lng),
                    initialZoom: 13,
                    onTap: (_, p) => setState(() => _selectedClinic = null),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.findyourclinic.app',
                    ),
                    MarkerLayer(
                      markers: [
                        // User location marker
                        Marker(
                          point: LatLng(lat, lng),
                          width: 30,
                          height: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.secondary.withAlpha(80),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Clinic markers
                        ..._buildClinicMarkers(clinics),
                      ],
                    ),
                  ],
                ),
                // Selected Clinic Card
                if (_selectedClinic != null)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: _ClinicCard(
                      clinic: _selectedClinic!,
                      onTap: () => context.pushNamed(
                        'doctorDetails',
                        pathParameters: {'id': _selectedClinic!.doctorId},
                      ),
                    ),
                  ),
              ],
            ),
        },
      ),
    );
  }

  List<Marker> _buildClinicMarkers(List<DoctorSearchResult> clinics) {
    return clinics
        .where((c) => c.latitude != null && c.longitude != null)
        .map(
          (clinic) => Marker(
            point: LatLng(clinic.latitude!, clinic.longitude!),
            width: 80,
            height: 70,
            child: GestureDetector(
              onTap: () => setState(() => _selectedClinic = clinic),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withAlpha(80),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      clinic.fullName.split(' ').first.withDoctorPrefix,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }
}

class _ClinicCard extends StatelessWidget {
  final DoctorSearchResult clinic;
  final VoidCallback onTap;

  const _ClinicCard({required this.clinic, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            UserAvatar(
              radius: 28,
              imageUrl: clinic.profileImageUrl,
              fullName: clinic.fullName,
              backgroundColor: AppColors.primary.withAlpha(20),
              textStyle: AppTextStyles.heading3.copyWith(color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(clinic.fullName.withDoctorPrefix, style: AppTextStyles.label),
                  Text(clinic.specialty.translateSpecialty(context),
                      style: AppTextStyles.bodySm
                          .copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          color: AppColors.starRating, size: 14),
                      const SizedBox(width: 3),
                      Text(
                          '${clinic.avgRating.toStringAsFixed(1)} · ${clinic.distanceKm?.toStringAsFixed(1) ?? "?"} ${context.l10n.km}',
                          style: AppTextStyles.caption),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${context.l10n.egp} ${clinic.consultationFee.toStringAsFixed(0)}',
                  style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 14, color: AppColors.textHint),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
