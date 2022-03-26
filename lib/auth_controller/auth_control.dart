import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/color/colors.dart';
import 'package:tiktok_clone/models/user.dart' as model;
import 'package:tiktok_clone/screen/home_screen.dart';
import 'package:tiktok_clone/screen/login_screen.dart';
import 'package:tiktok_clone/screen/sign_up_screen.dart';

class AuthController extends GetxController {
  late Rx<File?> _picImage;
  File? get profilePhoto => _picImage.value;
  void picImg() async {
    final picedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picedImage != null) {
      Get.snackbar("Profile Picture",
          "You have successfully selected your profile picture!");
    } else {
      Get.snackbar("Error the profile pic", "you don't have to select image");
    }
    _picImage = Rx<File?>(File(picedImage!.path));
  }

  static AuthController instance = Get.find();

  // imgStore
  Future<String> _uploadStore(File img) async {
    Reference raf = firebaseStore
        .ref()
        .child("profilePics")
        .child(firbaseAuth.currentUser!.uid);
    UploadTask uploadTask = raf.putFile(img);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // register user
  late Rx<User?> _user;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firbaseAuth.currentUser);
    _user.bindStream(firbaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  void registerUser(
    String username,
    String email,
    String password,
    File? img,
  ) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          img != null) {
        UserCredential cred = await firbaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadStore(img);
        model.User user = model.User(
          name: username,
          email: email,
          profilePhoto: downloadUrl,
          uid: cred.user!.uid,
        );
        await firebaseFirestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
          "Error Creating Account",
          "Please enter all filds",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error Creating Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firbaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar(
          "Error Login In",
          "Please enter all filds",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error Login In",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void singOut() async {
    await firbaseAuth.signOut();
  }

  void followUser() {}
}
