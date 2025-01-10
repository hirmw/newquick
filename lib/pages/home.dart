import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:january/models/category_model.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  Future<List<CategoryModel>> _getCategories() async {
    return await CategoryModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();
    return Scaffold(
      //appbar
        appBar: appbar(),
        body: Column(children: [
      //searchbox
          searchbox(),
      //space
          SizedBox(height: 205),
      //Categories 
          Categories(),
      //icons
          icons(),
        ]));
  }

  Container icons() {

    return Container(
        height: 150,
         // color: Colors.green,

        child: FutureBuilder<List<CategoryModel>>(
        future: _getCategories(),  // Future that fetches the categories
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();  // Show loading indicator
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData) {
            // Handle your categories data here, for example:
            List<CategoryModel> categories = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) 
              
              {

             return Container(
                width: 100,
                decoration: BoxDecoration(
                  color: categories[index].boxcolor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16)
                ),
                //holds the icon in a container and text as children
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(categories[index].iconPath),
                  ),
                  Text(
                    categories[index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 14
                    ),
                  ),
                  ],
                ),
     );

               // return Text(categories[index].name);
              },
            );
          }
          return const Text('No categories found.');
        },
      ),
    );
  }

  Column Categories() {
    return Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('Category'),
          )
        ]);
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