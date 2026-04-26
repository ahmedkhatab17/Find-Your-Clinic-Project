import '../../domain/entities/doctor_search_entities.dart';

class DoctorSearchResultModel {
  final String doctorId;
  final String doctorProfileId;
  final String fullName;
  final String specialty;
  final String? profileImageUrl;
  final String? clinicName;
  final String? clinicAddress;
  final double? latitude;
  final double? longitude;
  final double consultationFee;
  final int experienceYears;
  final String? bio;
  final double avgRating;
  final int reviewsCount;
  final double? distanceKm;
  final DateTime? nextAvailableSlot;

  const DoctorSearchResultModel({
    required this.doctorId,
    required this.doctorProfileId,
    required this.fullName,
    required this.specialty,
    this.profileImageUrl,
    this.clinicName,
    this.clinicAddress,
    this.latitude,
    this.longitude,
    required this.consultationFee,
    required this.experienceYears,
    this.bio,
    required this.avgRating,
    required this.reviewsCount,
    this.distanceKm,
    this.nextAvailableSlot,
  });

  factory DoctorSearchResultModel.fromJson(Map<String, dynamic> json) {
    return DoctorSearchResultModel(
      doctorId: json['doctorId'],
      doctorProfileId: json['doctorProfileId'],
      fullName: json['fullName'],
      specialty: json['specialty'],
      profileImageUrl: json['profileImageUrl'],
      clinicName: json['clinicName'],
      clinicAddress: json['clinicAddress'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      consultationFee: (json['consultationFee'] as num).toDouble(),
      experienceYears: json['experienceYears'] ?? 0,
      bio: json['bio'],
      avgRating: (json['avgRating'] as num?)?.toDouble() ?? 0,
      reviewsCount: json['reviewsCount'] ?? 0,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      nextAvailableSlot: json['nextAvailableSlot'] != null
          ? DateTime.tryParse(json['nextAvailableSlot'])
          : null,
    );
  }

  DoctorSearchResult toEntity() => DoctorSearchResult(
        doctorId: doctorId,
        doctorProfileId: doctorProfileId,
        fullName: fullName,
        specialty: specialty,
        profileImageUrl: profileImageUrl,
        clinicName: clinicName,
        clinicAddress: clinicAddress,
        latitude: latitude,
        longitude: longitude,
        consultationFee: consultationFee,
        experienceYears: experienceYears,
        bio: bio,
        avgRating: avgRating,
        reviewsCount: reviewsCount,
        distanceKm: distanceKm,
        nextAvailableSlot: nextAvailableSlot,
      );
}

class PaginatedDoctorsModel {
  final List<DoctorSearchResultModel> items;
  final int page;
  final int pageSize;
  final int totalCount;

  const PaginatedDoctorsModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
  });

  factory PaginatedDoctorsModel.fromJson(Map<String, dynamic> json) {
    return PaginatedDoctorsModel(
      items: (json['items'] as List)
          .map((e) => DoctorSearchResultModel.fromJson(e))
          .toList(),
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 15,
      totalCount: json['totalCount'] ?? 0,
    );
  }

  PaginatedDoctors toEntity() => PaginatedDoctors(
        items: items.map((e) => e.toEntity()).toList(),
        page: page,
        pageSize: pageSize,
        totalCount: totalCount,
      );
}
