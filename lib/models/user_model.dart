class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String? profilePic;
  final String? location;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.profilePic,
    this.location,
  });

  // ✅ Fix: Add all properties to copyWith
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? role,
    String? profilePic,
    String? location,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      profilePic: profilePic ?? this.profilePic,
      location: location ?? this.location,
    );
  }
}
