import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwoScreen extends StatefulWidget {
  const ExampleTwoScreen({Key? key}) : super(key: key);

  @override
  State<ExampleTwoScreen> createState() => _ExampleTwoScreenState();
}

class _ExampleTwoScreenState extends State<ExampleTwoScreen> {
  List<PhotosModel> photosList = [];

  Future<List<PhotosModel>> getPhotosList() async {
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      photosList.clear();
      for (Map i in data) {
        PhotosModel photosModel = PhotosModel(title: i["title"], url: i["url"], id: i["id"]);
        photosList.add(photosModel);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Api Course with complex rest model")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotosList(),
                builder: (context, AsyncSnapshot<List<PhotosModel>> snapshot) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index].url.toString())),
                          subtitle: Text(snapshot.data![index].title.toString()),
                          title: Text("Notes Id: ${snapshot.data![index].id}"),
                        );
                      });
                }),
          ),
        ],
      ),
    ));
  }
}

class PhotosModel {
  String title, url;
  int id;

  PhotosModel({required this.title, required this.url, required this.id});
}
