import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class Homepage4 extends StatefulWidget {
  const Homepage4({super.key});

  @override
  State<Homepage4> createState() => _Homepage4State();
}

class _Homepage4State extends State<Homepage4> {
  Future getwesitedata() async {
    final url = Uri.parse(
      'https://www.amazon.com/s?k=iphone',
    );
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles =
        html
            .querySelectorAll('a > h2 > span')
            .map((element) => element.innerHtml.trim())
            .toList();

    print("count:${titles.length}");
    for (final title in titles) {
      debugPrint(title);
    }
  }

  @override
  void initState() {
    getwesitedata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
