import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HomeDetail extends StatefulWidget {
  const HomeDetail({
    Key? key,
    this.data,
  }) : super(key: key);
  final Map<String, String>? data;

  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(widget.data?['title'] ?? "Untitled",
            style: theme.headlineSmall?.copyWith(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
              height: MediaQuery.of(context).size.width / 2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(widget.data?['path'] ?? ''))),
          const SizedBox(height: 20),
          HtmlWidget(
            widget.data?['description'] ?? "Undescription",
            textStyle: theme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
