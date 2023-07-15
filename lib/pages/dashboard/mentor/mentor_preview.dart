import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/category/category_model.dart';
import 'package:guide_up/core/models/mentor/mentor_model.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/models/users/user_detail/user_links_model.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';
import 'package:guide_up/repository/mentor/mentor_favourite_repository.dart';
import 'package:guide_up/repository/user/user_detail/user_links_repository.dart';
import 'package:guide_up/service/conversation/conversation_service.dart';
import 'package:guide_up/service/user/user_detail/user_categories_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/models/mentor/mentor_favourite_model.dart';
import '../../../core/utils/secure_storage_helper.dart';
import '../../../ui/material/custom_material.dart';

class MentorPreview extends StatefulWidget {
  const MentorPreview({Key? key}) : super(key: key);

  @override
  State<MentorPreview> createState() => _MentorPreviewState();
}

class _MentorPreviewState extends State<MentorPreview> {
  UserDetail? _userDetail;
  late Mentor _mentor;
  List<Category> categoryList = [];
  List<UserLinks> userLinksList = [];
  bool isGetData = false;
  MentorFavourite? _mentorFavourite;
  final TextEditingController _mentorMessageController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId() async {
    if (_userDetail == null) {
      _userDetail = await SecureStorageHelper().getUserDetail();
      if (_userDetail != null) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _mentor = ModalRoute.of(context)!.settings.arguments as Mentor;
    getData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          (" ${_mentor.getName() ?? ""} ${_mentor.getSurname() ?? ""}"),
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorConstants.itemBlack,
          ),
        ),
        actions: [
          Visibility(
            visible: _userDetail != null,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                child: IconButton(
                    onPressed: () async {
                      if (_mentorFavourite != null) {
                        MentorFavouriteRepository().delete(_mentorFavourite!);
                        _mentorFavourite = null;
                      } else {
                        _mentorFavourite = MentorFavourite();
                        _mentorFavourite!.setUserId(_userDetail!.getUserId()!);
                        _mentorFavourite!.setMentorId(_mentor.getId()!);
                        _mentorFavourite = await MentorFavouriteRepository()
                            .add(_mentorFavourite!);
                      }
                      setState(() {});
                    },
                    icon: Icon(_mentorFavourite != null
                        ? Icons.favorite
                        : Icons.favorite_border))),
          ),
        ],
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image:
                    UserInfoHelper.getProfilePictureByPath(_mentor.getPhoto()),
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.width / 5) * 4,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "Değerlendirme : ",
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.itemBlack,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: _mentor.getRate()! * 25,
                          height: 10,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 25,
                              );
                            },
                            itemCount: _mentor.getRate(),
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouterConstants.mentorComments,
                                arguments: _mentor);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(""),
                                Text(
                                  'Yorumlar',
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: ColorConstants.appcolor1,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Hakkımda : ",
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.itemBlack,
                      ),
                    ),
                    Text(
                      _mentor.getAbout() ?? "",
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: ColorConstants.itemBlack,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Kategorilerim : ",
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.itemBlack,
                      ),
                    ),
                    SizedBox(
                      height: categoryList.isNotEmpty ? 40 : 0,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final category = categoryList[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.theme1CloudBlue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                category.getName()!,
                                style: GoogleFonts.nunito(
                                  color: ColorConstants.theme1Dark,
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                        padding: const EdgeInsets.all(0),
                        itemCount: categoryList.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: userLinksList.isNotEmpty,
                      child: Text(
                        "Sosyal Medya Hesapları : ",
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.itemBlack,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: ColorConstants.itemWhite,
                      ),
                      child: SizedBox(
                        height: userLinksList.isNotEmpty ? 40 : 0,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemBuilder: (context2, index) {
                            final links = userLinksList[index];
                            return IconButton(
                              onPressed: () {
                                // Perform action for LinkedIn
                                final Uri url = Uri.parse(links.getLink()!);
                                launchUrl(url).then((value) {
                                  if (!value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor:
                                            ColorConstants.buttonPurple,
                                        content: Text(
                                          'Hatalı linle ulaşılamadı. Link;\n${links.getLink()}',
                                          style: GoogleFonts.nunito(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: ColorConstants.background,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                });
                              },
                              icon: UserInfoHelper.getEnLinkTypeIcon(
                                  links.getEnLinkType()!),
                              tooltip: links.getLink(),
                            );
                          },
                          padding: const EdgeInsets.all(0),
                          itemCount: userLinksList.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),

                      /*Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Perform action for LinkedIn
                            },
                            icon: const Icon(
                              Icons.link,
                              color: ColorConstants.appcolor1,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Perform action for Medium
                            },
                            icon: const Icon(
                              Icons.link,
                              color: ColorConstants.appcolor1,
                            ),
                          ),
                        ],
                      ),*/
                    ),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: _userDetail != null,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Mentor'a İlk Mesaj"),
                                content: TextFormField(
                                  controller: _mentorMessageController,
                                  maxLines: null,
                                  // Birden fazla satır girişi için maxLines'ı null yapın
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: ColorConstants.itemBlack,
                                  ),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Mesajınızı giriniz',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Tamam'),
                                    onPressed: () {
                                      if (_mentorMessageController
                                          .value.text.isNotEmpty) {
                                        ConversationService()
                                            .createNewConversation(
                                                _userDetail!,
                                                _mentor.getUserId()!,
                                                _mentorMessageController
                                                    .value.text);
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 75),
                          backgroundColor: ColorConstants.theme1DarkBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Bizimle İrtibata Geçin',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: ColorConstants.itemWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getData() async {
    if (!isGetData) {
      categoryList = await UserCategoriesService()
          .getUserCategoriesList(_mentor.getUserId()!);
      userLinksList = await UserLinksRepository()
          .getUserLinksByUserId(_mentor.getUserId()!);

      if (_userDetail != null) {
        _mentorFavourite = await MentorFavouriteRepository()
            .getMentorFavouriteByUserIdAndMentorId(
                _userDetail!.getUserId()!, _mentor.getId()!);
        setState(() {});
      }
      isGetData = true;
      setState(() {});
    }
  }
}
