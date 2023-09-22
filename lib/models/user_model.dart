class UserModel {
  final String name;
  final String phoneNumber;
  final String profilePic;
  final String? uid;
  late final bool isOnline;
  final List<String> groupId;
  final int lastSeen;

  UserModel({
    required this.lastSeen,
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
      'lastseen': lastSeen
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      lastSeen: map['lastseen'] ?? 0,
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePic'] ?? '',
      isOnline: map['isOnline'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      groupId: List<String>.from(map['groupId']),
    );
  }
}
