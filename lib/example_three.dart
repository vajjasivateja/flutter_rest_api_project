import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/UserModel.dart';

class ExampleThreeScreen extends StatefulWidget {
  const ExampleThreeScreen({Key? key}) : super(key: key);

  @override
  State<ExampleThreeScreen> createState() => _ExampleThreeScreenState();
}

class _ExampleThreeScreenState extends State<ExampleThreeScreen> {
  List<UserModel> usersList = [];

  Future<List<UserModel>> getUsersList() async {
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      usersList.clear();
      for (Map user in data) {
        usersList.add(UserModel.fromJson(user));
      }
      return usersList;
    } else {
      return usersList;
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
              future: getUsersList(),
              builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (snapshot.connectionState== ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {

                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  ReusableRow(title: "Name:", value: snapshot.data![index].name.toString()),
                                  ReusableRow(title: "Username:", value: snapshot.data![index].username.toString()),
                                  ReusableRow(title: "Email:", value: snapshot.data![index].email.toString()),
                                  ReusableRow(title: "City:", value: snapshot.data![index].address!.city.toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class ReusableRow extends StatelessWidget {
  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);
  String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}
