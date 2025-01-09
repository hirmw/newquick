//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:january/models/category_model.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  List<CategoryModel> categories = [];

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  void initState(){
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();
    return Scaffold(
        appBar: appbar(),
        body: Column(children: [
          searchbox(),
          SizedBox(height: 105),
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Category'),
            )
          ]),
          Container(
            height: 150,
            //color: Colors.green,
            child: ListView.separated(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 25),
              itemBuilder: (context, index) {
                return Container(
                  //height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: categories[index].boxcolor
                  ),
                );
              },
            ),
          ),
        //  const TextField(),
        ]));
  }

  Container searchbox() {
    return Container(
        margin: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(5),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                    'asset/icons/dots-horizontal-svgrepo-com.svg'),
              ),
              suffixIcon: 
              //Row(
              //  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                        'asset/icons/dots-horizontal-svgrepo-com.svg'),
                  ),
              //  ],
             // ),
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(15),
             )),
        ));
  }

  AppBar appbar() {
    return AppBar(
      title: Text("My app"),
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            'asset/icons/arrow-sm-left-svgrepo-com.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 37,
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              'asset/icons/dots-horizontal-svgrepo-com.svg',
              height: 20,
              width: 20,
            ),
          ),
        )
      ],
    );
  }
}