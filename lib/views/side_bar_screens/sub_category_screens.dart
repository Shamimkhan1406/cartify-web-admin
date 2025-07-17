import 'package:flutter/material.dart';

class SubCategoryScreens extends StatefulWidget {
  static const String id = "subCategoryScreen";
  const SubCategoryScreens({super.key});

  @override
  State<SubCategoryScreens> createState() => _SubCategoryScreensState();
}

class _SubCategoryScreensState extends State<SubCategoryScreens> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("subCategoryScreen"));
  }
}