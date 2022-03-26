import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Video {
  String id;
  String username;
  String uid;
  List likes;
  int comentCount;
  int shereCount;
  String songName;
  String caption;
  String profilePhoto;
  String thumbnail;
  String videoUrl;

  Video(
      {required this.id,
      required this.username,
      required this.uid,
      required this.likes,
      required this.comentCount,
      required this.shereCount,
      required this.songName,
      required this.caption,
      required this.profilePhoto,
      required this.thumbnail,
      required this.videoUrl});

  Map<String, dynamic> toJson() => {
        'username': username,
        'id': id,
        'uid': uid,
        'likes': likes,
        'comentCount': comentCount,
        'shereCount': shereCount,
        'songName': songName,
        'caption': caption,
        'profilePhoto': profilePhoto,
        'thumbnail': thumbnail,
        "videoUrl": videoUrl
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return Video(
      id: snapShot['id'],
      username: snapShot['username'],
      uid: snapShot['uid'],
      likes: snapShot['likes'],
      comentCount: snapShot['comentCount'],
      shereCount: snapShot['shereCount'],
      songName: snapShot['songName'],
      caption: snapShot['caption'],
      profilePhoto: snapShot['profilePhoto'],
      thumbnail: snapShot['thumbnail'],
      videoUrl: snapShot['VieoUrl'],
    );
  }
}
