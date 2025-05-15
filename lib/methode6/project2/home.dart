import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:web_scrapping_example/methode6/project2/details.dart';

class QuoteScraperPage extends StatefulWidget {
  const QuoteScraperPage({super.key});

  @override
  State<QuoteScraperPage> createState() => _QuoteScraperPageState();
}

class _QuoteScraperPageState extends State<QuoteScraperPage> {
  List<String> quoteTitles = [];
  List<String> quoteauthore = [];
  List<String> quotetags = [];
  List<String> authoreLinks = []; // 🔗 Added

  @override
  void initState() {
    super.initState();
    fetchBookData();
  }

  void fetchBookData() async {
    final url = Uri.parse('https://quotes.toscrape.com/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      final quotes = document.getElementsByClassName('quote');

      final titles =
          quotes
              .map(
                (quote) => quote.getElementsByClassName('text')[0].text.trim(),
              )
              .toList();

      final author =
          quotes
              .map(
                (quote) =>
                    quote.getElementsByClassName('author')[0].text.trim(),
              )
              .toList();
      final tags =
          quotes.map((quote) {
            final tagElements = quote.getElementsByClassName('tag');
            return tagElements.map((tag) => tag.text.trim()).join(', ');
          }).toList();

      final links =
          quotes
              .map(
                (quote) =>
                    'https://quotes.toscrape.com/${quote.querySelector('a')?.attributes['href'] ?? ''}',
              )
              .toList();

      setState(() {
        quoteTitles = titles;
        quoteauthore = author;
        quotetags = tags;
        authoreLinks = links;
      });

      print("Titles found: ${titles.length}");
      print("Prices found: ${author.length}");
      print("tags found: ${tags.length}");
      print("links found: ${authoreLinks.length}");
    } else {
      print("Failed to load website");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quate Details")),
      body: ListView.builder(
        itemCount: quoteTitles.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detailsquote(link: authoreLinks[index]),
                ),
              ); // 👉 Use the bookLinks[index] to navigate
            },

            title: Text(quoteTitles[index]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('by:  ${quoteauthore[index]}'),
                Text('Tags:  ${quotetags[index]}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
