import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/navigation_constants.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/pages/post/post_card.dart';
import 'package:guide_up/pages/search/category/category_select_helper.dart';
import 'package:guide_up/pages/search/search_side_page.dart';
import 'package:guide_up/service/mentor/mentor_service.dart';
import 'package:guide_up/service/post/post_service.dart';

import '../../core/constant/color_constants.dart';
import '../../core/models/category/category_model.dart';
import '../../core/models/mentor/mentor_model.dart';
import '../../ui/material/custom_material.dart';
import '../home/mentor/mentor_card.dart';

class SearchMainPage extends StatefulWidget {
  final GlobalKey<CurvedNavigationBarState> navigationKey;

  const SearchMainPage({Key? key, required this.navigationKey})
      : super(key: key);

  @override
  State<SearchMainPage> createState() {
    return _SearchMainPageState(navigationKey);
  }
}

class _SearchMainPageState extends State<SearchMainPage> {
  final GlobalKey<CurvedNavigationBarState> navigationKey;

  _SearchMainPageState(this.navigationKey);

  final TextEditingController _searchController = TextEditingController();
  late UserDetail? detail;
  final CategorySelectHelper _categorySelectHelper = CategorySelectHelper();
  List<Category> categoryList = [];
  List<Mentor> _mentorList = [];
  bool _isSearch = true;
  bool _isOnlyMentor = true;
  String _searchSwitchTitle = "Sadece Mentor";

  @override
  void initState() {
    super.initState();
    getDetail();
    _categorySelectHelper.addListener(() {
      if (_categorySelectHelper.categoryList.length != categoryList.length) {
        categoryList.clear();
        setState(() {
          categoryList.addAll(_categorySelectHelper.categoryList);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          'Araştırma Zamanı',
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
                color: ColorConstants.theme2Dark, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: Drawer(
        child: SearchSidePage(selector: _categorySelectHelper),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.theme1BrightCloudBlue,
                borderRadius: _isSearch
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                    : const BorderRadius.all(Radius.zero),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // Add padding around the search bar
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  // Use a Material design search bar
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Ara..',
                      // Add a clear button to the search bar
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _isSearch = true;
                          _searchController.clear();
                          setState(() {});
                        },
                      ),
                      // Add a search icon or button to the search bar
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          _isSearch = false;
                          search();
                          setState(() {});
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !_isSearch,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.theme1BrightCloudBlue,
                  borderRadius: categoryList.isEmpty
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                      : const BorderRadius.all(Radius.zero),
                ),
                child: SwitchListTile(
                  title: Text(_searchSwitchTitle),
                  value: _isOnlyMentor,
                  onChanged: (bool newValue) {
                    _searchSwitchTitle =
                        newValue ? "Sadece Mentor" : "Sadece Guide";
                    setState(() {
                      _isOnlyMentor = newValue;
                    });
                  },
                  secondary: Container(
                    padding: EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.theme1DarkBlue),
                    child: IconTheme(
                      data: const IconThemeData(
                        color: ColorConstants.theme2Orange, // Icon rengi
                      ),
                      child: Icon(
                        _isOnlyMentor ? Icons.diversity_1 : Icons.comment,
                      ),
                    ),
                  ),
                  activeColor: ColorConstants.theme2Orange,
                  // Koyu tema etkinleştirildiğindeki renk
                  activeTrackColor: ColorConstants.theme1DarkBlue,
                  // Koyu tema etkinleştirildiğindeki renk
                  inactiveThumbColor: ColorConstants.theme2Orange,
                  // Koyu tema devre dışı bırakıldığında başlığın rengi
                  inactiveTrackColor: ColorConstants
                      .theme1CloudBlue, // Koyu tema devre dışı bırakıldığında iz sürücü rengi
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: ColorConstants.theme1BrightCloudBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: SizedBox(
                height: categoryList.isNotEmpty ? 40 : 0,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final category = categoryList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.theme1CloudBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          _categorySelectHelper.removeCategory(category);
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(""),
                              Text(
                                category.getName()!,
                                style: GoogleFonts.nunito(
                                  color: ColorConstants.theme1Dark,
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Icon(
                                Icons.clear,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  padding: EdgeInsets.all(0),
                  itemCount: categoryList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Visibility(
              visible: !_isSearch,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Arama Sonuçları',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.theme2Dark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !_isSearch && _isOnlyMentor,
              child: Expanded(
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Aradığınız Mentor bulunamadı.'),
                      );
                    } else {
                      if ((snapshot.data != null && snapshot.data!.isEmpty)) {
                        return const Center(
                          child: Text('Aradığınız Mentor bulunamadı.'),
                        );
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final mentor = snapshot.data![index];
                            return MentorCard(mentor: mentor);
                          },
                          itemCount: snapshot.data!.length,
                          //scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                        );
                      }
                    }
                  },
                  future: MentorService().searchMentorList(
                      _searchController.value.text, categoryList, 0),
                ),
              ),
            ),
            Visibility(
              visible: !_isSearch && !_isOnlyMentor,
              child: Expanded(
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Aradığınız Mentor bulunamadı.'),
                      );
                    } else {
                      if ((snapshot.data != null && snapshot.data!.isEmpty)) {
                        return const Center(
                          child: Text('Aradığınız Post bulunamadı.'),
                        );
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final postCardView = snapshot.data![index];
                            return PostCard(postCardView: postCardView);
                          },
                          itemCount: snapshot.data!.length,
                          padding: const EdgeInsets.all(0),
                        );
                      }
                    }
                  },
                  future: PostService().searchPostCardViewList(
                      _searchController.value.text, categoryList, 0),
                ),
              ),
            ),
            Visibility(
              visible: _isSearch,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'En Sevilen Mentorlar',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.theme2Dark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _isSearch,
              child: Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 200,
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Mentorları şu an listeyemiyoruz.'),
                          );
                        } else {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final mentor = snapshot.data![index];
                              return MentorCard(mentor: mentor);
                            },
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                          );
                        }
                      },
                      future: MentorService().getTopMentorList(5),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isSearch,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "En Sevilen Guide'ler",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.theme2Dark,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        final navigationState = navigationKey.currentState!;
                        navigationState
                            .setPage(NavigationConstants.guidePageIndex);
                      },
                      child: const Text(
                        'Hepsini Gör',
                        style: TextStyle(
                          color: ColorConstants.info,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _isSearch,
              child: Expanded(
                child: FutureBuilder(
                  builder: (context, snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapShot.hasError) {
                      return const Center(
                        child: Text('Veriler alınırken bir hata oluştu.'),
                      );
                    } else {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final postCardView = snapShot.data![index];
                          return PostCard(postCardView: postCardView);
                        },
                        itemCount: snapShot.data!.length,
                        padding: const EdgeInsets.all(0),
                      );
                    }
                  },
                  future: PostService().getMostPopularPostCardViewList(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getDetail() async {
    detail = await SecureStorageHelper().getUserDetail();
  }

  void search() async {
    _mentorList = await MentorService()
        .searchMentorList(_searchController.value.text, categoryList, 0);
    print(_mentorList);
    for (var mentor in _mentorList) {
      print(mentor.getName());
    }
  }
}
