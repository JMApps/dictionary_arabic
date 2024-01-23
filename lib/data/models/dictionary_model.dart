class DictionaryModel {
  final String articleId;
  final String translation;
  final String arabic;
  final int id;
  final int nr;
  final String arabicWord;
  final String? form;
  final String? vocalization;
  final String root;
  final String? forms;

  const DictionaryModel({
    required this.articleId,
    required this.translation,
    required this.arabic,
    required this.id,
    required this.nr,
    required this.arabicWord,
    required this.form,
    required this.vocalization,
    required this.root,
    required this.forms,
  });

  factory DictionaryModel.fromMap(Map<String, dynamic> map) {
    return DictionaryModel(
      articleId: map['article_id'] as String,
      translation: map['translation'] as String,
      arabic: map['arabic'] as String,
      id: map['id'] as int,
      nr: map['nr'] as int,
      arabicWord: map['arabic_word'] as String,
      form: map['form'] as String?,
      vocalization: map['vocalization'] as String?,
      root: map['root'] as String,
      forms: map['forms'] as String?,
    );
  }
}
