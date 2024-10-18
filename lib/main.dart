import 'package:flutter/material.dart';
import 'cards_screen.dart'; // Import the CardScreen

class FolderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Card Organizer')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Hearts'),
            subtitle: Text('View cards in Hearts folder'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CardScreen(folderId: 1, folderName: 'Hearts'),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Diamonds'),
            subtitle: Text('View cards in Diamonds folder'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CardScreen(folderId: 2, folderName: 'Diamonds'),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Spades'),
            subtitle: Text('View cards in Spades folder'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CardScreen(folderId: 3, folderName: 'Spades'),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Clubs'),
            subtitle: Text('View cards in Clubs folder'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CardScreen(folderId: 4, folderName: 'Clubs'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: FolderScreen()));
}
