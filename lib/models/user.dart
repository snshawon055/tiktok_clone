import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String profilePhoto;
  String uid;

  User({
    required this.name,
    required this.email,
    required this.profilePhoto,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'profilePhoto': profilePhoto,
        'uid': uid,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return User(
      name: snapShot['name'],
      email: snapShot['email'],
      profilePhoto: snapShot['profilePhoto'],
      uid: snapShot['uid'],
    );
  }
}
