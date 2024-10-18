import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'cards_screen.dart';

class FolderScreen extends StatefulWidget {
  @override
  _FolderScreenState createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  late DatabaseHelper dbHelper;
  late Future<List<Map<String, dynamic>>> foldersWithCardInfo;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    foldersWithCardInfo = _fetchFoldersWithCardInfo();
  }

  Future<List<Map<String, dynamic>>> _fetchFoldersWithCardInfo() async {
    List<Map<String, dynamic>> folderList = [];

    // Fetch each folder and include card count and first card image
    for (var folder in ['Hearts', 'Diamonds', 'Spades', 'Clubs']) {
      int folderId = await dbHelper.getFolderIdByName(folder);
      int cardCount = await dbHelper.getCardCount(folderId);
      String? previewImage = await dbHelper.getFirstCardImage(folderId);

      folderList.add({
        'folderName': folder,
        'folderId': folderId,
        'cardCount': cardCount,
        'previewImage': previewImage,
      });
    }

    return folderList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Card Folders')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: foldersWithCardInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading folders'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No folders available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var folder = snapshot.data![index];
              return ListTile(
                leading: folder['previewImage'] != null
                    ? Image.network(folder['previewImage']!, height: 50)
                    : Icon(Icons.folder, size: 50),
                title: Text(folder['folderName']),
                subtitle: Text('${folder['cardCount']} cards'),
                onTap: () {
                  // Navigate to the card screen when the folder is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardScreen(
                        folderId: folder['folderId'],
                        folderName: folder['folderName'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: FolderScreen()));
}
