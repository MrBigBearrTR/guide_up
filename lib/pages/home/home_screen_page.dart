import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/router_constants.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';

import '../../core/utils/user_helper.dart';
import '../../ui/material/custom_material.dart';

final List<String> imgList = [
   'https://images1.welcomesoftware.com/Zz0xYWZiMThkNjI1NDYxMWVkODJkZjdhNjM2MmRjMGQ2OA==?width=800&q=80',
  'https://images1.welcomesoftware.com/Zz0xYWZiMThkNjI1NDYxMWVkODJkZjdhNjM2MmRjMGQ2OA==?width=800&q=80',
  'https://images1.welcomesoftware.com/Zz0xYWZiMThkNjI1NDYxMWVkODJkZjdhNjM2MmRjMGQ2OA==?width=800&q=80',
];
final List<String> eventList = [
  'https://partner.ed2go.com/wp-content/uploads/2016/07/career-training-program-email-template-banner.jpg',
  'https://partner.ed2go.com/wp-content/uploads/2016/07/career-training-program-email-template-banner.jpg',
  'https://partner.ed2go.com/wp-content/uploads/2016/07/career-training-program-email-template-banner.jpg',
  'https://partner.ed2go.com/wp-content/uploads/2016/07/career-training-program-email-template-banner.jpg',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void controlForSplashScreen(BuildContext context) async {
    if (await SecureStorageHelper().isFirstEnter()) {
      Navigator.pushReplacementNamed(context, "/splashScreen");
    }
  }

  @override
  Widget build(BuildContext context) {
    controlForSplashScreen(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Hoşgeldin${userDetail != null ? (" ${userDetail!.getName()!} ${userDetail!.getSurname()!}") : "iz!"}',
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
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
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
      body: Container(
          decoration: CustomMaterial.backgroundBoxDecoration,
          child: const HomeScreenBody()),
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
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: <Widget>[
                    Row(
                      children: [
                        //1.
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          width: 150,
                          margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                          //color: Color.fromARGB(221, 241, 238, 238),
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          width: 150,
                          margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                        //3.
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          width: 150,
                          margin: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                          child: const Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://media.licdn.com/dms/image/D4D03AQGfyly8QDDeLQ/profile-displayphoto-shrink_400_400/0/1684776604407?e=1692835200&v=beta&t=7UFOdQ4QniJcPsjWf0G_EpRD6MVwwteiqWl_nr2lVc4'),
                                radius: 35,
                              ),
                              Text(
                                'Tolgay Hıçkıran',
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
                                    'Unity',
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
                                    'Yaşam Koçluğu',
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
                        //4.
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          width: 150,
                          margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                          child: const Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://i0.wp.com/molekulerbiyolojivegenetik.org/wp-content/uploads/2017/03/CD_potre2-1.jpg?fit=406%2C471'),
                                radius: 35,
                              ),
                              Text(
                                'Canan Dağdeviren',
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
                                    'Fizik Mühendisliği',
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
                                    'Malzeme Bilimi',
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
                      ],
                    ),
                  ],
                ),
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
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: <Widget>[
                    Row(
                      children: [
                        //1.
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          width: 150,
                          margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          width: 150,
                          margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                        //3.
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          width: 150,
                          margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                          child: const Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://1k-cdn.com/resimler/yazarlar/9414_97dbe_1580070653.jpg'),
                                radius: 35,
                              ),
                              Text(
                                'Daron Acemoğlu',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    'Ekonomi',
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
                                    'Çalışma Ekonomisi',
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
                        //4.
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          width: 150,
                          margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                          child: const Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://avatars.githubusercontent.com/u/5469995?v=4'),
                                radius: 35,
                              ),
                              Text(
                                'Gökhan Kandemir',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    'Yazılım',
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
                                    'Yazılım Hizmetleri',
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
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ],
      ),

    );
  }
}//listView.builder ile mentorlar
//mentorlar card yapısı olacak başka bir sayfada