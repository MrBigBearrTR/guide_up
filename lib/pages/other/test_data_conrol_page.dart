import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/models/users/user_model.dart';

class TestDataControl extends StatefulWidget {
  const TestDataControl({Key? key}) : super(key: key);

  @override
  State<TestDataControl> createState() => _TestDataControlState();
}

class _TestDataControlState extends State<TestDataControl> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
                child: Text(readUserDetail("aa").getName()!)),
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
    User userModel = User();
    userModel.setEmail("aliyalcin");
    userModel.setPassword("pass");
    userModel.setUsername("MrBigBear");
    userModel.setMentor(true);
    print(userModel.toMap());

    /* Map<String,dynamic> _eklenecekUser={};
    _eklenecekUser['username']="ali";
    _eklenecekUser['password']="123";
    _eklenecekUser['email']="ali@yalcin.com";
    _eklenecekUser['is_active']=true;
    _eklenecekUser['create_date']=FieldValue.serverTimestamp();
    _eklenecekUser['create_user']="admin";
    _eklenecekUser['update_date']=FieldValue.serverTimestamp();
    _eklenecekUser['update_user']="admin";
    //_eklenecekUser['link_type']=EnumLinkType.INSTAGRAM;*/
    var veri = await _firestore.collection('users').add(userModel.toMap());

    print(veri);
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


  UserDetail readUserDetail(String userId){
    UserDetail det=UserDetail();
    det.setName("Helin");
    return det;
  }
}
