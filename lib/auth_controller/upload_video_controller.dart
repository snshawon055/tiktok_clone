import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/color/colors.dart';
import 'package:tiktok_clone/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressVideo!.file;
  }

  Future<String> _uploadVideoToStore(String id, String videoPath) async {
    Reference ref = firebaseStore.ref().child("Videos").child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumnail = await VideoCompress.getByteThumbnail(videoPath);
    return thumnail;
  }

  Future<String> __uploadVideoToStore(String id, String videoPath) async {
    Reference ref = firebaseStore.ref().child("thumbnails").child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String song, String caption, String videoPath) async {
    try {
      String uid = firbaseAuth.currentUser!.uid;
      DocumentSnapshot userDocs =
          await firebaseFirestore.collection("users").doc(uid).get();
      // git id
      var allDocs = await firebaseFirestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStore("Video $len", videoPath);
      String thumnail = await _uploadVideoToStore("Video $len", videoPath);
      Video video = Video(
          id: "Video $len",
          username: (userDocs.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          likes: [],
          comentCount: 0,
          shereCount: 0,
          songName: 'songName',
          caption: caption,
          profilePhoto:
              (userDocs.data()! as Map<String, dynamic>)['profilePhoto'],
          thumbnail: thumnail,
          videoUrl: videoUrl);
      await firebaseFirestore
          .collection("Video")
          .doc("Video $len")
          .set(video.toJson());
      Get.back();
      return videoUrl;
    } catch (e) {
      Get.snackbar("Error uploading Vido", e.toString());
    }
  }
}
