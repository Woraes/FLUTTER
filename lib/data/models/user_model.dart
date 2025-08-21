enum UserType { citizen, agent, admin }

enum UserStatus { active, inactive, suspended }

class User {
  final String id;
  final String name;
  final String email;
  final String? cpf;
  final String? phone;
  final UserType type;
  final UserStatus status;
  final String? department;
  final String? badge;
  final String? rank;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final Map<String, dynamic>? permissions;
  final String? profileImage;
  final bool isVerified;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.cpf,
    this.phone,
    required this.type,
    this.status = UserStatus.active,
    this.department,
    this.badge,
    this.rank,
    required this.createdAt,
    this.lastLogin,
    this.permissions,
    this.profileImage,
    this.isVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'] as String,
      email: json['email'] as String,
      cpf: json['cpf'] as String?,
      phone: json['phone'] as String?,
      type: UserType.values.firstWhere(
        (e) => e.toString() == 'UserType.${json['type']}',
        orElse: () => UserType.citizen,
      ),
      status: UserStatus.values.firstWhere(
        (e) => e.toString() == 'UserStatus.${json['status']}',
        orElse: () => UserStatus.active,
      ),
      department: json['department'] as String?,
      badge: json['badge'] as String?,
      rank: json['rank'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLogin: json['lastLogin'] != null
          ? DateTime.parse(json['lastLogin'] as String)
          : null,
      permissions: json['permissions'] as Map<String, dynamic>?,
      profileImage: json['profileImage'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'cpf': cpf,
      'phone': phone,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'department': department,
      'badge': badge,
      'rank': rank,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'permissions': permissions,
      'profileImage': profileImage,
      'isVerified': isVerified,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? cpf,
    String? phone,
    UserType? type,
    UserStatus? status,
    String? department,
    String? badge,
    String? rank,
    DateTime? createdAt,
    DateTime? lastLogin,
    Map<String, dynamic>? permissions,
    String? profileImage,
    bool? isVerified,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      status: status ?? this.status,
      department: department ?? this.department,
      badge: badge ?? this.badge,
      rank: rank ?? this.rank,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      permissions: permissions ?? this.permissions,
      profileImage: profileImage ?? this.profileImage,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  bool get isAgent => type == UserType.agent || type == UserType.admin;
  bool get isAdmin => type == UserType.admin;
  bool get isCitizen => type == UserType.citizen;

  String get displayName {
    if (isAgent && rank != null) {
      return '$rank $name';
    }
    return name;
  }

  String get typeDisplayName {
    switch (type) {
      case UserType.citizen:
        return 'Cidadão';
      case UserType.agent:
        return 'Agente';
      case UserType.admin:
        return 'Administrador';
    }
  }
}
