import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../data/state/default_dictionary_state.dart';
import '../../../../domain/entities/args/word_favorite_collection_args.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../widgets/error_data_text.dart';
import 'lists/serializable_words_list.dart';

class AddFavoriteWordPage extends StatelessWidget {
  const AddFavoriteWordPage({
    super.key,
    required this.wordNr,
  });

  final int wordNr;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DictionaryEntity>(
      future: Provider.of<DefaultDictionaryState>(context, listen: false)
          .getWordById(wordNr: wordNr),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: CupertinoNavigationBar(
              middle: Text(
                snapshot.data!.arabicWord,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Uthmanic',
                ),
              ),
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text(AppStrings.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text(AppStrings.addAll),
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
            ),
            child: SafeArea(
              bottom: false,
              child: SerializableWordsList(model: snapshot.data!),
            ),
          );
        } else if (snapshot.hasError) {
          return ErrorDataText(errorText: snapshot.error.toString());
        } else {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
