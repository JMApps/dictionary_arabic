class FavoriteDictionaryModel {
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

  const FavoriteDictionaryModel({
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

  factory FavoriteDictionaryModel.fromMap(Map<String, dynamic> map) {
    return FavoriteDictionaryModel(
      articleId: map['article_id'] as String,
      translation: map['translation'] as String,
      arabic: map['arabic'] as String,
      id: map['id'] as int,
      wordNumber: map['word_number'] as int,
      arabicWord: map['arabic_word'] as String,
      form: map['form'] as String?,
      additional: map['additional'] as String?,
      vocalization: map['vocalization'] as String?,
      homonymNr: map['homonym_nr'] as int?,
      root: map['root'] as String,
      forms: map['forms'] as String?,
      collectionId: map['collection_id'] as int,
      serializableIndex: map['serializable_index'] as int,
      ankiCount: map['anki_count'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'article_id': articleId,
      'translation': translation,
      'arabic' : arabic,
      'word_number' : wordNumber,
      'arabic_word' : arabicWord,
      'form' : form,
      'additional': additional,
      'vocalization' : vocalization,
      'homonym_nr': homonymNr,
      'root' : root,
      'forms' : forms,
      'collection_id' : collectionId,
      'serializable_index' : serializableIndex,
      'anki_count' : ankiCount,
    };
  }
}
