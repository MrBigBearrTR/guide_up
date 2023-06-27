import 'package:flutter/material.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/pages/search/category/category_card.dart';
import 'package:guide_up/pages/search/category/list_size_control.dart';
import 'package:guide_up/repository/category/category_repository.dart';
import 'package:guide_up/ui/material/custom_material.dart';

import '../../core/constant/color_constants.dart';
import '../../core/utils/secure_storage_helper.dart';

class SearchSidePage extends StatefulWidget {
  const SearchSidePage({Key? key}) : super(key: key);

  @override
  State<SearchSidePage> createState() => _SearchSidePageState();
}

class _SearchSidePageState extends State<SearchSidePage> {
  UserDetail? _userDetail;

  @override
  void initState() {
    super.initState();
    getDetailFromSecureStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  ColorConstants.theme2DarkBlue,
                  ColorConstants.theme2DarkBlue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              accountName: const Text('Hoşgeldin'),
              accountEmail: Text(_userDetail != null
                  ? (" ${_userDetail!.getName()!} ${_userDetail!.getSurname()!}")
                  : ""),
              currentAccountPicture: Image.asset("assets/img/GuideUpLogo.png"),
            ),
            Expanded(
              child: FutureBuilder(
                builder: (context, categorySnap) {
                  if (categorySnap.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final category = categorySnap.data![index];
                        ListSizeControl listSizeControl=ListSizeControl();
                        listSizeControl.setListSize(categorySnap.data!.length);
                        return CategoryCard(headerCount: 0, category: category,mainListSizeControl: listSizeControl,);
                      },
                      itemCount: categorySnap.data!.length,
                      padding: const EdgeInsets.all(0),
                    );
                  } else {
                    return const Text("Veri Yok");
                  }
                },
                future: CategoryRepository().getMainCategoryList(),
              ),
            ),
          ],
        ));
  }

  void getDetailFromSecureStorage() async {
    _userDetail = await SecureStorageHelper().getUserDetail();
    setState(() {});
  }
}
