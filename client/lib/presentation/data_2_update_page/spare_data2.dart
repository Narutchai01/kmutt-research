import 'package:client/presentation/profile_update_container_screen/profile_update_container_screen.dart';
import 'package:dio/dio.dart';
import 'package:client/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:client/presentation/data_2_update_page/widgets/overlay.dart';
import 'package:client/presentation/data_2_update_page/widgets/damage.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:client/presentation/data_2_update_page/widgets/pdf.dart';

// get dataImgURL {
//   String dataImgURL =
//       "https://kmutt-api.onrender.com/api/report/getreport?caseID=fe227580-da12-42b8-9170-c603f25f1ed2";
//   return dataImgURL;
// }
get dataImgURL {
  String dataImgURL =
      "http://localhost:8080/api/report/getreport?caseID=fe227580-da12-42b8-9170-c603f25f1ed2";
  return dataImgURL;
}

get dataTable {
  String dataTable =
      "http://localhost:8080/api/report/getdamagedetail?caseID=fe227580-da12-42b8-9170-c603f25f1ed2";
  return dataTable;
}

List<dynamic> dataImgLink = [];
Map<String, dynamic> dataReport = {};

class CarPart {
  final String name;
  CarPart(this.name);
  @override
  String toString() {
    return '$name';
  }
}

class Data2UpdatePage extends StatefulWidget {
  Data2UpdatePage({Key? key}) : super(key: key);

  @override
  _Data2UpdatePageState createState() => _Data2UpdatePageState();
}

// ignore_for_file: must_be_immutable
class _Data2UpdatePageState extends State<Data2UpdatePage> {
  int imgpreview = 0;
  final dio = Dio();
  bool showDamageOverlay = false;
  bool showCarpartOverlay = false;

  Future getDataIMG() async {
    final response = await dio.get(dataImgURL);
    dataImgLink = response.data['ImageArr'];
    dataReport = response.data['report'];
  }

  Future getTableData() async {
    final table = await dio.get(dataTable);
    print(table.data);
    return table.data;
  }

  List<CarPart> selectedParts = [];
  @override
  Widget build(BuildContext context) {
    getPageroute(AppRoutes.data2UpdatePage);
    getTableData();

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: getDataIMG(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              return Container(
                  width: double.maxFinite,
                  decoration: AppDecoration.fillWhiteA,
                  child: Column(children: [
                    _buildMainSection(context),
                    SizedBox(height: 17.v),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 37.h, right: 51.h),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "PDN :",
                                        style: theme.textTheme.titleLarge,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "POL-001",
                                        style: CustomTextStyles.titleLargeBold,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Claim Info:",
                                        style: theme.textTheme.titleLarge,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "",
                                        style: CustomTextStyles.titleLargeBold,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Status :",
                                        style: theme.textTheme.titleLarge,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "Success",
                                        style: CustomTextStyles.titleLargeBold,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Create on :",
                                        style: theme.textTheme.titleLarge,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "12-10-2023",
                                        style: CustomTextStyles.titleLargeBold,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ]))),
                    SizedBox(height: 26.v),
                    Container(
                      width: 273,
                      height: 190,
                      child: FutureBuilder(
                          future: getDataIMG(),
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
                              final int nPart = dataReport['report'][0][
                                      dataReport['report'][0]
                                          .keys
                                          .toList()[imgpreview]]
                                  ["image_meta_data"]["n_car_parts"];
                              final int nDamage = dataReport['report'][0][
                                      dataReport['report'][0]
                                          .keys
                                          .toList()[imgpreview]]
                                  ["image_meta_data"]["n_car_damages"];
                              final List<dynamic> reportData =
                                  dataReport['report'][0][dataReport['report']
                                              [0]
                                          .keys
                                          .toList()[imgpreview]]
                                      ['car_part_results'];
                              final List<dynamic> reportDamageData =
                                  dataReport['report'][0][dataReport['report']
                                              [0]
                                          .keys
                                          .toList()[imgpreview]]
                                      ['car_damage_results'];
                              final List<dynamic> points = reportData;
                              return Column(
                                children: [
                                  if (showCarpartOverlay)
                                    ImageOverlay(
                                      imageUrl: dataImgLink[imgpreview]
                                          ["Image_link"],
                                      data: points,
                                      nPart: nPart,
                                      selectedParts: selectedParts,
                                    )
                                  else if (showDamageOverlay)
                                    DamageOverlay(
                                      imageUrl: dataImgLink[imgpreview]
                                          ["Image_link"],
                                      data: reportDamageData,
                                      nDamage: nDamage,
                                    )
                                  else
                                    Image.network(
                                      dataImgLink[imgpreview]["Image_link"],
                                    ),
                                ],
                              );
                            }
                          }),
                    ),
                    SizedBox(height: 16.v),
                    _buildListSection(context),
                    SizedBox(height: 16.v),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: showDamageOverlay
                                ? appTheme.whiteA700
                                : appTheme.blue900,
                            backgroundColor: showDamageOverlay
                                ? appTheme.blue900
                                : appTheme.whiteA700,
                            side: BorderSide(color: appTheme.blue900)),
                        onPressed: () {
                          setState(() {
                            showDamageOverlay = !showDamageOverlay;
                            showCarpartOverlay = false;
                          });
                        },
                        child: Text('Damaged'),
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: showCarpartOverlay
                                ? appTheme.whiteA700
                                : appTheme.blue900,
                            backgroundColor: showCarpartOverlay
                                ? appTheme.blue900
                                : appTheme.whiteA700,
                            side: BorderSide(color: appTheme.blue900)),
                        onPressed: () {
                          setState(() {
                            selectedParts.clear();
                            selectedParts.addAll((dataReport['report'][0][
                                        dataReport['report'][0]
                                            .keys
                                            .toList()[imgpreview]]
                                    ['car_part_results'] as List<dynamic>)
                                .map((entry) =>
                                    CarPart(entry['class'] as String)));
                            showDamageOverlay = false;
                            showCarpartOverlay = !showCarpartOverlay;
                          });
                        },
                        child: Text('All Parts'),
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      if (showCarpartOverlay)
                        MultiSelectDialogField<String>(
                          buttonText: Text("Filter"),
                          title: Text("Select Filters"),
                          items: dataReport['report'].isNotEmpty &&
                                  dataReport['report'][0] != null &&
                                  dataReport['report'][0].containsKey(
                                      dataReport['report'][0]
                                          .keys
                                          .toList()[imgpreview])
                              ? (dataReport['report'][0]
                                          [dataReport['report'][0].keys.toList()[imgpreview]]
                                      ['car_part_results'] as List<dynamic>)
                                  .map<String>(
                                      (entry) => entry['class'] as String)
                                  .toSet()
                                  .map((partName) =>
                                      MultiSelectItem<String>(partName, partName))
                                  .toList()
                              : [],
                          listType: MultiSelectListType.CHIP,
                          onConfirm: (values) {
                            setState(() {
                              selectedParts.clear();
                              selectedParts.addAll(
                                  values.map((partName) => CarPart(partName)));
                            });
                          },
                          selectedItemsTextStyle:
                              TextStyle(color: Colors.black),
                          selectedColor: Color(0XFF4DC3FF),
                          chipDisplay: MultiSelectChipDisplay.none(),
                        ),
                    ]),
                    SizedBox(height: 16.v),

                    // SizedBox(height: 16.v),
                    // Spacer(),
                    // SizedBox(height: 27.v),
                    // PDFProvider(
                    //   imageUrl: dataImgLink,
                    //   report: dataReport,
                    // ),
                    // SizedBox(height: 27.v),
                  ]));
            }),
      ),
    );
  }

  /// Section Widget
  Widget _buildMainSection(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 2.v),
        decoration: AppDecoration.fillBlue,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 17.v),
              Padding(
                  padding: EdgeInsets.only(left: 5.h),
                  child: Row(children: [
                    Spacer(),
                  ])),
              SizedBox(height: 10.v),
              Padding(
                  padding: EdgeInsets.only(left: 9.h),
                  child: Text("Result", style: theme.textTheme.displayMedium))
            ]));
  }

  /// Section Widget
  Widget _buildListSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      height: 58.adaptSize,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataImgLink.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                imgpreview = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 8.0), // Adjust as needed
              width: 58.adaptSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.h),
                image: DecorationImage(
                  image: NetworkImage(dataImgLink[index]["Image_link"]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _dataTable(BuildContext context) {
  //   FutureBuilder(
  // future: getTableData(),
  // builder: (context, snapshot) {
  //   if (snapshot.connectionState == ConnectionState.waiting) {
  //     return Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   } else if (snapshot.hasError) {
  //     return Center(
  //       child: Text('Error: ${snapshot.error}'),
  //     );
  //   } else {
  return DataTable(
    columns: const <DataColumn>[
      DataColumn(
        label: Text(
          'Car Part',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Damage Type',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Damage Severity',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    ],
    rows: <DataRow>[
      // for (var entry in snapshot.data)
      DataRow(
        cells: <DataCell>[
          DataCell(
            Text(
              'Damage Type',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataCell(
            Text(
              'Damage Type',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataCell(
            Text(
              'Damage Type',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(
            Text(
              'Damage Type',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataCell(
            Text(
              'Damage Type',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataCell(
            Text(
              'Damage Type',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ],
  );
}
