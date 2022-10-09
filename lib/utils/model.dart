class AccessModel {
  String? uid;
  String? phone;
  String? email;
  String? userName;

  AccessModel({this.uid, this.email, this.userName, this.phone});

  // receiving data from server
  factory AccessModel.fromMap(map) {
    return AccessModel(
      uid: map['uid'],
      phone: map['phone'],
      email: map['email'],
      userName: map['userName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'email': email,
      'userName': userName,
    };
  }
}