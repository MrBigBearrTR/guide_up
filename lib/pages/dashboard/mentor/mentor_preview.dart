import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/core/models/mentor/mentor_model.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';
import '../../../core/constant/color_constants.dart';
import '../../../ui/material/custom_material.dart';

class MentorPreview extends StatefulWidget {
  const MentorPreview({Key? key}) : super(key: key);

  @override
  State<MentorPreview> createState() => _MentorPreviewState();
}

class _MentorPreviewState extends State<MentorPreview> {
  Mentor? _mentor;

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
            bottom: 150,
            left: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Ali Yalçın',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Button click actions
                      },
                      child: Text(
                        '#1500/ per session',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Hakkında',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width - 90,
                  child: Text(
                    'I have worked on many projects that appeal to and are used by thousands of users, such as HBYS and specifically the Mobile Nurse project, E-Campus for Universities, modules specially designed for medical faculties, and Payment systems for banks. If I have to define myself, I can describe the words I will use as highly adaptable, have a wide imagination, fun, open to learning at any time and as a team player.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Button click actions
                      },
                      child: Text(
                        'java dev',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        // Button click actions
                      },
                      child: Text(
                        'flutter',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
