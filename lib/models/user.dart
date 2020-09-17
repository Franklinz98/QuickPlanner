import 'package:flutter/foundation.dart';

class QPUser {
  final String email;
  final String name;
  final String phone;
  final String uid;
  bool admin = false;

  QPUser({
    @required this.email,
    @required this.name,
    @required this.phone,
    @required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {'email': email, 'name': name, 'phone': phone};
  }

  factory QPUser.fromMap(String uid, Map<String, dynamic> map) {
    assert(uid != null);
    assert(map != null);
    return QPUser(
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      uid: uid,
    );
  }
}
