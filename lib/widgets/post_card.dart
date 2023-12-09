import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/models/user.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/resources/firestore_methods.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 6),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap.get('profileImage'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap.get('username'),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Text(snap.get('username'), style: TextStyle()),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: ListView(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: [
                                  'Delete',
                                ]
                                    .map((e) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ));
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async{
              await FirestoreMethods().likePost(widget.snap.get('postId'), user.uid, widget.snap.get('likes'));
              setState(() {
                isLikeAnimating=true;
              });

            },
            child: Stack(
              alignment: Alignment.center,
              children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.network(
                  widget.snap.get('postUrl'),
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                onEnd: (){
                  setState(() {
                    isLikeAnimating=false;
                  });
                },
                child: LikeAnimation(
                  child: Icon(Icons.favorite, color: Colors.white, size: 130,),
                  isAnimating: isLikeAnimating,
                  duration: Duration(milliseconds: 400),
                  onEnd: (){
                    setState(() {
                      isLikeAnimating=false;
                    });
                  },
                ),
              ),
            ]),
          ),
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap.get('likes').contains(user.uid),
                smallLike: true,
                child: IconButton(
                  icon: widget.snap.get('likes').contains(user.uid)?
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ) :
                  Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                  ) ,
                  onPressed: () async{
                    await FirestoreMethods().likePost(widget.snap.get('postId'), user.uid, widget.snap.get('likes'));
                  },
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.comment_rounded,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                ),
                onPressed: () {},
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 6),
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.bookmark_border,
                      size: 28,
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.snap.get('likes').length.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: primaryColor),
                        children: [
                          TextSpan(
                              text: widget.snap.get('username'),
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: "  " + widget.snap.get('description'),
                          ),
                        ]),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "View all 203 comments",
                      style: TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap.get('datePublished').toDate())
                        .toString(),
                    style: TextStyle(fontSize: 12, color: secondaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
