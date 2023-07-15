import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/enumeration/enums/EnLikeSaveType.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';
import 'package:guide_up/repository/post/comment/comment_repository.dart';
import 'package:guide_up/service/post/post_like_save_service.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/constant/router_constants.dart';
import '../../../core/dto/post/post_card_view.dart';

class GuideCard extends StatefulWidget {
  final PostCardView postCardView;
  final String userId;

  const GuideCard({Key? key, required this.postCardView, required this.userId})
      : super(key: key);

  @override
  State<GuideCard> createState() => _GuideCardState();
}


class _GuideCardState extends State<GuideCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.theme1White,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(
                  context, RouterConstants.guideDetailPage,
                  arguments: widget.postCardView);
            },
            title: Text(
              widget.postCardView.topic ?? "",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.darkBack,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.postCardView.userFullName}",
                  maxLines: 1,
                  softWrap: true,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: ColorConstants.background,
                    ),
                  ),
                ),
                Text(
                  widget.postCardView.content ?? "",
                  maxLines: 4,
                  softWrap: true,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 11,
                      color: ColorConstants.background,
                    ),
                  ),
                ),
              ],
            ),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: UserInfoHelper.getProfilePictureByPath(
                  widget.postCardView.userPhoto),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //FOTOĞRAF İLE GENİŞLİK EŞİTLEMEK İÇİN WİDGET
                Text(""),
                //YORUM BUTONU
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouterConstants.guideDetailPage,
                        arguments: widget.postCardView)
                        .then((value) {
                      CommentRepository()
                          .getPostCommentCount(widget.postCardView.id!)
                          .then((value) {
                        widget.postCardView.commentCount = value;
                      });
                      setState(() {});
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.comment,
                          color: ColorConstants.darkBack,
                        ),
                      ),
                      Text(
                        "${widget.postCardView.commentCount}",
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //BEĞEN BUTONU
                GestureDetector(
                  onTap: () {
                    if (widget.userId.isNotEmpty) {
                      if (!widget.postCardView.isLikeUser) {
                        PostLikeSaveService()
                            .add(widget.userId, widget.postCardView.id!,
                            EnLikeSaveType.like)
                            .then((value) {
                          if (value.getId() != null) {
                            widget.postCardView.isLikeUser = true;
                            widget.postCardView.likeId = value.getId()!;
                            widget.postCardView.likeCount += 1;
                            setState(() {});
                          }
                        });
                      } else {
                        PostLikeSaveService()
                            .deleteById(widget.postCardView.likeId!)
                            .then((value) {
                          widget.postCardView.isLikeUser = false;
                          widget.postCardView.likeId = null;
                          widget.postCardView.likeCount -= 1;
                          setState(() {});
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: ColorConstants.buttonPurple,
                          content: Text(
                            'Üye olmayan kullanıcı beğenme yapamaz.Lütfen Giriş yapınız :)',
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.darkBack,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          widget.postCardView.isLikeUser
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.postCardView.isLikeUser
                              ? ColorConstants.buttonPurple
                              : ColorConstants.darkBack,
                        ),
                      ),
                      Text(
                        "${widget.postCardView.likeCount}",
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //KAYDET BUTONU
                GestureDetector(
                  onTap: () {
                    if (widget.userId.isNotEmpty) {
                      if (!widget.postCardView.isSaveUser) {
                        PostLikeSaveService()
                            .add(widget.userId, widget.postCardView.id!,
                            EnLikeSaveType.save)
                            .then((value) {
                          if (value.getId() != null) {
                            widget.postCardView.isSaveUser = true;
                            widget.postCardView.saveId = value.getId()!;
                            setState(() {});
                          }
                        });
                      } else {
                        PostLikeSaveService()
                            .deleteById(widget.postCardView.saveId!)
                            .then((value) {
                          widget.postCardView.isSaveUser = false;
                          widget.postCardView.saveId = null;
                          setState(() {});
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: ColorConstants.buttonPurple,
                          content: Text(
                            'Üye olmayan kullanıcı kaydetme yapamaz.Lütfen Giriş yapınız :)',
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.darkBack,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          widget.postCardView.isSaveUser
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: widget.postCardView.isSaveUser
                              ? ColorConstants.theme1Mustard
                              : ColorConstants.darkBack,
                        ),
                      ),
                    ],
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
