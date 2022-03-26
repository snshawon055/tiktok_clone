import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/color/colors.dart';
import 'package:tiktok_clone/models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videList => _videoList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videoList.bindStream(
      firebaseFirestore.collection('videos').snapshots().map(
        (QuerySnapshot quer) {
          List<Video> retVal = [];
          for (var element in quer.docs) {
            retVal.add(Video.fromSnap(element));
          }
          return retVal;
        },
      ),
    );
  }

  likeVideo(String id) async {
    DocumentSnapshot doc =
        await firebaseFirestore.collection("videos").doc(id).get();
    var uid = authController.user.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firebaseFirestore.collection("likes").doc(uid).update({
        "likes": FieldValue.arrayRemove([uid]),
      });
    } else {
      await firebaseFirestore.collection("likes").doc(uid).update({
        "likes": FieldValue.arrayUnion([uid]),
      });
    }
  }
}
