import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guide_up/core/constant/RouterConstants.dart';
import 'package:guide_up/core/constant/constants.dart';
import 'package:guide_up/utils/user_helper.dart';

final List<String> imgList = [
  'https://teach.com/wp-content/uploads/sites/56/2022/03/what-is-a-mentor.png',
  'https://images1.welcomesoftware.com/Zz0xYWZiMThkNjI1NDYxMWVkODJkZjdhNjM2MmRjMGQ2OA==?width=800&q=80',
  'https://www.revista.unam.mx/wp-content/uploads/img2-35.jpg',
  'https://ideas.ted.com/wp-content/uploads/sites/3/2018/09/featured_art_mentor_istock.jpg',
];
final List<String> eventList = [
  'https://www.talentlms.com/blog/wp-content/uploads/2021/07/Sample-Training-Announcement-Email.png',
  'https://www.talentlms.com/blog/wp-content/uploads/2021/07/training-invitation-email.png',
  'https://partner.ed2go.com/wp-content/uploads/2016/07/career-training-program-email-template-banner.jpg',
  'https://www.slideteam.net/wp/wp-content/uploads/2023/02/Scrum-Board-Samples-1013x441.jpg',
];

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = 'Helin';
  FlutterSecureStorage preference = const FlutterSecureStorage();

  void getSecurityStorage(BuildContext context) async {
    if (!(await preference.containsKey(key: Constants.FIRST_SIGIN_KEY))) {
      Navigator.pushReplacementNamed(context, "/splashScreen");
      // MaterialPageRoute(builder:(context)=> const SplashScreen());
    }
  }

  //const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getSecurityStorage(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Hoşgeldin $userName!',
          style: const TextStyle(
            color: Color.fromARGB(255, 23, 89, 201),
            fontSize: 25,
          ),
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
            //color: const Color(0xFF4A9D93),
            color: const Color.fromARGB(255, 23, 89, 201),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            color: const Color.fromARGB(255, 23, 89, 201),
          ),
          IconButton(
            onPressed: () async {
              if (await UserHelper().checkUser()) {
                Navigator.pushNamed(context, RouterConstants.profilePage);
              } else {
                Navigator.pushNamed(context, RouterConstants.loginPage);
              }
            },
            icon: const Icon(Icons.person),
            color: const Color.fromARGB(255, 23, 89, 201),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.amber,
        items: const <Widget>[
          Icon(Icons.home, size: 25),
          Icon(Icons.search, size: 25),
          Icon(Icons.dashboard, size: 25),
          Icon(Icons.diversity_1, size: 25),
          Icon(Icons.comment, size: 25),
        ],

        // onTap: (index) {
        //   //Handle button tap
        // },
      ),
      body: HomeScreenBody(),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: imgList
                    .map(
                      (item) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(item, fit: BoxFit.contain),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  height: 250,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'En Sevilen Mentorlar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Hepsini Gör',
                      style: TextStyle(
                        color: Color.fromARGB(255, 23, 89, 201),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                    color: Color.fromARGB(221, 241, 238, 238),
                    child: const Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://media.licdn.com/dms/image/D4D03AQEIKjOOeI3xjQ/profile-displayphoto-shrink_800_800/0/1679749604159?e=2147483647&v=beta&t=S_nH42SUC7g-mMjInbFLzwODI4XC34UTFJq-g_PUtUs'),
                          radius: 35,
                        ),
                        Text(
                          'Atıl Samancıoğlu',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                          ],
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Mobil Uygulama',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          color: Colors.green,
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Bilişim Teknolojileri',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  //2.
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                    color: Color.fromARGB(221, 241, 238, 238),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://media.licdn.com/dms/image/C5603AQHtIwcnE07XNA/profile-displayphoto-shrink_800_800/0/1549900900418?e=2147483647&v=beta&t=l6X_3t9Gq5ypAfS-cNMAjEYLj656v-xSefoBCdGKlas'),
                          radius: 35,
                        ),
                        Text(
                          'Sercan Yusuf',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: 17,
                            ),
                          ],
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Mobil Uygulama',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          color: Colors.green,
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Front-End',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          color: Colors.red[500],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Yaklaşan Etkinlikler',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              CarouselSlider(
                items: eventList
                    .map(
                      (item) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(item, fit: BoxFit.contain),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  height: 250,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Senin için Önerilenler',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Hepsini Gör',
                      style: TextStyle(
                        color: Color.fromARGB(255, 23, 89, 201),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                    color: Color.fromARGB(221, 241, 238, 238),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://media.licdn.com/dms/image/D4D03AQEIKjOOeI3xjQ/profile-displayphoto-shrink_800_800/0/1679749604159?e=2147483647&v=beta&t=S_nH42SUC7g-mMjInbFLzwODI4XC34UTFJq-g_PUtUs'),
                          radius: 35,
                        ),
                        Text(
                          'Atıl Samancıoğlu',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                          ],
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Mobil Uygulama',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          color: Colors.green,
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Bilişim Teknolojileri',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  //2.
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                    color: Color.fromARGB(221, 241, 238, 238),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://media.licdn.com/dms/image/C5603AQHtIwcnE07XNA/profile-displayphoto-shrink_800_800/0/1549900900418?e=2147483647&v=beta&t=l6X_3t9Gq5ypAfS-cNMAjEYLj656v-xSefoBCdGKlas'),
                          radius: 35,
                        ),
                        Text(
                          'Sercan Yusuf',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: 17,
                            ),
                          ],
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Mobil Uygulama',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          color: Colors.green,
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Front-End',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          color: Colors.red[500],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// En sevilen 4-5 tane kaydırmalı manuel
