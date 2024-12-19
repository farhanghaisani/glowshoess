class UserProfile {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String address;
  final String photoPath;

  UserProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    this.photoPath = '',
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      photoPath: map['photoPath'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'photoPath': photoPath,
    };
  }
}
