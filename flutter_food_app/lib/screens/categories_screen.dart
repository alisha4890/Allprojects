import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';
class CategoriesScreen extends StatelessWidget {
  @override  //grid :-is for using diff categories/ options side by side  ; builder is used for dynamic amt (unknown no of items)
  Widget build(BuildContext context) {  ///griddelegate is for structuring .layout ;withmaxcrossaxis is class whichs allows to define max width for each grid
    return  GridView(
        padding:  const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES
          .map((catdata) => CategoryItem(catdata.id,catdata.title,catdata.color),
      ).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3/2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
