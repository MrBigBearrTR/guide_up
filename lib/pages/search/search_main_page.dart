import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/constant/navigation_constants.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/pages/post/post_card.dart';
import 'package:guide_up/pages/search/search_side_page.dart';
import 'package:guide_up/service/post/post_service.dart';

import '../../core/constant/color_constants.dart';
import '../../repository/mentor/mentor_repository.dart';
import '../../ui/material/custom_material.dart';
import '../home/mentor/mentor_card.dart';

class SearchMainPage extends StatefulWidget {
  final GlobalKey<CurvedNavigationBarState> navigationKey;
  const SearchMainPage({Key? key, required this.navigationKey}) : super(key: key);

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


  @override
  void initState() {
    super.initState();
    getDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Araştırma Zamanı',
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
                color: ColorConstants.theme2Dark, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: const Drawer(
        child: SearchSidePage(),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: Column(
          children: [
            Padding(
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
                      onPressed: () => _searchController.clear(),
                    ),
                    // Add a search icon or button to the search bar
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Perform the search here
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
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
            Expanded(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                future: MentorRepository().getTopMentorList(),
              ),
            ),
            Padding(
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
                      final navigationState=navigationKey.currentState!;
                      navigationState.setPage(NavigationConstants.guidePageIndex);
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
            Expanded(
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
          ],
        ),
      ),
    );
  }

  void getDetail() async {
    detail = await SecureStorageHelper().getUserDetail();
  }
}
