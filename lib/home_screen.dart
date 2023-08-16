import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/PostModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postsList = [];

  Future<List<PostModel>> getPostsApi() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postsList.clear();
      for (Map i in data) {
        postsList.add(PostModel.fromJson(i));
      }
      return postsList;
    } else {
      return postsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("REST Api Course", textAlign: TextAlign.center), backgroundColor: Colors.red),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostsApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: postsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(postsList[index].title.toString(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
                                SizedBox(height: 10),
                                Text("Description:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(postsList[index].body.toString(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
                              ],
                            ),
                          ));
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
