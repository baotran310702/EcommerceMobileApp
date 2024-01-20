import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:train_flutter/models/category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Category> categories = Category.categories;
  List<int> _extends = [];

  final rnd = Random();

  @override
  void initState() {
    _loadCategory();
    super.initState();
  }

  void _loadCategory() async {
    //API fetch categori here
    final extents = List<int>.generate(
      categories.length,
      (index) => rnd.nextInt(3) + 2,
    );

    setState(() {
      _extends = extents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
        leading: const BackButton(),
      ),
      extendBodyBehindAppBar: true,
      body: MasonryGridView.count(
          padding: const EdgeInsets.only(top: 120, left: 4.0, right: 4.0),
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          itemCount: Category.categories.length,
          itemBuilder: (context, index) {
            final height = _extends[index] * 100;
            return InkWell(
              onTap: () {
                //Navigator to page
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(categories[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                height: height.toDouble(),
              ),
            );
          }),
    );
  }
}
