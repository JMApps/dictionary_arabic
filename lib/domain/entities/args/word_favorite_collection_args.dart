
import '../dictionary_entity.dart';

class WordFavoriteCollectionArgs {
  final DictionaryEntity wordModel;
  final int serializableIndex;

  WordFavoriteCollectionArgs({
    required this.wordModel,
    required this.serializableIndex,
  });
}
