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
    if (!(await dbHelper.canAddCard(widget.folderId))) {
      _showErrorDialog('This folder can only hold 6 cards.');
      return;
    }

    // Determine the next card number
    List<CardModel> existingCards = await _fetchCards();
    int nextCardNumber = existingCards.length +
        1; // Get the next card number (e.g., 3 if 2 cards exist)

    String suit = widget.folderName;

    // Assign the correct card name and image URL based on the next available number
    CardModel newCard = CardModel(
      name: '$nextCardNumber of $suit', // e.g., "3 of Spades"
      suit: suit,
      imageUrl: _getCardImageUrl(nextCardNumber,
          suit), // Assign the correct image URL for the card number
      folderId: widget.folderId,
    );

    await dbHelper.addCard(newCard.toMap());
    setState(() {
      cards = _fetchCards();
    });
  }

  // Function to get the correct image URL based on the card number and suit
  String _getCardImageUrl(int cardNumber, String suit) {
    // Map the card number to its URL using the suit's first letter
    String suitLetter =
        suit[0]; // Get the first letter of the suit (H, D, S, C)
    return 'https://deckofcardsapi.com/static/img/${cardNumber == 10 ? '0' : cardNumber}$suitLetter.png';
  }

  Future<void> _deleteCard(int cardId) async {
    await dbHelper.deleteCard(cardId);
    setState(() {
      cards = _fetchCards();
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final card = snapshot.data![index];
              return Card(
                elevation: 4,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Image.network(
                          card.imageUrl,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              'https://via.placeholder.com/150', // Placeholder if the image fails to load
                              height: 100,
                            );
                          },
                        ),
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
