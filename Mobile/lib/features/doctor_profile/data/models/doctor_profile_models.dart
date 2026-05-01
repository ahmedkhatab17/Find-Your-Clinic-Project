import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/doctor_profile_entities.dart';

class DoctorDetailsModel {
  final String doctorId;
  final String doctorProfileId;
  final String fullName;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String specialtyId;
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
  final DateTime? nextAvailableSlot;

  const DoctorDetailsModel({
    required this.doctorId,
    required this.doctorProfileId,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.specialtyId,
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
    this.nextAvailableSlot,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailsModel(
      doctorId: json['doctorId'],
      doctorProfileId: json['doctorProfileId'],
      fullName: json['fullName'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'],
      specialtyId: json['specialtyId'] ?? '',
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
      nextAvailableSlot: json['nextAvailableSlot'] != null
          ? DateTime.tryParse(json['nextAvailableSlot'])
          : null,
    );
  }

  DoctorDetails toEntity() => DoctorDetails(
        doctorId: doctorId,
        doctorProfileId: doctorProfileId,
        fullName: fullName,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        specialtyId: specialtyId,
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
        nextAvailableSlot: nextAvailableSlot,
      );
}

class DoctorReviewModel {
  final String id;
  final String patientName;
  final String? patientImageUrl;
  final int rating;
  final String? comment;
  final DateTime createdAt;

  const DoctorReviewModel({
    required this.id,
    required this.patientName,
    this.patientImageUrl,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  factory DoctorReviewModel.fromJson(Map<String, dynamic> json) {
    return DoctorReviewModel(
      id: json['id'],
      patientName: json['patientName'] ?? json['reviewerName'] ?? 'Patient',
      patientImageUrl: json['patientImageUrl'] ?? json['reviewerImageUrl'],
      rating: json['rating'] ?? 0,
      comment: json['comment'],
      createdAt: parseServerDateTime(json['createdAt']),
    );
  }

  DoctorReview toEntity() => DoctorReview(
        id: id,
        patientName: patientName,
        patientImageUrl: patientImageUrl,
        rating: rating,
        comment: comment,
        createdAt: createdAt,
      );
}

class AvailabilitySlotModel {
  final String dayOfWeek;
  final String startTime;
  final String endTime;

  const AvailabilitySlotModel({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  factory AvailabilitySlotModel.fromJson(Map<String, dynamic> json) {
    return AvailabilitySlotModel(
      dayOfWeek: json['dayOfWeek'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
    );
  }

  AvailabilitySlot toEntity() => AvailabilitySlot(
        dayOfWeek: dayOfWeek,
        startTime: startTime,
        endTime: endTime,
      );
}
