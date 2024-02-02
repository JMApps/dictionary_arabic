import 'package:flutter/cupertino.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../data/repositories/default_dictionary_data_repository.dart';
import '../../../../domain/entities/args/word_favorite_collection_args.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../../../../domain/usecases/default_dictionary_use_case.dart';
import '../lists/serializable_translation_list.dart';
import '../widgets/error_data_text.dart';

class AddFavoriteWordPage extends StatefulWidget {
  const AddFavoriteWordPage({
    super.key,
    required this.wordId,
  });

  final int wordId;

  @override
  State<AddFavoriteWordPage> createState() => _AddFavoriteWordPageState();
}

class _AddFavoriteWordPageState extends State<AddFavoriteWordPage> {
  final DefaultDictionaryUseCase _dictionaryUseCase =
      DefaultDictionaryUseCase(DefaultDictionaryDataRepository());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DictionaryEntity>(
      future: _dictionaryUseCase.fetchWordById(wordId: widget.wordId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: CupertinoNavigationBar(
              middle: const Text(AppStrings.addToCollection),
              leading: CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                padding: EdgeInsets.zero,
                child: const Text(AppStrings.cancel),
              ),
              trailing: CupertinoButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.wordFavoriteCollectionPage,
                    arguments: WordFavoriteCollectionArgs(
                      wordModel: snapshot.data!,
                      serializableIndex: -1,
                    ),
                  );
                },
                padding: EdgeInsets.zero,
                child: const Text(AppStrings.add),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: SerializableTranslationList(model: snapshot.data!),
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
