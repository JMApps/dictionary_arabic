class DictionaryModel {
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

  const DictionaryModel({
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
  });

  factory DictionaryModel.fromMap(Map<String, dynamic> map) {
    return DictionaryModel(
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
    );
  }
}
