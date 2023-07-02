import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';

class TestDataControl extends StatefulWidget {
  const TestDataControl({Key? key}) : super(key: key);

  @override
  State<TestDataControl> createState() => _TestDataControlState();
}

class _TestDataControlState extends State<TestDataControl> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserDetail? _userDetail;

  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore islemleri"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => veriEklemeAdd(),
                child: Text(_userDetail != null
                    ? (" ${_userDetail!.getName()!} ${_userDetail!.getSurname()!}")
                    : "Name")),
            ElevatedButton(
                onPressed: () => veriEklemeSet(),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Veri ekle set")),
            ElevatedButton(
                onPressed: () => sorgula(),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Veri sorgula")),
          ],
        ),
      ),
    );
  }

  void veriEklemeAdd() async {
    /*if (_userDetail!=null) {
      Post post = Post();
      post.setUserId(_userDetail!.getUserId()!);
      post.setTopic("Kişilik geliştirmek için youtube doğru adres mi?");
      post.setContent("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et fringilla lectus. Nam luctus libero sit amet ex molestie tincidunt. Praesent ante arcu, ullamcorper sed laoreet sed, sollicitudin ac eros. Aliquam eros purus, auctor et augue quis, lobortis laoreet mauris. Donec vitae tincidunt sem, tempus interdum lacus. Praesent tincidunt quam eget sem convallis dignissim. Morbi sit amet mauris id ipsum sollicitudin volutpat. Vestibulum ultricies facilisis mauris a elementum. Aliquam suscipit porta condimentum. Mauris lacinia odio nisl, a ornare dui venenatis vel. Nunc nec aliquet sapien.");
      post.setThereCategory(true);

      post=await PostRepository().add(post);

      PostCategories postCategories=PostCategories();
      postCategories.setPostId(post.getId()!);
      postCategories.setUserId(_userDetail!.getUserId()!);
      postCategories.setCategoryId("1UmLUdGosQZCciwc4mxm");

      PostCategoriesRepository().add(postCategories);

      PostCategories postCategories2=PostCategories();
      postCategories2.setPostId(post.getId()!);
      postCategories2.setUserId(_userDetail!.getUserId()!);
      postCategories2.setCategoryId("2DmE4ImlnHyobmKSMIYT");

      PostCategoriesRepository().add(postCategories2);

      PostCategories postCategories3=PostCategories();
      postCategories3.setPostId(post.getId()!);
      postCategories3.setUserId(_userDetail!.getUserId()!);
      postCategories3.setCategoryId("1oQxgF7AvvYo5fyLgTQk");

      PostCategoriesRepository().add(postCategories3);
    }*/
  }

  void veriEklemeSet() async {
    Map<String, dynamic> _eklenecekUser = {};
    _eklenecekUser['username'] = "aliEdited3";
    await _firestore
        .doc('users/k4ZkoHi7iYGZoltkVGYk')
        .set(_eklenecekUser, SetOptions(merge: true));
  }

  void sorgula() async {
    CollectionReference<Map<String, dynamic>> gelen =
        await _firestore.collection("users/");
    var _sorgu = await gelen.where('username', isEqualTo: 'ali').get();

    print(_sorgu.docs);
  }

  UserDetail readUserDetail(String userId) {
    UserDetail det = UserDetail();
    det.setName("Helin");
    return det;
  }

  void getUserDetail() async {
    UserDetail? detail = await SecureStorageHelper().getUserDetail();
    if (detail == null) {
      detail = null;
    } else {
      _userDetail = detail;
      setState(() {});
    }
  }
}
