import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/models/category/category_model.dart';
import 'package:guide_up/pages/search/category/list_size_control.dart';
import 'package:guide_up/repository/category/category_repository.dart';

class CategoryCard extends StatefulWidget {
  final int headerCount;
  final Category category;
  final ListSizeControl mainListSizeControl;

  const CategoryCard(
      {Key? key,
      required this.headerCount,
      required this.category,
      required this.mainListSizeControl})
      : super(key: key);

  @override
  State<CategoryCard> createState() =>
      _CategoryCardState(headerCount, category, mainListSizeControl);
}

class _CategoryCardState extends State<CategoryCard> {
  _CategoryCardState(
      int headerCount, Category category, ListSizeControl mainListSizeControl) {
    _headerCount = headerCount;
    _category = category;
    _mainListSizeControl = mainListSizeControl;
  }

  List<Category> _subCategoryList = [];
  late int _headerCount;
  late Category _category;
  late ListSizeControl listSizeControl;
  late ListSizeControl _mainListSizeControl;

  @override
  void initState() {
    super.initState();
    listSizeControl = ListSizeControl();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.calculateSlideItemColor(_headerCount),
      child: Column(children: [
        ListTile(
          title: Text(
            _category.getName()!,
          ),
          onTap: () async {
            if (_subCategoryList.isNotEmpty) {
              _subCategoryList = [];
              _mainListSizeControl.removeLastSize();
              listSizeControl.setListSize(0);
              setState(() {});
            } else {
              await CategoryRepository()
                  .getSubCategoryList(_category.getId()!)
                  .then((value) {
                if (value.isNotEmpty) {
                  listSizeControl.setListSize(value.length);
                  _mainListSizeControl.addListSize(value.length);
                  _subCategoryList = value;
                  setState(() {});
                }
              });
            }
          },
        ),
        ListenableBuilder(
          listenable: listSizeControl,
          builder: (BuildContext context, Widget? child) {
            return SizedBox(
              height: listSizeControl.getListSize() * 60,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final category = _subCategoryList[index];

                  return CategoryCard(
                    headerCount: (_headerCount + 1),
                    category: category,
                    mainListSizeControl: listSizeControl,
                  );
                },
                itemCount: _subCategoryList.length,
                padding: const EdgeInsets.all(0),
              ),
            );
          },
        ),
        const Divider(
          height: 0.01,
          color: Colors.black12,
        )
      ]),
    );
  }

}
