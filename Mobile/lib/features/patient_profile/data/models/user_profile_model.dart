import '../../domain/entities/user_profile_entity.dart';

class UserProfileModel {
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

  const UserProfileModel({
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

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json['id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        email: json['email'] as String,
        role: json['role'] as String,
        profileImageUrl: json['profileImageUrl'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        dateOfBirth: json['dateOfBirth'] != null
            ? DateTime.tryParse(json['dateOfBirth'] as String)
            : null,
        gender: json['gender'] as String?,
        bloodType: json['bloodType'] as String?,
        address: json['address'] as String?,
        emergencyContactName: json['emergencyContactName'] as String?,
        emergencyContactPhone: json['emergencyContactPhone'] as String?,
      );

  UserProfileEntity toEntity() => UserProfileEntity(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        role: role,
        profileImageUrl: profileImageUrl,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        gender: gender,
        bloodType: bloodType,
        address: address,
        emergencyContactName: emergencyContactName,
        emergencyContactPhone: emergencyContactPhone,
      );
}
