import 'package:flutter/material.dart';
import 'package:tiktok_clone/auth_controller/search_controller.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/models/user.dart';
import 'package:tiktok_clone/screen/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: TextFormField(
              decoration: InputDecoration(
                filled: false,
                hintText: "Search",
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onFieldSubmitted: (value) => searchController.SearchUser(value),
            ),
          ),
          body: searchController.searchUser.isNotEmpty
              ? Center(
                  child: Text(
                    "Search for user!",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: searchController.searchUser.length,
                  itemBuilder: (context, index) {
                    User user = searchController.searchUser[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(uid: user.uid),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                            // backgroundImage: NetworkImage(user.profilePhoto),
                            ),
                        title: Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
