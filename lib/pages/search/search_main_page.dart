import 'package:flutter/material.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';
import 'package:guide_up/core/utils/secure_storage_helper.dart';
import 'package:guide_up/pages/search/search_side_page.dart';

import '../../ui/material/custom_material.dart';

class SearchMainPage extends StatefulWidget {
  const SearchMainPage({Key? key}) : super(key: key);

  @override
  State<SearchMainPage> createState() {
    return _SearchMainPageState();
  }
}

class _SearchMainPageState extends State<SearchMainPage> {
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
        title: const Text('Araştırma Zamanı'),
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
          ],
        ),
      ),
    );
  }

  void getDetail() async {
    detail = await SecureStorageHelper().getUserDetail();
  }
}
