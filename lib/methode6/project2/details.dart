import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class Detailsquote extends StatefulWidget {
  final String link;
  const Detailsquote({super.key, required this.link});

  @override
  State<Detailsquote> createState() => _DetailsquoteState();
}

class _DetailsquoteState extends State<Detailsquote> {
  String name = '';
  String borndate = '';
  String bornplace = '';
  String description = '';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookDetail();
  }

  void fetchBookDetail() async {
    final response = await http.get(Uri.parse(widget.link));
    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);

      setState(() {
        name = document.querySelector('.author-title')?.text ?? 'No name';
        borndate =
            document.querySelector('.author-born-date')?.text ?? 'No born date';
        bornplace =
            document.querySelector('.author-born-location')?.text ??
            'No born place';
        description =
            document.querySelector('.author-description')?.text.trim() ?? 'N/A';

        isLoading = false;
      });
    } else {
      print("Failed to fetch detail page");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Born : $borndate', style: const TextStyle(fontSize: 18)),
                Text(bornplace, style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 8),
            Text("Description", style: TextStyle(fontSize: 20)),
            Text(description),
          ],
        ),
      ),
    ));
  }
}
