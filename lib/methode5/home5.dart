import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class Homepage5 extends StatefulWidget {
  const Homepage5({super.key});

  @override
  State<Homepage5> createState() => _Homepage5State();
}

class _Homepage5State extends State<Homepage5> {
  List<String> title = [];
  List<String> post = [];

  @override
  void initState() {
    _getdatafromweb();
    super.initState();
  }

void _getdatafromweb() async {
  final url = Uri.parse('https://arprogramming.blogspot.com/');
  final response = await http.get(url);
  dom.Document document = parser.parse(response.body);
  final elements = document.getElementsByClassName('title entry-title');
  final content = document.getElementsByClassName('article-content entry-content');

  setState(() {
    title = elements
        .map((element) => element.getElementsByTagName("a")[0].innerHtml)
        .toList();
    post = content
        .map((element) => element.getElementsByTagName("p")[0].innerHtml)
        .toList();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Scraps')),
      body:title==0?Text('No Data') :ListView.builder(
        itemCount: title.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title[index],
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    post.length > index ? post[index] : "No content found.",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
