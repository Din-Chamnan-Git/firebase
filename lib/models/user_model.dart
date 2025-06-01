class UserModel {
  final String uid;
  final String username;
  final String email;
  final String? profilePictureUrl;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilePictureUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      profilePictureUrl: map['profilePictureUrl'],
    );
  }
}
