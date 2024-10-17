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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'suit': suit,
      'imageUrl': imageUrl,
      'folderId': folderId,
    };
  }
}
