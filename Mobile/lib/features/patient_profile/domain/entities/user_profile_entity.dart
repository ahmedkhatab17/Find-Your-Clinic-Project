class UserProfileEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String? profileImageUrl;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? bloodType;
  final String? address;
  final String? emergencyContactName;
  final String? emergencyContactPhone;

  const UserProfileEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    this.profileImageUrl,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.bloodType,
    this.address,
    this.emergencyContactName,
    this.emergencyContactPhone,
  });

  String get fullName => '$firstName $lastName';

  UserProfileEntity copyWith({
    String? firstName,
    String? lastName,
    String? profileImageUrl,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? bloodType,
    String? address,
    String? emergencyContactName,
    String? emergencyContactPhone,
  }) {
    return UserProfileEntity(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email,
      role: role,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      bloodType: bloodType ?? this.bloodType,
      address: address ?? this.address,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone: emergencyContactPhone ?? this.emergencyContactPhone,
    );
  }
}
