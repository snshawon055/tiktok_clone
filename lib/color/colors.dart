import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/auth_controller/auth_control.dart';
import 'package:tiktok_clone/screen/add_video_screen.dart';
import 'package:tiktok_clone/screen/message_screen.dart';
import 'package:tiktok_clone/screen/profile_screen.dart';
import 'package:tiktok_clone/screen/search_screen.dart';
import 'package:tiktok_clone/screen/video_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColors = Colors.grey;

var firbaseAuth = FirebaseAuth.instance;
var firebaseStore = FirebaseStorage.instance;
var firebaseFirestore = FirebaseFirestore.instance;
var authController = AuthController.instance;

List pages = [
  VideoScreen(),
  SearchScreen(),
  AddVideoScreen(),
  MessageScreen(),
  ProfileScreen(uid: authController.user.uid)
];
