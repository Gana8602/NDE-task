import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String img;
  final String title;
  final String description;
  final String keywords;
  final String source;
  const DetailsPage(
      {super.key,
      required this.img,
      required this.title,
      required this.description,
      required this.keywords,
      required this.source});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Details"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                      image: NetworkImage(widget.img), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Description :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.description),
              Text(widget.keywords),
              const SizedBox(
                height: 10,
              ),
              Text(widget.description),
              const Text(
                "Source :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(widget.source),
            ],
          ),
        ),
      ),
    );
  }
}
