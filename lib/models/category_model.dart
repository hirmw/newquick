import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxcolor;

  CategoryModel({

    required this.name,
    required this.iconPath,
    required this.boxcolor,

  });

  static List<CategoryModel> getCategories(){

    List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
      name: 'Salad',
      iconPath: 'asset/icons/plate.svg',
      boxcolor: Colors.blue)
    );

    categories.add(
      CategoryModel(
      name: 'Cake',
      iconPath: 'asset/icons/cake.svg',
      boxcolor: Colors.yellow)
    );

    categories.add(
      CategoryModel(
      name: 'Pie',
      iconPath: 'asset/icons/pie.svg',
      boxcolor: Colors.red)
    );

    return categories;
  }
  
}