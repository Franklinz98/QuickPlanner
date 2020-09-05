import 'package:flutter/foundation.dart';

class QuickPlannerUser {
  final String email;
  final String name;
  final String phone;
  final String uid;

  QuickPlannerUser({
    @required this.email,
    @required this.name,
    @required this.phone,
    @required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {'email': email, 'name': name, 'phone': phone};
  }

  factory QuickPlannerUser.fromMap(String uid, Map<String, dynamic> map) {
    assert(uid != null);
    assert(map != null);
    return QuickPlannerUser(
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      uid: uid,
    );
  }
}
