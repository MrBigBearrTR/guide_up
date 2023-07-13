import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/mentor/mentor_model.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';
import 'package:guide_up/pages/dashboard/mentor/mentor_feedback_page.dart';
import '../../../core/constant/color_constants.dart';
import '../../../core/utils/secure_storage_helper.dart';
import '../../../ui/material/custom_material.dart';

class MentorPreview extends StatefulWidget {
  const MentorPreview({Key? key}) : super(key: key);

  @override
  State<MentorPreview> createState() => _MentorPreviewState();
}

class _MentorPreviewState extends State<MentorPreview> {
  String? userId;
  Mentor? _mentor;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId() async {
    if (userId == null) {
      String? tempUserId = await SecureStorageHelper().getUserId();
      if (tempUserId != null) {
        setState(() {
          userId = tempUserId;
        });
      } else {
        // Kullanıcı oturum açmamışsa veya kimlik doğrulama kullanmıyorsa,
        // userId değerini uygun şekilde ayarlamanız gerekecektir.
      }
    }
  }

  final GlobalKey _popupKey = GlobalKey();
  bool _isPopupOpen = false;

  @override
  Widget build(BuildContext context) {
    _mentor = ModalRoute.of(context)!.settings.arguments as Mentor;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: CustomMaterial.backgroundBoxDecoration,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: ClipRRect(
              child: Image(
                image: UserInfoHelper.getProfilePictureByPath(_mentor != null ? _mentor!.getPhoto() : ""),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.theme2DarkBlue,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: ColorConstants.theme2Orange,
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.theme2DarkBlue,
              ),
              child: InkWell(
                onTap: () {
                  // Button click actions
                },
                child: const Icon(
                  Icons.favorite_border,
                  color: ColorConstants.theme2Orange,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (" ${_mentor!.getName() ?? ""} ${_mentor!.getSurname() ?? ""}"),
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.itemBlack,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '#1500/ per session',
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: ColorConstants.appcolor1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: ColorConstants.warning,
                      ),
                      const Icon(
                        Icons.star,
                        color: ColorConstants.warning,
                      ),
                      const Icon(
                        Icons.star,
                        color: ColorConstants.warning,
                      ),
                      const Icon(
                        Icons.star,
                        color: ColorConstants.warning,
                      ),
                      const Icon(
                        Icons.star,
                        color: ColorConstants.warning,
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouterConstants.mentorFeedbackPage);
                        },
                        child: Text(
                          'Yorumlar',
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: ColorConstants.appcolor1,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Hakkında',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    color: ColorConstants.itemBlack,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 90,
                  child: Text(
                    'I have worked on many projects that appeal to and are used by thousands of users, such as HBYS and specifically the Mobile Nurse project, E-Campus for Universities, modules specially designed for medical faculties, and Payment systems for banks. If I have to define myself, I can describe the words I will use as highly adaptable, have a wide imagination, fun, open to learning at any time and as a team player.',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: ColorConstants.itemBlack,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Button click actions
                      },
                      child: Text(
                        'java dev',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          color: ColorConstants.appcolor1,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        // Button click actions
                      },
                      child: Text(
                        'flutter',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          color: ColorConstants.appcolor1,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Sosyal Medya Hesapları:',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    color: ColorConstants.itemBlack,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  color: ColorConstants.itemWhite,
                  width: MediaQuery.of(context).size.width - 90,
                  child: Row(
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
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isPopupOpen = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 75), backgroundColor: ColorConstants.theme1DarkBlue,
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
              ],
            ),
          ),
          if (_isPopupOpen) _buildPopup(),
        ],
      ),
    );
  }

  Widget _buildPopup() {
    return Positioned(
      key: _popupKey,
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isPopupOpen = false;
          });
        },
        child: Container(
          color: ColorConstants.itemBlack.withOpacity(0.5),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorConstants.itemWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Mentor’e İlk Mesaj',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.itemBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    maxLines: null, // Birden fazla satır girişi için maxLines'ı null yapın
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: ColorConstants.itemBlack,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Yorumunuzu girin',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Butonları ortala
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isPopupOpen = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: ColorConstants.theme1DarkBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'İptal',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.itemWhite,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8), // İki düğme arasına bir boşluk ekleyin
                      ElevatedButton(
                        onPressed: () {
                          // Tamam butonuna tıklanınca yapılacak işlemler
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: ColorConstants.theme1DarkBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Gönder',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.itemWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}
