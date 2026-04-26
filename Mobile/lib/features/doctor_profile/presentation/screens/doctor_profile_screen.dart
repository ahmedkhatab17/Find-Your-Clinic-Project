import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/doctor_profile_entities.dart';
import '../cubits/doctor_profile_cubit.dart';
import '../cubits/doctor_profile_state.dart';

class DoctorProfileScreen extends StatefulWidget {
  final String doctorId;
  const DoctorProfileScreen({super.key, required this.doctorId});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    context.read<DoctorProfileCubit>().loadProfile(widget.doctorId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) => switch (state) {
        DoctorProfileInitial() || DoctorProfileLoading() => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        DoctorProfileError(:final message) => Scaffold(
            appBar: AppBar(),
            body: ErrorView(
              message: message,
              onRetry: () => context
                  .read<DoctorProfileCubit>()
                  .loadProfile(widget.doctorId),
            ),
          ),
        DoctorProfileLoaded(:final details, :final reviews, :final availability) =>
          Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                // ─── Header ───
                SliverAppBar(
                  expandedHeight: 260,
                  pinned: true,
                  backgroundColor: AppColors.primary,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientEnd,
                          ],
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 32),
                            CircleAvatar(
                              radius: 44,
                              backgroundColor: Colors.white.withAlpha(40),
                              child: const Icon(Icons.person,
                                  color: Colors.white, size: 48),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Dr. ${details.fullName}',
                              style: AppTextStyles.heading2
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              details.specialty,
                              style: AppTextStyles.bodyMd
                                  .copyWith(color: Colors.white70),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _HeaderStat(
                                    icon: Icons.star,
                                    value: details.avgRating.toStringAsFixed(1),
                                    label: 'Rating'),
                                const SizedBox(width: 24),
                                _HeaderStat(
                                    icon: Icons.reviews,
                                    value: '${details.reviewsCount}',
                                    label: 'Reviews'),
                                const SizedBox(width: 24),
                                _HeaderStat(
                                    icon: Icons.work,
                                    value: '${details.experienceYears}',
                                    label: 'Years'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // ─── Tab Bar ───
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabBarDelegate(
                    tabBar: TabBar(
                      controller: _tabController,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.textHint,
                      indicatorColor: AppColors.primary,
                      tabs: const [
                        Tab(text: 'About'),
                        Tab(text: 'Schedule'),
                        Tab(text: 'Reviews'),
                        Tab(text: 'Location'),
                      ],
                    ),
                  ),
                ),
              ],
              body: TabBarView(
                controller: _tabController,
                children: [
                  _AboutTab(details: details),
                  _ScheduleTab(slots: availability),
                  _ReviewsTab(reviews: reviews),
                  _LocationTab(details: details),
                ],
              ),
            ),
            // ─── Book Button ───
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AppButton(
                  text: 'Book Appointment — \$${details.consultationFee.toStringAsFixed(0)}',
                  onPressed: () {
                    // Booking will be implemented in a future phase
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booking coming soon!')),
                    );
                  },
                ),
              ),
            ),
          ),
      },
    );
  }
}

// ─── Header Stat Widget ───
class _HeaderStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _HeaderStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(height: 4),
        Text(value,
            style: AppTextStyles.label.copyWith(color: Colors.white)),
        Text(label,
            style: AppTextStyles.caption.copyWith(color: Colors.white60)),
      ],
    );
  }
}

// ─── Tab Bar Delegate ───
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  const _TabBarDelegate({required this.tabBar});

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;
  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}

// ─── About Tab ───
class _AboutTab extends StatelessWidget {
  final DoctorDetails details;
  const _AboutTab({required this.details});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (details.bio != null && details.bio!.isNotEmpty) ...[
          Text('About', style: AppTextStyles.heading3),
          const SizedBox(height: 8),
          Text(details.bio!, style: AppTextStyles.bodyMd),
          const SizedBox(height: 20),
        ],
        _InfoRow(icon: Icons.local_hospital, label: 'Clinic', value: details.clinicName ?? 'N/A'),
        _InfoRow(icon: Icons.location_on, label: 'Address', value: details.clinicAddress ?? 'N/A'),
        _InfoRow(icon: Icons.attach_money, label: 'Consultation Fee', value: '\$${details.consultationFee.toStringAsFixed(0)}'),
        _InfoRow(icon: Icons.work_outline, label: 'Experience', value: '${details.experienceYears} years'),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
              Text(value, style: AppTextStyles.label),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Schedule Tab ───
class _ScheduleTab extends StatelessWidget {
  final List<AvailabilitySlot> slots;
  const _ScheduleTab({required this.slots});

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return const EmptyStateView(
        icon: Icons.schedule,
        title: 'No Schedule Available',
        subtitle: 'This doctor has not set up their availability yet.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: slots.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final slot = slots[index];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(10),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withAlpha(40)),
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  slot.dayOfWeek,
                  style: AppTextStyles.labelSm.copyWith(color: AppColors.primary),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 14),
              Icon(Icons.access_time, color: AppColors.textHint, size: 16),
              const SizedBox(width: 6),
              Text('${slot.startTime} — ${slot.endTime}', style: AppTextStyles.bodyMd),
            ],
          ),
        );
      },
    );
  }
}

// ─── Reviews Tab ───
class _ReviewsTab extends StatelessWidget {
  final List<DoctorReview> reviews;
  const _ReviewsTab({required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const EmptyStateView(
        icon: Icons.rate_review,
        title: 'No Reviews Yet',
        subtitle: 'Be the first to review this doctor.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary.withAlpha(20),
                  child: const Icon(Icons.person, size: 18, color: AppColors.primary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.patientName, style: AppTextStyles.label),
                      Text(
                        DateFormat('MMM d, yyyy').format(review.createdAt),
                        style: AppTextStyles.caption.copyWith(color: AppColors.textHint),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (i) => Icon(
                    i < review.rating ? Icons.star : Icons.star_border,
                    color: AppColors.starRating,
                    size: 16,
                  )),
                ),
              ],
            ),
            if (review.comment != null && review.comment!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(review.comment!, style: AppTextStyles.bodyMd),
            ],
          ],
        );
      },
    );
  }
}

// ─── Location Tab ───
class _LocationTab extends StatelessWidget {
  final DoctorDetails details;
  const _LocationTab({required this.details});

  @override
  Widget build(BuildContext context) {
    if (details.latitude == null || details.longitude == null) {
      return const EmptyStateView(
        icon: Icons.location_off,
        title: 'Location Not Available',
        subtitle: 'This clinic has not set up their location yet.',
      );
    }

    final clinicLatLng = LatLng(details.latitude!, details.longitude!);

    return Column(
      children: [
        Expanded(
          child: FlutterMap(
            options: MapOptions(
              initialCenter: clinicLatLng,
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.findyourclinic.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: clinicLatLng,
                    width: 50,
                    height: 50,
                    child: const Icon(Icons.location_on,
                        color: AppColors.error, size: 40),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(details.clinicName ?? 'Clinic', style: AppTextStyles.heading3),
              const SizedBox(height: 4),
              Text(
                details.clinicAddress ?? 'Address not available',
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
