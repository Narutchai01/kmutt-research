import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImagePreview extends StatefulWidget {
  ImagePreview(this.file, {Key? key}) : super(key: key);
  final XFile file;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  late File picture;

  @override
  void initState() {
    super.initState();
    picture = File(widget.file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Preview")),
      body: Center(
        child: Image.file(picture),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.cancel),
            backgroundColor: Colors.red,
          ),
          SizedBox(width: 50),
          FloatingActionButton(
            onPressed: () {
              saveImage();
            },
            child: Icon(Icons.save),
          ),
        ],
      ),
    );
  }

  Future<void> saveImage() async {
    try {
      final appDir = await getTemporaryDirectory();
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final savedImage = await picture.copy('${appDir.path}/$fileName.png');

      // Save the image to the gallery
      await GallerySaver.saveImage(savedImage.path);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image saved to gallery'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save image'),
        ),
      );
    }
  }
}
