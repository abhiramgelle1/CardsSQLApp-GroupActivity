import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  final int folderId;

  CardScreen(this.folderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cards')),
      body: GridView.builder(
        itemCount: 13,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: Center(child: Text('Card ${index + 1}')),
          );
        },
      ),
    );
  }
}
