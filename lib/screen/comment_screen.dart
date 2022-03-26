import 'package:flutter/material.dart';
import 'package:tiktok_clone/auth_controller/comment_controller.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/color/colors.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.uploadPostId(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: commentController.comments.length,
                    itemBuilder: (context, intex) {
                      final comment = commentController.comments[intex];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(comment.profilePhoto),
                        ),
                        title: Row(
                          children: [
                            Text(
                              "${comment.username}  ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              comment.comment,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              tago.format(comment.datePublished.toDate()),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${comment.likes.length} likes',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {
                            commentController.likeComment(comment.id);
                          },
                          child: Icon(
                            Icons.favorite,
                            size: 25,
                            color:
                                comment.likes.contains(authController.user.uid)
                                    ? Colors.red
                                    : Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              const Divider(),
              ListTile(
                leading: TextFormField(
                  controller: _commentController,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: "Comment",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                    onPressed: () {
                      commentController.postComment(_commentController.text);
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
