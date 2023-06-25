import 'package:flutter/material.dart';
import 'package:guide_up/repository/category/category_repository.dart';
import 'package:guide_up/ui/material/custom_material.dart';

class SearchSidePage extends StatefulWidget {
  const SearchSidePage({Key? key}) : super(key: key);

  @override
  State<SearchSidePage> createState() => _SearchSidePageState();
}

class _SearchSidePageState extends State<SearchSidePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: FutureBuilder(
          builder: (context, projectSnap) {
            if (projectSnap.data == null) {
              print('++++++++++project snapshot data is: ${projectSnap.data}');
              return Container(
                child: Text("Veri YOk"),
              );
            } else {
              print(
                  '--------------project snapshot data is: ${projectSnap.data}');
              return ListView.builder(
                itemBuilder: (context, index) {
                  final subject = projectSnap.data![index];
                  return ListTile(title: Text("${subject.getName()}"));
                },
                itemCount: projectSnap.data!.length,
              );
            }
          },
          future: CategoryRepository().getMainCategoryList(),
        ));
  }
}
