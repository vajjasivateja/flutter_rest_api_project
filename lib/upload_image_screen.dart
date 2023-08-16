import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickFile != null) {
      image = File(pickFile.path);
      setState(() {});
    } else {
      print("not image found");
    }
  }

  Future<void> upload() async {
    setState(() {
      showSpinner = true;
    });
    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse("https://fakestoreapi.com/products");
    var request = http.MultipartRequest("POST", uri);
    request.fields["title"] = "Title 1";
    var multipart = http.MultipartFile("image", stream, length);
    request.files.add(multipart);
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("image upload successfully");
    } else {
      setState(() {
        showSpinner = false;
      });
      print("image upload failed");
    }
    try {} catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          appBar: AppBar(title: const Text("Upload File to Server")),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    getImage();
                  },
                  child: Container(child: image == null ? const Center(child: Text("Image Picker")) : Container(child: Center(child: Image.file(File(image!.path).absolute, height: 100, width: 100, fit: BoxFit.cover))))),
              const SizedBox(height: 150),
              ElevatedButton(
                  onPressed: () {
                    upload();
                  },
                  child: Text("Upload File")),
            ],
          ),
        ),
      ),
    );
  }
}
