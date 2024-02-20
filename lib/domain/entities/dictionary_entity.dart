class DictionaryEntity {
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

  const DictionaryEntity({
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

  String wordContent() {
    return '$arabicWord\n\n${form != null ? '$form\n\n' : ''}${vocalization != null ? '$vocalization\n\n' : ''}$root\n\n${forms != null ? '$forms\n\n' : ''}$translation'.replaceAll('\\n', '\n\n');
  }
}
