import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/color/colors.dart';
import 'package:tiktok_clone/models/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchUser = Rx<List<User>>([]);

  List<User> get searchUser => _searchUser.value;

  SearchUser(String typeUser) async {
    _searchUser.bindStream(
      await firebaseFirestore
          .collection("users")
          .where("name", isGreaterThanOrEqualTo: typeUser)
          .snapshots()
          .map((QuerySnapshot quer) {
        List<User> retVal = ([]);
        for (var element in quer.docs) {
          retVal.add(User.fromSnap(element));
        }
        return retVal;
      }),
    );
  }
}
