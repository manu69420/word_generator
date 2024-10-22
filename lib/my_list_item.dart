import 'package:flutter/material.dart';
import 'package:word_generator/main.dart';

class MyListItem extends StatelessWidget {
  const MyListItem({
    super.key,
    required this.text,
  });
  final String text;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          const Icon(Icons.favorite),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text),
            ),
          ),
          IconButton(
            onPressed: () {
              favorites.remove(text);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
