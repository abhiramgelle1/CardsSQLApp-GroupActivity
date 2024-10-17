import 'package:flutter/material.dart';

class FolderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Card Organizer')),
      body: ListView(
        children: [
          ListTile(title: Text('Hearts'), subtitle: Text('3 cards')),
          ListTile(title: Text('Spades'), subtitle: Text('2 cards')),
          ListTile(title: Text('Diamonds'), subtitle: Text('6 cards')),
          ListTile(title: Text('Clubs'), subtitle: Text('5 cards')),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: FolderScreen()));
}
