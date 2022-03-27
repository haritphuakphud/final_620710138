class Item {
  final String image;
  final String answer;
  final List<String> choice;

  Item({
    required this.image,
    required this.answer,
    required this.choice,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      image: json['image'],
      answer: json['answer'],
      choice: List<String>.from(json['choice']),
    );
  }
}

