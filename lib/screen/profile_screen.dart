import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/auth_controller/auth_control.dart';
import 'package:tiktok_clone/auth_controller/profile_controller.dart';
import 'package:tiktok_clone/color/colors.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.users.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              leading: Icon(
                Icons.person_add_alt,
              ),
              actions: [
                Icon(
                  Icons.more_horiz,
                ),
              ],
              title: Text(
                controller.users['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: controller.users['profilePhoto'],
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  controller.users['following'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Following",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black54,
                              width: 1,
                              height: 15,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.users['followers'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Followers",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black54,
                              width: 1,
                              height: 15,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.users['likes'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Likes",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 47,
                          width: 140,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (widget.uid == authController.user.uid) {
                                authController.singOut();
                              } else {
                                authController.followUser();
                              }
                            },
                            child: Center(
                              child: Text(
                                widget.uid == authController.user.uid
                                    ? "Sign Out"
                                    : controller.users['isFollowing']
                                        ? 'Unfollow'
                                        : 'Follow',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.users['thumbnails'].length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 5),
                          itemBuilder: (context, index) {
                            String thumbnail =
                                controller.users["thumbnails"][index];
                            return CachedNetworkImage(
                                imageUrl: thumbnail, fit: BoxFit.cover);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
