import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String images;

  final String title;
  final String price;
  final String stutus;
  final String rating;
  const Details({
    super.key,
    required this.title,
    required this.images,
    required this.price,
    required this.stutus,
    required this.rating,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.network(widget.images),
          Text(widget.title),
          Text(widget.price),
          Text(widget.stutus),
        ],
      ),
    );
  }
}
