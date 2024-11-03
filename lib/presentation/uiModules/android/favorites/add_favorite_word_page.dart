import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/default_dictionary_state.dart';
import '../../../../domain/entities/args/word_favorite_collection_args.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../widgets/error_data_text.dart';
import 'lists/serializable_words_list.dart';

class AddFavoriteWordPage extends StatefulWidget {
  const AddFavoriteWordPage({
    super.key,
    required this.wordNumber,
  });

  final int wordNumber;

  @override
  State<AddFavoriteWordPage> createState() => _AddFavoriteWordPageState();
}

class _AddFavoriteWordPageState extends State<AddFavoriteWordPage> {
  late final Future<DictionaryEntity> _futureDictionary;

  @override
  void initState() {
    super.initState();
    _futureDictionary = Provider.of<DefaultDictionaryState>(context, listen: false).getWordById(wordNumber: widget.wordNumber);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return FutureBuilder<DictionaryEntity>(
      future: _futureDictionary,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: appColors.inversePrimary,
              title: Text(
                snapshot.data!.arabicWord,
                style: const TextStyle(
                  fontSize: 25,
                  fontFamily: 'Uthmanic',
                ),
                textDirection: TextDirection.rtl,
              ),
              actions: [
                MaterialButton(
                  shape: AppStyles.mainShape,
                  splashColor: appColors.tertiaryContainer,
                  child: const Text(
                    AppStrings.addAll,
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.favoriteWordSelectionCollectionPage,
                      arguments: WordFavoriteCollectionArgs(
                        wordModel: snapshot.data!,
                        serializableIndex: -1,
                      ),
                    );
                  },
                ),
              ],
            ),
            body: SerializableWordsList(wordModel: snapshot.data!),
          );
        } else if (snapshot.hasError) {
          return ErrorDataText(errorText: snapshot.error.toString());
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
