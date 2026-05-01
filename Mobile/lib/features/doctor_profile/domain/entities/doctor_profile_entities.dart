// Domain entities for doctor profile detail view.
// Pure Dart — no Flutter imports.

class DoctorDetails {
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

  const DoctorDetails({
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

  DoctorDetails copyWith({
    String? profileImageUrl,
    String? clinicName,
    String? clinicAddress,
    double? latitude,
    double? longitude,
    double? consultationFee,
    int? experienceYears,
    String? bio,
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) {
    return DoctorDetails(
      doctorId: doctorId,
      doctorProfileId: doctorProfileId,
      fullName: (firstName != null || lastName != null) 
          ? '${firstName ?? this.firstName} ${lastName ?? this.lastName}'.trim()
          : fullName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      specialtyId: specialtyId,
      specialty: specialty,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      clinicName: clinicName ?? this.clinicName,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      consultationFee: consultationFee ?? this.consultationFee,
      experienceYears: experienceYears ?? this.experienceYears,
      bio: bio ?? this.bio,
      avgRating: avgRating,
      reviewsCount: reviewsCount,
      nextAvailableSlot: nextAvailableSlot,
    );
  }
}

class DoctorReview {
  final String id;
  final String patientName;
  final String? patientImageUrl;
  final int rating;
  final String? comment;
  final DateTime createdAt;

  const DoctorReview({
    required this.id,
    required this.patientName,
    this.patientImageUrl,
    required this.rating,
    this.comment,
    required this.createdAt,
  });
}

class AvailabilitySlot {
  final String dayOfWeek;
  final String startTime;
  final String endTime;

  const AvailabilitySlot({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });
}

class UpdateDoctorProfileParams {
  final String specialtyId;
  final double consultationFee;
  final int experienceYears;
  final String? bio;
  final String? clinicName;
  final String? clinicAddress;
  final double? latitude;
  final double? longitude;
  final String firstName;
  final String lastName;
  final String? phoneNumber;

  const UpdateDoctorProfileParams({
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.specialtyId,
    required this.consultationFee,
    required this.experienceYears,
    this.bio,
    this.clinicName,
    this.clinicAddress,
    this.latitude,
    this.longitude,
  });
}
