import 'package:flutter/material.dart';
import 'package:guide_up/core/constant/color_constants.dart';
import 'package:guide_up/core/models/category/category_model.dart';
import 'package:guide_up/repository/category/category_repository.dart';

class CategoryCard extends StatefulWidget {
  final int headerCount;
  final Category category;

  const CategoryCard(
      {Key? key, required this.headerCount, required this.category})
      : super(key: key);

  @override
  State<CategoryCard> createState() =>
      _CategoryCardState(headerCount, category);
}

class _CategoryCardState extends State<CategoryCard> {
  _CategoryCardState(int headerCount, Category category) {
    _headerCount = headerCount;
    _category = category;
  }

  List<Category> _subCatlist = [];
  late int _headerCount;
  late Category _category;

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
            if (_subCatlist.isNotEmpty) {
              _subCatlist = [];
              setState(() {});
            } else {
              await CategoryRepository()
                  .getSubCategoryList(_category.getId()!)
                  .then((value) {
                if (value.isNotEmpty) {
                  _subCatlist = value;
                  setState(() {});
                }
              });
            }
          },
        ),
        SizedBox(
          height: _subCatlist.length * 65,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final category = _subCatlist[index];
              return CategoryCard(
                  headerCount: (_headerCount + 1), category: category);
            },
            itemCount: _subCatlist.length,
            padding: const EdgeInsets.all(0),
          ),
        ),
        const Divider(
          height: 0.01,
          color: Colors.black12,
        )
      ]),
    );
  }
}
