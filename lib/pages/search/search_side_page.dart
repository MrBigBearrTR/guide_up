import 'package:flutter/material.dart';
import 'package:guide_up/ui/material/custom_material.dart';

class SearchSidePage extends StatefulWidget {
  const SearchSidePage({Key? key}) : super(key: key);

  @override
  State<SearchSidePage> createState() => _SearchSidePageState();
}

class _SearchSidePageState extends State<SearchSidePage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(child:
      Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: Text("asdasdasd"),
      ),
    );
  }
}
