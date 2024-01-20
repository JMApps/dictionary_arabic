class FavoriteDictionaryModel {
  final int id;
  final String arabicWord;
  final String arabicWordWH;
  final String arabicRoot;
  final String? plural;
  final String? meaning;
  final String? shortMeaning;
  final String? other;
  final int collectionId;

  const FavoriteDictionaryModel({
    required this.id,
    required this.arabicWord,
    required this.arabicWordWH,
    required this.arabicRoot,
    required this.plural,
    required this.meaning,
    required this.shortMeaning,
    required this.other,
    required this.collectionId,
  });

  factory FavoriteDictionaryModel.fromMap(Map<String, dynamic> map) {
    return FavoriteDictionaryModel(
      id: map['id'] as int,
      arabicWord: map['arabic_word'] as String,
      arabicWordWH: map['arabic_word_wh'] as String,
      arabicRoot: map['arabic_root'] as String,
      plural: map['plural'] as String?,
      meaning: map['meaning'] as String?,
      shortMeaning: map['short_meaning'] as String?,
      other: map['other'] as String?,
      collectionId: map['collection_id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'arabic_word': arabicWord,
      'arabic_word_wh': arabicWordWH,
      'arabic_root': arabicRoot,
      'plural': plural,
      'meaning': meaning,
      'short_meaning': shortMeaning,
      'other': other,
      'collection_id': collectionId,
    };
  }
}
