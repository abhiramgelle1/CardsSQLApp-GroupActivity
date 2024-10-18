import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'card.dart'; // Your card model

class CardScreen extends StatefulWidget {
  final int folderId;
  final String folderName;

  CardScreen({required this.folderId, required this.folderName});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  late DatabaseHelper dbHelper;
  late Future<List<CardModel>> cards;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    cards = _fetchCards();
  }

  Future<List<CardModel>> _fetchCards() async {
    List<Map<String, dynamic>> cardMaps =
        await dbHelper.getCards(widget.folderId);
    return cardMaps.map((cardMap) => CardModel.fromMap(cardMap)).toList();
  }

  Future<void> _addCard() async {
    TextEditingController cardNameController = TextEditingController();

    // Show a dialog to add a new card
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Card'),
          content: TextField(
            controller: cardNameController,
            decoration: InputDecoration(hintText: 'Card Name'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () async {
                String cardName = cardNameController.text;
                if (cardName.isNotEmpty) {
                  CardModel newCard = CardModel(
                    name: cardName,
                    suit: widget.folderName,
                    imageUrl:
                        'https://deckofcardsapi.com/static/img/AH.png', // Example URL
                    folderId: widget.folderId,
                  );
                  await dbHelper.addCard(newCard.toMap());
                  setState(() {
                    cards = _fetchCards();
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateCard(CardModel card) async {
    TextEditingController cardNameController =
        TextEditingController(text: card.name);

    // Show a dialog to update card details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Card'),
          content: TextField(
            controller: cardNameController,
            decoration: InputDecoration(hintText: 'New Card Name'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () async {
                String newCardName = cardNameController.text;
                if (newCardName.isNotEmpty) {
                  card.name = newCardName; // Now you can update the name
                  await dbHelper.updateCard(card.toMap());
                  setState(() {
                    cards = _fetchCards();
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCard(int cardId) async {
    // Show a confirmation dialog before deleting the card
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Card'),
          content: Text('Are you sure you want to delete this card?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                await dbHelper.deleteCard(cardId);
                setState(() {
                  cards = _fetchCards();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.folderName} Cards'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addCard,
          ),
        ],
      ),
      body: FutureBuilder<List<CardModel>>(
        future: cards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading cards'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cards in this folder.'));
          }

          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final card = snapshot.data![index];
              return Card(
                elevation: 4,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Image.network(card.imageUrl,
                            height: 100, fit: BoxFit.cover),
                        Text(card.name),
                        Text(card.suit),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteCard(card.id!),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _updateCard(card),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
