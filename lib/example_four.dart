import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/ComplexJsonModel.dart';

class ExampleFourScreen extends StatefulWidget {
  const ExampleFourScreen({Key? key}) : super(key: key);

  @override
  State<ExampleFourScreen> createState() => _ExampleFourScreenState();
}

class _ExampleFourScreenState extends State<ExampleFourScreen> {
  Future<ComplexJsonModel> complexJsonModelFromApi() async {
    var response = await http.get(Uri.parse("https://webhook.site/8398e4c4-5274-4e44-9137-5ad0360389dd"));
    var jsonData = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ComplexJsonModel.fromJson(jsonData);
    } else {
      return ComplexJsonModel.fromJson(jsonData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Complex API Integration")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: complexJsonModelFromApi(),
                builder: (BuildContext context, AsyncSnapshot<ComplexJsonModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(snapshot.data!.data![index].shop!.name.toString()),
                                subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 1,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.data![index].images!.length,
                                    itemBuilder: (context, position) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.3,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Icon(snapshot.data!.data![index].inWishlist! == false ? Icons.favorite : Icons.favorite_border_outlined)
                            ],
                          );
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
