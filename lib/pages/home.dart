import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:january/models/category_model.dart';
import 'package:january/models/Album.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  Future<List<CategoryModel>> _getCategories() async {
    return await CategoryModel.getCategories();
  }

Future<List<Album>> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    //  List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    // return jsonList.map((json) => Album.fromJson(json as Map<String, dynamic>)).toList();

    final List jsonList = jsonDecode(response.body);
    return jsonList.map<Album>((json) => Album.fromJson(json)).toList();

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load albums');
  }
}

  @override
  Widget build(BuildContext context) {
    _getCategories();
   
    return Scaffold(
      //appbar
        appBar: appbar(),
    body: SingleChildScrollView(
      child: Column(children: [
        //searchbox
        searchbox(),
        //space
        SizedBox(height: 20),
        //Categories 
        Categories(),
        //icons
        icons(),
        //space
        SizedBox(height: 20),
        //list
        ListofAblums()
      ],
      ),
    ),
    );
  }

  FutureBuilder<List<Album>> ListofAblums() {
    return FutureBuilder<List<Album>>(
      future: fetchAlbum(), // Assuming you have a method to fetch a list of albums
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          List<Album> albums = snapshot.data!;
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5, // Adjust the height as needed
            child: SingleChildScrollView(
              child: Column(
                children: albums.map((album) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 128, 172, 193).withOpacity(0.3),
                      border: Border.all(color: Color.fromARGB(255, 124, 165, 129)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(album.title),
                        // Add more widgets here to display other album properties
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }
        return const Text('No albums found.');
      },
    );
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