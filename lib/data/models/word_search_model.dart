class WordSearchModel {
  final int id;
  final String searchValue;

  const WordSearchModel({
    required this.id,
    required this.searchValue,
  });

  factory WordSearchModel.fromMap(Map<String, dynamic> map) {
    return WordSearchModel(
      id: map['id'] as int,
      searchValue: map['search_value'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'search_value': searchValue
    };
  }
}
