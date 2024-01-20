class ChangeFavoriteDictionaryModel {
  final int id;
  final String? meaning;

  const ChangeFavoriteDictionaryModel({
    required this.id,
    required this.meaning,
  });

  Map<String, dynamic> toMap() {
    return {
      'meaning': meaning,
    };
  }
}
