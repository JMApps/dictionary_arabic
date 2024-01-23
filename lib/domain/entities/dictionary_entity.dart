class DictionaryEntity {
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

  const DictionaryEntity({
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
}
