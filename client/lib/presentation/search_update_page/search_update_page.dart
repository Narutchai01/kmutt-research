// import 'dart:js';

// import 'package:client/presentation/data_1_update_screen/data_1_update_screen.dart';
import 'package:client/core/app_export.dart';
import 'package:dio/dio.dart';
// import '../search_update_page/widgets/userlist_item_widget.dart';
// import 'package:client/core/app_export.dart';
// import 'package:client/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:client/presentation/model/search_model.dart';

List<SearchModel> searchModels = []; // Declare searchModels list globally

// ignore_for_file: must_be_immutable
class SearchUpdatePage extends StatefulWidget {
  SearchUpdatePage({Key? key}) : super(key: key);

  @override
  _SearchUpdatePageState createState() => _SearchUpdatePageState();
}

class _SearchUpdatePageState extends State<SearchUpdatePage> {
  TextEditingController searchController = TextEditingController();
  SearchModel _dataFromAPI = SearchModel();
  final dio = Dio();
  var data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    searchModels =
        await getSearchModel(); // Assign the fetched searchModels to the list
    print(searchModels);
    // Now you can use the searchModels list as needed
  }

  Future<List<SearchModel>> getSearchModel() async {
    final response = await dio.get(
      'http://10.0.2.2:8080/api/cars/getCars',
    );

    // Check if response.data is a List<dynamic>
    if (response.data is! List<dynamic>) {
      // Handle the unexpected data format
      throw Exception("Expected List<dynamic>, but got something else.");
    }

    // Convert the JSON array to a List of Maps
    List<Map<String, dynamic>> responseDataList =
        List<Map<String, dynamic>>.from(response.data);

    // Map each item in the list to a SearchModel instance
    List<SearchModel> searchModels =
        responseDataList.map((map) => SearchModel.fromJson(map)).toList();

    return searchModels;
  }

  List<SearchModel> display_list = List.from(searchModels);

  void updateList(String value) {
    setState(() {
      display_list = searchModels
          .where((searchModel) =>
              searchModel.CarID.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Container(
        color: appTheme.blue900, // Add background color here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(top: 30)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) => updateList(value),
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Enter car ID",
                  suffixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Colors.white), // Set the border color to white
                  ),
                  filled: true, // Enable filling the TextField with color
                  fillColor: Colors.white, // Set the fill color to white
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(padding: const EdgeInsets.only(top: 10)),
            Expanded(
              // Add Expanded widget
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Search for a car",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      // Add Expanded widget
                      child: ListView.builder(
                        itemCount: display_list.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            display_list.isNotEmpty
                                ? '${display_list[index].First_name} ${display_list[index].Last_name}' // Use display_list instead of searchList
                                : '',
                            // Use searchModels instead of searchList
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            display_list.isNotEmpty
                                ? '${display_list[index].CarID}' // Use display_list instead of searchList
                                : '', // Show an empty string if display_list is empty
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
