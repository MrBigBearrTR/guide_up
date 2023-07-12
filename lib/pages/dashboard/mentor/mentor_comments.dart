import 'package:flutter/material.dart';

import '../../../core/constant/color_constants.dart';
import '../../../ui/material/custom_material.dart';

class MentorComments extends StatelessWidget {
  const MentorComments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yorumlar',
          style: TextStyle(color: ColorConstants.itemBlack),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 100.0,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage('assets/logo/guideUpLogo.png'),
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Merhaba GuideUp',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    height: 100.0,
                    child: Card(color: ColorConstants.appcolor1,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage('assets/logo/guideUpLogo.png'),
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Merhaba GuideUp',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    height: 100.0,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage('assets/logo/guideUpLogo.png'),
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Merhaba GuideUp',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    height: 100.0,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage('assets/logo/guideUpLogo.png'),
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Merhaba GuideUp',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    height: 100.0,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage('assets/logo/guideUpLogo.png'),
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                    Icon(Icons.star, color: ColorConstants.warning),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Merhaba GuideUp',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    print('FAB Butonuna Basıldı');
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
