import 'package:client/presentation/model/Table_model.dart';
import 'package:client/presentation/profile_update_container_screen/profile_update_container_screen.dart';
import 'package:dio/dio.dart';
import 'package:client/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:client/presentation/data_2_update_page/widgets/overlay.dart';
import 'package:client/presentation/data_2_update_page/widgets/damage.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:client/presentation/data_2_update_page/widgets/pdf.dart';
import 'package:client/presentation/status_update_screen/status_update_screen.dart';

// get dataImgURL {
//   String dataImgURL =
//       "https://kmutt-api.onrender.com/api/report/getreport?caseID=fe227580-da12-42b8-9170-c603f25f1ed2";
//   return dataImgURL;
// }
get dataImgURL {
  String dataImgURL =
      "https://kmutt-api.onrender.com/api/report/getreport?caseID=${caseInfo.CaseID}";
  return dataImgURL;
}

get dataTable {
  String dataTable =
      "https://kmutt-api.onrender.com/api/report/getdamagedetail?caseID=${caseInfo.CaseID}";
  return dataTable;
}

List<dynamic> dataImgLink = [];
Map<String, dynamic> dataReport = {};
List<dynamic> tabledata = [];

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
  late final Future<List<TableModel>> myFuture;

  @override
  void initState() {
    super.initState();
    myFuture = getTableData();
  }

  int imgpreview = 0;
  final dio = Dio();
  bool showDamageOverlay = false;
  bool showCarpartOverlay = false;

  // show all table
  bool showAllTable = true;
  // show filter talbe
  bool showFilterTable = false;

  Future getDataIMG() async {
    var response = await dio.get(dataImgURL);
    dataImgLink = response.data['ImageArr'];
    dataReport = response.data['report'];
    var datatable = await dio.get(dataTable);
    tabledata = datatable.data;
  }

  Future<List<TableModel>> getTableData() async {
    var table = await dio.get(dataTable);

    List<Map<String, dynamic>> responseDataList =
        List<Map<String, dynamic>>.from(table.data);

    // Map each item in the list to a CaseModel instance
    List<TableModel> tableData =
        responseDataList.map((map) => TableModel.fromMap(map)).toList();

    return tableData;
  }

  List<CarPart> selectedParts = [];
  @override
  Widget build(BuildContext context) {
    getPageroute(AppRoutes.data2UpdatePage);
    getTableData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text("Result"),
            backgroundColor: AppDecoration.fillBlue.color),
        body: FutureBuilder(
            future: getDataIMG(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Process is working, please wait...'),
                );
              }
              return Container(
                  width: double.maxFinite,
                  decoration: AppDecoration.fillWhiteA,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      SizedBox(height: 17.v),
                      Container(
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
                                          "Car ID : ",
                                          style: theme.textTheme.titleLarge,
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          caseInfo.CarID +
                                              " " +
                                              caseInfo.Province,
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
                                          caseInfo.Status,
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Date Opened :",
                                          style: theme.textTheme.titleLarge,
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          extractDate(caseInfo.Date_opened),
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Description :",
                                          style: theme.textTheme.titleLarge,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          caseInfo.Description,
                                          style: theme.textTheme.titleLarge,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ]))),
                      SizedBox(height: 26.v),
                      Container(
                        width: 273,
                        height: 180,
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
                                  child: Text(
                                      'Process is working, please wait...'),
                                );
                              } else {
                                final int nPart = dataReport['report'][0][
                                        dataReport['report'][0]
                                            .keys
                                            .toList()[imgpreview]]
                                    ["image_meta_data"]["n_car_parts"];
                                final List<dynamic> imagesize =
                                    dataReport['report']
                                            [0][dataReport['report']
                                                [0]
                                            .keys
                                            .toList()[imgpreview]]
                                        ["image_meta_data"]["orig_shape"];
                                print(imagesize);
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
                                          size: imagesize)
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
                                        width: 273,
                                        height: 180,
                                        fit: BoxFit.fill,
                                      ),
                                  ],
                                );
                              }
                            }),
                      ),
                      SizedBox(height: 16.v),
                      _buildListSection(context),
                      SizedBox(height: 16.v),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                  showFilterTable = true;
                                  showAllTable = false;
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
                                  showAllTable = true;
                                  showFilterTable = false;
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
                                    ? (dataReport['report'][0][
                                                    dataReport['report'][0]
                                                        .keys
                                                        .toList()[imgpreview]]
                                                ['car_part_results']
                                            as List<dynamic>)
                                        .map<String>((entry) => entry['class'] as String)
                                        .toSet()
                                        .map((partName) => MultiSelectItem<String>(partName, partName))
                                        .toList()
                                    : [],
                                listType: MultiSelectListType.CHIP,
                                onConfirm: (values) {
                                  setState(() {
                                    selectedParts.clear();
                                    selectedParts.addAll(values
                                        .map((partName) => CarPart(partName)));
                                  });
                                },
                                selectedItemsTextStyle:
                                    TextStyle(color: Colors.black),
                                selectedColor: Color(0XFF4DC3FF),
                                chipDisplay: MultiSelectChipDisplay.none(),
                              ),
                          ]),
                      SizedBox(height: 16.v),
                      PDFProvider(
                        imageUrl: dataImgLink,
                        report: dataReport,
                        datatable: tabledata,
                      ),
                      SizedBox(height: 16.v),
                      _TableColumn(context),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.h),
                        child: FutureBuilder<List<TableModel>>(
                            future: getTableData(),
                            builder: (context,
                                AsyncSnapshot<List<TableModel>?> snapshot) {
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
                                List<TableModel> SnapData = snapshot.data!;

                                if (showAllTable) {
                                  List<TableModel> tableData = SnapData;
                                  return Column(
                                    children: tableData.map((tableData) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 16.v),
                                        child: _dataTable(
                                          context,
                                          snapshot.data!.toList(),
                                          snapshot.data!.indexOf(tableData),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                } else if (showFilterTable) {
                                  List<TableModel> tableData = SnapData;
                                  Iterable<TableModel> FilterData = tableData
                                      .where((tableData) =>
                                          (tableData.Damage_type != "None" ||
                                              tableData.Damage_severity !=
                                                  "None"))
                                      .toList();
                                  return Column(
                                    children: FilterData.map((tableData) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 16.v),
                                        child: _dataTable(
                                          context,
                                          snapshot.data!.toList(),
                                          snapshot.data!.indexOf(tableData),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                } else {
                                  return Container();
                                }
                              }
                            }),
                      ),
                    ]),
                  ));
            }),
      ),
    );
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

Widget _TableColumn(BuildContext context) {
  return Container(
    height: 68.v,
    padding: EdgeInsets.symmetric(horizontal: 40.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 90.h,
          child: Text(
            "Car Part",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          width: 85.h,
          child: Text(
            "Damage Type",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          width: 70.h,
          child: Text(
            "Damage Severity",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _dataTable(BuildContext context, List<TableModel> tableData, int n) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 3.v),
    decoration: BoxDecoration(
      border: Border(
          bottom: BorderSide(
              color: Color.fromARGB(255, 201, 201, 201), width: 1.5)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 90.h, // Replace 100 with your desired width
          child: Text(
            tableData.isNotEmpty ? tableData[n].Car_part : 'No data',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          width: 85.h, // Replace 100 with your desired width
          child: Text(
            tableData.isNotEmpty ? tableData[n].Damage_type : 'No data',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          width: 70.h, // Replace 100 with your desired width
          child: Text(
            tableData.isNotEmpty ? tableData[n].Damage_severity : 'No data',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
      ],
    ),
  );
}

String extractDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}
