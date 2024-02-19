class FavoriteDictionaryEntity {
  final String articleId;
  final String translation;
  final String arabic;
  final int id;
  final int wordNumber;
  final String arabicWord;
  final String? form;
  final String? additional;
  final String? vocalization;
  final int? homonymNr;
  final String root;
  final String? forms;
  final int collectionId;
  final int serializableIndex;
  final int ankiCount;

  const FavoriteDictionaryEntity({
    required this.articleId,
    required this.translation,
    required this.arabic,
    required this.id,
    required this.wordNumber,
    required this.arabicWord,
    required this.form,
    required this.additional,
    required this.vocalization,
    required this.homonymNr,
    required this.root,
    required this.forms,
    required this.collectionId,
    required this.serializableIndex,
    required this.ankiCount,
  });

  String wordContent() {
    return '$arabicWord\n\n$form\n\n$vocalization\n\n$root\n\n$forms\n\n$translation';
  }

  bool equals(FavoriteDictionaryEntity other) {
    return translation.trim() == other.translation.trim();
  }
}
