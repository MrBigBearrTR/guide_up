import 'package:flutter/material.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/user_info_helper.dart';
import 'package:guide_up/pages/search/category/category_card.dart';
import 'package:guide_up/pages/search/category/category_select_helper.dart';
import 'package:guide_up/pages/search/category/list_size_control.dart';
import 'package:guide_up/repository/category/category_repository.dart';
import 'package:guide_up/ui/material/custom_material.dart';

import '../../core/constant/color_constants.dart';
import '../../core/utils/secure_storage_helper.dart';
import '../../core/utils/user_helper.dart';

class SearchSidePage extends StatefulWidget {
  final CategorySelectHelper selector;

  const SearchSidePage({Key? key, required this.selector}) : super(key: key);

  @override
  State<SearchSidePage> createState() => _SearchSidePageState(selector);
}

class _SearchSidePageState extends State<SearchSidePage> {
  UserDetail? _userDetail;
  final CategorySelectHelper selector;

  _SearchSidePageState(this.selector);

  @override
  void initState() {
    super.initState();
    getDetailFromSecureStorage();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, padding.top, 0, 20),
              decoration: BoxDecoration(
                color: ColorConstants.background,
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: ColorConstants.theme1White,
                      backgroundImage: UserInfoHelper.getProfilePicture(_userDetail),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        _userDetail != null
                            ? (" ${_userDetail!.getName() ?? ""} ${_userDetail!.getSurname() ?? ""}")
                            : "Hoşgeldiniz!",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: ColorConstants.appcolor4,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        UserHelper().auth.currentUser != null
                            ? UserHelper().auth.currentUser!.email!
                            : "",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorConstants.appcolor4,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                builder: (context, categorySnap) {
                  if (categorySnap.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (categorySnap.hasError) {
                    return const Center(
                      child: Text('Veriler alınırken bir hata oluştu.'),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final category = categorySnap.data![index];
                        ListSizeControl listSizeControl = ListSizeControl();
                        listSizeControl.setListSize(categorySnap.data!.length);
                        return CategoryCard(
                          headerCount: 0,
                          category: category,
                          mainListSizeControl: listSizeControl,
                          selector: selector,
                        );
                      },
                      itemCount: categorySnap.data!.length,
                      padding: const EdgeInsets.all(0),
                    );
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
