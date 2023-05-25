import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ytshorts_api/screen/details.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> kaam = [];
  @override
  Widget build(BuildContext context) {
    fetchShorts();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Shorts"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: kaam.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.75),
              itemBuilder: (context, index) {
                final user = kaam[index];
                final thumb = user['submission']['thumbnail'];
                final media = user['submission']['mediaUrl'];
                return Shorts(
                  thumbnail: thumb,
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(
                              mediaUrl: media,
                            )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      //floatingActionButton: FloatingActionButton(onPressed: fetchShorts),
    );
  }

  void fetchShorts() async {
    //print('start');
    const url = 'https://internship-service.onrender.com/videos?page=3';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      final posts = json['data'];
      kaam = posts.values.elementAt(0);
    });
    // print(kaam.elementAt(0)['submission']['thumbnail']);
  }
}

class Shorts extends StatelessWidget {
  final String? thumbnail;
  final void Function() press;
  const Shorts({super.key, this.thumbnail, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 200,
        width: 200,
        child: Image.network(thumbnail!),
      ),
    );
  }
}
