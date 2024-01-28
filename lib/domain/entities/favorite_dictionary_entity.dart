class FavoriteDictionaryEntity {
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

  const FavoriteDictionaryEntity({
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

  String wordContent() {
    return 'Слово: $arabicWord\n\n${form != null ? 'Форма: $form\n\n' : ''}${vocalization != null ? 'Вокализация: $vocalization\n\n' : ''}Корень: $root\n\n${forms != null ? 'Множественное число: $forms\n\n' : ''}Перевод:\n$translation';
  }

  bool equals(FavoriteDictionaryEntity other) {
    return translation.trim() == other.translation.trim();
  }
}
