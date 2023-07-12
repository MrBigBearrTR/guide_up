import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/enumeration/enums/EnLikeSaveType.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';
import 'package:guide_up/service/post/post_like_save_service.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/dto/post/post_card_view.dart';

class GuideCard extends StatelessWidget {
  final PostCardView postCardView;
  final String userId;

  const GuideCard({Key? key, required this.postCardView, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.theme1White,
      child: Column(
        children: [
          ListTile(
            title: Text(
              postCardView.topic ?? "",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.theme2Dark,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${postCardView.userFullName}",
                  maxLines: 1,
                  softWrap: true,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: ColorConstants.theme2DarkBlue,
                    ),
                  ),
                ),
                Text(
                  postCardView.content ?? "",
                  maxLines: 4,
                  softWrap: true,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 11,
                      color: ColorConstants.theme2DarkBlue,
                    ),
                  ),
                ),
              ],
            ),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: UserInfoHelper.getProfilePictureByPath(
                  postCardView.userPhoto),
            ),
          ),
          Visibility(
            visible: userId.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(""),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          maxRadius: 20,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.comment,
                            color: ColorConstants.theme2Dark,
                          ),
                        ),
                        Text(
                          "${postCardView.commentCount}",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.theme2DarkBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!postCardView.isSaveUser) {
                        PostLikeSaveService()
                            .add(userId, postCardView.id!, EnLikeSaveType.like);
                      } else {
                        PostLikeSaveService().deleteById(postCardView.likeId!);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: 20,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            postCardView.isLikeUser
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: postCardView.isLikeUser
                                ? ColorConstants.theme2Orange
                                : ColorConstants.theme2Dark,
                          ),
                        ),
                        Text(
                          "${postCardView.likeCount}",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.theme2DarkBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!postCardView.isSaveUser) {
                        PostLikeSaveService()
                            .add(userId, postCardView.id!, EnLikeSaveType.save);
                      } else {
                        PostLikeSaveService().deleteById(postCardView.saveId!);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: 20,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            postCardView.isSaveUser
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: postCardView.isSaveUser
                                ? ColorConstants.theme1Mustard
                                : ColorConstants.theme2Dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
