import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/ui/material/custom_material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../core/utils/user_helper.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  UserDetail? userDetail;

  @override
  void initState() {
    super.initState();
    getUserDetail();
    UserHelper().getUserDetail();
  }

  void getUserDetail() async {
    UserDetail? detail = await SecureStorageHelper().getUserDetail();
    if (detail == null) {
      detail = null;
    } else {
      userDetail = detail;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Positioned(
          top: 20,
          left: 0,
          child: Container(
            width: 55,
            height: 55,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstants.theme2Orange,
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouterConstants.homePage);
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                color: ColorConstants.appcolor4,
              ),
            ),
          ),
        ),
        title: Text(
          "Profilim",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: ColorConstants.itemBlack,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: CustomMaterial.backgroundBoxDecoration,
          padding: const EdgeInsets.all(CupertinoScrollbar.defaultThickness),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.theme2DarkBlue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 52,
                      backgroundImage: AssetImage('assets/img/img.png'),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          '${userDetail != null ? (" ${userDetail!.getName() ?? ""} ${userDetail!.getSurname() ?? ""}") : ""}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: ColorConstants.appcolor4,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${UserHelper().auth.currentUser!.email}",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorConstants.appcolor4,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 30),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.theme1BrightCloudBlue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouterConstants.myProfileAccountPage);
                      },
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: ColorConstants.theme2DarkOpacity20,
                                    blurRadius: 25.0)
                              ],
                              shape: BoxShape.circle,
                              color: ColorConstants.theme1BrightCloudBlue),
                          child: const Icon(
                            LineAwesomeIcons.user_check,
                            color: ColorConstants.itemBlack,
                          ),
                        ),
                        title: Text(
                          "Hesabım",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorConstants.itemBlack,
                                  ),
                        ),
                        trailing: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: ColorConstants.theme2Orange,
                          ),
                          child: const Icon(LineAwesomeIcons.angle_right,
                              size: 18.0, color: ColorConstants.appcolor4),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0.01,
                      color: Colors.black12,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouterConstants.generalSettingsPage);
                      },
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: ColorConstants.theme2DarkOpacity20,
                                  blurRadius: 25.0)
                            ],
                            shape: BoxShape.circle,
                            color: ColorConstants.theme1BrightCloudBlue),
                        child: const Icon(
                          LineAwesomeIcons.cog,
                          color: ColorConstants.itemBlack,
                        ),
                      ),
                      title: Text(
                        "Genel Ayarlar",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorConstants.itemBlack,
                            ),
                      ),
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ColorConstants.theme2Orange,
                        ),
                        child: const Icon(
                          LineAwesomeIcons.angle_right,
                          size: 18.0,
                          color: ColorConstants.appcolor4,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0.01,
                      color: Colors.black12,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: ColorConstants.theme2DarkOpacity20,
                                  blurRadius: 25.0)
                            ],
                            shape: BoxShape.circle,
                            color: ColorConstants.theme1BrightCloudBlue),
                        child: const Icon(
                          LineAwesomeIcons.wallet,
                          color: ColorConstants.itemBlack,
                        ),
                      ),
                      title: Text(
                        "Ödeme Yöntemleri",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorConstants.itemBlack,
                            ),
                      ),
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ColorConstants.theme2Orange,
                        ),
                        child: const Icon(
                          LineAwesomeIcons.angle_right,
                          size: 18.0,
                          color: ColorConstants.appcolor4,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0.01,
                      color: Colors.black12,
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        UserHelper().signOut();
                        Navigator.pushReplacementNamed(
                            context, RouterConstants.homePage);
                      },
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: ColorConstants.theme2DarkOpacity20,
                                    blurRadius: 25.0)
                              ],
                              shape: BoxShape.circle,
                              color: ColorConstants.theme1BrightCloudBlue),
                          child: const Icon(
                            LineAwesomeIcons.alternate_sign_out,
                            color: ColorConstants.itemBlack,
                          ),
                        ),
                        title: Text(
                          "Çıkış Yap",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorConstants.itemBlack,
                                  ),
                        ),
                        trailing: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: ColorConstants.theme2Orange,
                          ),
                          child: const Icon(
                            LineAwesomeIcons.angle_right,
                            size: 18.0,
                            color: ColorConstants.appcolor4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.theme1BrightCloudBlue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: ColorConstants.theme2DarkOpacity20,
                                  blurRadius: 25.0)
                            ],
                            shape: BoxShape.circle,
                            color: ColorConstants.theme1BrightCloudBlue),
                        child: const Icon(
                          LineAwesomeIcons.question_circle,
                          color: ColorConstants.itemBlack,
                        ),
                      ),
                      title: Text(
                        "Yardım ve Destek",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorConstants.itemBlack,
                            ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouterConstants.helpAndSupport);
                      },
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ColorConstants.theme2Orange,
                        ),
                        child: const Icon(
                          LineAwesomeIcons.angle_right,
                          size: 18.0,
                          color: ColorConstants.appcolor4,
                        ),
                      ),

                    ),
                    const Divider(
                      height: 0.01,
                      color: Colors.black12,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: ColorConstants.theme2DarkOpacity20,
                                  blurRadius: 25.0)
                            ],
                            shape: BoxShape.circle,
                            color: ColorConstants.theme1BrightCloudBlue),
                        child: const Icon(
                          LineAwesomeIcons.info_circle,
                          color: ColorConstants.itemBlack,
                        ),
                      ),
                      title: Text(
                        "Hakkımızda",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorConstants.itemBlack,
                            ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouterConstants.aboutUs);
                      },
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ColorConstants.theme2Orange,
                        ),
                        child: const Icon(
                          LineAwesomeIcons.angle_right,
                          size: 18.0,
                          color: ColorConstants.appcolor4,
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
}
