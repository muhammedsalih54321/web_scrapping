import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:web_scrapping_example/methode6/project1/details.dart';

class BookScraperPage extends StatefulWidget {
  const BookScraperPage({super.key});

  @override
  State<BookScraperPage> createState() => _BookScraperPageState();
}

class _BookScraperPageState extends State<BookScraperPage> {
  List<String> bookimage = [];
  List<String> bookTitles = [];
  List<String> bookPrices = [];
  List<String> bookrating = [];
  List<String> bookstatus = [];
  List<String> bookLinks = []; // 🔗 Added

  @override
  void initState() {
    super.initState();
    fetchBookData();
  }

  void fetchBookData() async {
    final url = Uri.parse('https://books.toscrape.com/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      final books = document.getElementsByClassName('product_pod');

      final images = books
          .map((b) =>
              'https://books.toscrape.com/${b.getElementsByTagName('img')[0].attributes['src']!.replaceFirst('../', '')}')
          .toList();

      final titles = books
          .map((book) => book.getElementsByTagName('h3')[0].text.trim())
          .toList();

      final status = books
          .map((book) => book
              .getElementsByClassName('instock availability')[0]
              .text
              .trim())
          .toList();

      final rating = books
          .map((book) =>
              book.querySelector('.star-rating')?.classes.last ?? 'No Rating')
          .toList();

      final prices = books
          .map((book) =>
              book.getElementsByClassName('price_color')[0].text.trim())
          .toList();

      final links = books
          .map((book) =>
              'https://books.toscrape.com/${book.querySelector('h3 a')?.attributes['href'] ?? ''}')
          .toList();

      setState(() {
        bookTitles = titles;
        bookPrices = prices;
        bookimage = images;
        bookstatus = status;
        bookrating = rating;
        bookLinks = links;
      });

      print("images found: ${images.length}");
      print("Titles found: ${titles.length}");
      print("Prices found: ${prices.length}");
      print("status found: ${status.length}");
      print("rating found: ${rating.length}");
      print("Links found: ${links.length}");
    } else {
      print("Failed to load website");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Details")),
      body: ListView.builder(
        itemCount: bookTitles.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              // 👉 Use the bookLinks[index] to navigate
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => Details(
                        title: bookTitles[index].toString(),
                        images: bookimage[index].toString(),
                        price: bookPrices[index].toString(),
                        stutus: bookstatus[index].toString(),
                        rating: '',
                      ),
                ),
              );
            },
            leading: Image.network(bookimage[index]),
            title: Text(bookTitles[index]),
            subtitle: Text(bookPrices[index]),
          );
        },
      ),
    );
  }
}
