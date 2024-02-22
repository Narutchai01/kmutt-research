import 'dart:io';
import 'package:client/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:client/presentation/login_screen/login_screen.dart';

class ImagePickerConfirm extends StatefulWidget {
  const ImagePickerConfirm(this.selectedImages, {Key? key}) : super(key: key);

  final List<XFile> selectedImages;

  @override
  State<ImagePickerConfirm> createState() => _ImagePickerConfirmState();
}

class _ImagePickerConfirmState extends State<ImagePickerConfirm> {
  TextEditingController descriptionController = TextEditingController();

  void submit() async {
    FormData formData = FormData.fromMap({
      'Description': descriptionController,
      'Province': 'ชลบุรี',
      'CarID': 'กอ 9112',
    });
    for (var file in widget.selectedImages) {
      formData.files.add(MapEntry(
        'file',
        await MultipartFile.fromFile(file.path),
      ));
    }
    Response response;
    try {
      response = await Dio().post(
        'https://kmutt-api.onrender.com/api/cases/createCase/${GlobalModel.token}',
        data: formData,
      );
      if (response.statusCode == 200) {
        print('success');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(GlobalModel.token);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.blue900,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Selected',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: widget.selectedImages.length,
              itemBuilder: (context, index) {
                return Image.file(File(widget.selectedImages[index].path));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter your description...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  submit();
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    text: "Add picture success!",
                  );
                  print('Confirmation Button Pressed!');
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appTheme.blue900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 30.0), // Adjust size here
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
