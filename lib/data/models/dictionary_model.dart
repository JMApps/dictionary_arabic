class DictionaryModel {
  final int id;
  final String arabicWord;
  final String arabicWordWH;
  final String arabicRoot;
  final String? plural;
  final String? meaning;
  final String? shortMeaning;
  final String? other;
  const DictionaryModel({
    required this.id,
    required this.arabicWord,
    required this.arabicWordWH,
    required this.arabicRoot,
    required this.plural,
    required this.meaning,
    required this.shortMeaning,
    required this.other,
  });
  factory DictionaryModel.fromMap(Map<String, dynamic> map) {
    return DictionaryModel(
      id: map['id'] as int,
      arabicWord: map['arabic_word'] as String,
      arabicWordWH: map['arabic_word_wh'] as String,
      arabicRoot: map['arabic_root'] as String,
      plural: map['plural'] as String?,
      meaning: map['meaning'] as String?,
      shortMeaning: map['short_meaning'] as String?,
      other: map['other'] as String?,
    );
  }
}
