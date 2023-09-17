class UserModel {
  final String name;
  final String phoneNumber;
  final String profilePhotoUrl;
  final String? uid;
  final bool isOnline;
  final List<String> groupId;


  UserModel({
    required this.name,
    required this.uid,
    required this.profilePhotoUrl,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePhotoUrl,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePhotoUrl: map['profilePhotoUrl'] ?? '',
      isOnline: map['isOnline'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      groupId: List<String>.from(map['groupId']),
    );
  }
}
