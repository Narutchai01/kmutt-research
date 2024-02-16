// import 'dart:js';

import 'dart:io';

import 'package:client/presentation/data_1_update_screen/data_1_update_screen.dart';
import 'package:client/core/app_export.dart';
import 'package:client/presentation/model/CarID_model.dart';
import 'package:client/presentation/model/customer_model.dart';
import 'package:dio/dio.dart';
// import '../search_update_page/widgets/userlist_item_widget.dart';
// import 'package:client/core/app_export.dart';
// import 'package:client/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:client/presentation/model/search_model.dart';

List<SearchModel> searchModels = []; // Declare searchModels list globally

carCustomerModel carToken = carCustomerModel(
  CarID: '',
  Province: '',
);
get baseURL {
  String baseUrl = "https://kmutt-api.onrender.com";
  return baseUrl;
}

CustomerModel customer = CustomerModel(
  First_name: '',
  Last_name: '',
  CarID: '',
  Customer_image: '',
  Car_Image: '',
  Address: '',
  Model: '',
  Brand: '',
  Policy_number: '',
  Policy_type: '',
  Start_date: '',
  End_date: '',
  Email: '',
  Phone_number: '',
  Line: '',
);

// ignore_for_file: must_be_immutable
class SearchUpdatePage extends StatefulWidget {
  SearchUpdatePage({Key? key}) : super(key: key);

  @override
  _SearchUpdatePageState createState() => _SearchUpdatePageState();
}

class _SearchUpdatePageState extends State<SearchUpdatePage> {
  value() => null;

  String formatInfo(String originalInfo) {
    // Add your formatting logic here
    // For example, you can convert the token to uppercase
    return originalInfo;
  }

  TextEditingController searchController = TextEditingController();

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
      '$baseURL/cars/getCars',
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

  Future<CustomerModel> getCustomer(
      BuildContext context, String carID, String province) async {
    String Car = carID.replaceAll(" ", "%20");
    String Province1 = province.replaceAll(" ", "%20");
    print("Test 1: $Car $Province1");

    var response = await dio.get(
      '$baseURL/cars/getCarByID?CarID=$Car&Province=$Province1',
      options: Options(
        responseType: ResponseType.json,
        validateStatus: (statusCode) {
          if (statusCode == null) {
            return false;
          }
          if (statusCode == 400) {
            // your http status code
            return true;
          } else {
            return statusCode >= 200 && statusCode < 300;
          }
        },
      ),
    );

    customer = CustomerModel.fromMap(response.data[0]);
    return customer;
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
    print(searchController);
    return Scaffold(
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
                controller: searchController,
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
                      height: 10,
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
                      child: FutureBuilder<List<SearchModel>>(
                        // future: Future.delayed(Duration(seconds: 1), () {
                        //   return display_list;
                        // }),
                        future: getSearchModel(),
                        //                 display_list = searchModels.where((searchModel) => searchModel.CarID.toLowerCase().contains(value.toLowerCase())).toList();

                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            List<SearchModel> searchModels = snapshot.data!
                                .where((searchModel) =>
                                    searchModel.CarID.toLowerCase().contains(
                                        searchController.text.toLowerCase()))
                                .toList();

                            return ListView.builder(
                              itemCount: searchModels.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () async {
                                  carToken = carCustomerModel(
                                    CarID:
                                        formatInfo(searchModels[index].CarID),
                                    Province: formatInfo(
                                        searchModels[index].Province),
                                  );

                                  await getCustomer(context, carToken.CarID,
                                      carToken.Province);

                                  print('Test 1.1 : ${customer.CarID}');

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Data1UpdateScreen()),
                                  );
                                },
                                child: ListTile(
                                  leading: CustomImageView(
                                    imagePath: ImageConstant.imgEllipse27,
                                    height: 72.v,
                                    width: 63.h,
                                    radius: BorderRadius.circular(
                                      46.h,
                                    ),
                                  ),
                                  title: Text(
                                    searchModels.isNotEmpty
                                        ? '${searchModels[index].First_name} ${searchModels[index].Last_name}'
                                        : '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        searchModels.isNotEmpty
                                            ? '${searchModels[index].CarID}' +
                                                ' ${searchModels[index].Province}'
                                            : '',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(Icons.arrow_forward),
                                ),
                              ),
                            );
                          }
                        },
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
