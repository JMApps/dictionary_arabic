class DictionaryEntity {
  final int id;
  final String arabicWord;
  final String arabicWordWH;
  final String arabicRoot;
  final String? plural;
  final String? meaning;
  final String? shortMeaning;
  final String? other;

  const DictionaryEntity({
    required this.id,
    required this.arabicWord,
    required this.arabicWordWH,
    required this.arabicRoot,
    required this.plural,
    required this.meaning,
    required this.shortMeaning,
    required this.other,
  });
}
