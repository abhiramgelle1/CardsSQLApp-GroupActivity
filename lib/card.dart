class CardModel {
  final int? id;
  final String name;
  final String suit;
  final String imageUrl;
  final int folderId;

  CardModel({
    this.id,
    required this.name,
    required this.suit,
    required this.imageUrl,
    required this.folderId,
  });

  // Convert a CardModel object into a Map object for inserting into SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'suit': suit,
      'imageUrl': imageUrl,
      'folderId': folderId,
    };
  }

  // Create a CardModel from a Map object retrieved from SQLite
  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      name: map['name'],
      suit: map['suit'],
      imageUrl: map['imageUrl'],
      folderId: map['folderId'],
    );
  }
}
