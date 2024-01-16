// import 'dart:js';

// import 'package:client/presentation/data_1_update_screen/data_1_update_screen.dart';
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

  void updateList(String value) {
    setState(() {
      searchModels = searchModels
          .where((element) =>
              element.CarID.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => updateList(value),
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Enter car ID",
                  suffixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.black,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
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
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchModels.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    searchModels[index]
                        .CarID, // Use searchModels instead of searchList
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${searchModels[index].CarID}', // Use searchModels instead of searchList
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
    );
  }
}
