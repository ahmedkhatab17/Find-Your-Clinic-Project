import '../../domain/entities/auth_entities.dart';

/// Maps API JSON responses to domain entities.
/// Backend wraps all responses in: { "success": bool, "message": str, "data": {...} }

class AuthResponseModel {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final AuthUserModel user;

  const AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      expiresIn: json['expiresIn'] as int? ?? 3600,
      user: AuthUserModel.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }

  AuthResult toEntity() => AuthResult(
        tokens: AuthTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresIn: expiresIn,
        ),
        user: user.toEntity(),
      );
}

class AuthUserModel {
  final String id;
  final String email;
  final String role;
  final String fullName;

  const AuthUserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.fullName,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
    );
  }

  User toEntity() => User(
        id: id,
        email: email,
        fullName: fullName,
        role: role,
      );
}

/// Backend RegisterResultDto: { "auth": AuthResponse?, "pendingToken": string? }
class RegisterResultModel {
  final AuthResponseModel? authResponse;
  final String? pendingToken;

  const RegisterResultModel({
    this.authResponse,
    this.pendingToken,
  });

  factory RegisterResultModel.fromJson(Map<String, dynamic> json) {
    final authJson = json['auth'] as Map<String, dynamic>?;
    return RegisterResultModel(
      authResponse: authJson != null ? AuthResponseModel.fromJson(authJson) : null,
      pendingToken: json['pendingToken'] as String?,
    );
  }

  RegisterResult toEntity() => RegisterResult(
        authResult: authResponse?.toEntity(),
        pendingToken: pendingToken,
        // Doctor registration returns pendingToken (no auth), patient returns auth directly.
        requiresDocumentUpload: authResponse == null && pendingToken != null,
      );
}

class GoogleAuthResultModel {
  final AuthResponseModel? authResponse;
  final String? pendingToken;
  final bool requiresRegistration;

  const GoogleAuthResultModel({
    this.authResponse,
    this.pendingToken,
    this.requiresRegistration = false,
  });

  factory GoogleAuthResultModel.fromJson(Map<String, dynamic> json) {
    final hasAuth = json.containsKey('accessToken');
    return GoogleAuthResultModel(
      authResponse: hasAuth ? AuthResponseModel.fromJson(json) : null,
      pendingToken: json['pendingToken'] as String?,
      requiresRegistration:
          json['requiresRegistration'] as bool? ?? false,
    );
  }

  GoogleAuthResult toEntity() => GoogleAuthResult(
        authResult: authResponse?.toEntity(),
        pendingToken: pendingToken,
        requiresRegistration: requiresRegistration,
      );
}
