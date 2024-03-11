class CollectionModel {
  final int id;
  final String title;
  final int wordsCount;
  final int color;

  const CollectionModel({
    required this.id,
    required this.title,
    required this.wordsCount,
    required this.color,
  });

  factory CollectionModel.fromMap(Map<String, dynamic> map) {
    return CollectionModel(
      id: map['id'] as int,
      title: map['title'] as String,
      wordsCount: map['words_count'] as int,
      color: map['color'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'color': color,
    };
  }
}
