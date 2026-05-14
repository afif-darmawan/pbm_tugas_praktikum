class UserRole {
  final int id;
  final String name;

  UserRole({
    required this.id,
    required this.name,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class UserClass {
  final int id;
  final String name;

  UserClass({
    required this.id,
    required this.name,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final UserRole role;
  final UserClass userClass;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.userClass,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      role: UserRole.fromJson(json['role'] ?? {}),
      userClass: UserClass.fromJson(json['class'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'role': role.toJson(),
      'class': userClass.toJson(),
    };
  }
}

class LoginResponse {
  final bool success;
  final String message;
  final String token;
  final User user;

  LoginResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: data['token'] ?? '',
      user: User.fromJson(data['user'] ?? {}),
    );
  }
}
