import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? title;
  String? subscribeCount;
  String? img;
  final baseUrl = 'https://filipedeschamps.com.br';

  Future<void> scrapData() async {
    final response = await Chaleno().load('$baseUrl/newsletter');

    title = response?.getElementsByClassName('title').first.text;
    subscribeCount = response?.querySelector('.subscribers-count-note').text;
    img = response?.querySelector('.avatar').src;
    setState(() {});
  }

  @override
  void initState() {
    scrapData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 20),
            child: title == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          '$baseUrl/$img',
                          width: 120,
                          height: 120,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '$title',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '$subscribeCount',
                        style: const TextStyle(
                          fontSize: 19,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Inscrever-se',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}