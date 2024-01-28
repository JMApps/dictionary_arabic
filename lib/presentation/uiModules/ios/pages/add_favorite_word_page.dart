import 'package:arabic/data/state/add_favorite_word_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/repositories/default_dictionary_data_repository.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../../../../domain/usecases/default_dictionary_use_case.dart';
import '../lists/serializable_translation_list.dart';
import '../widgets/error_data_text.dart';

class AddFavoriteWordPage extends StatefulWidget {
  const AddFavoriteWordPage({
    super.key,
    required this.nr,
  });

  final int nr;

  @override
  State<AddFavoriteWordPage> createState() => _AddFavoriteWordPageState();
}

class _AddFavoriteWordPageState extends State<AddFavoriteWordPage> {
  final DefaultDictionaryUseCase _dictionaryUseCase = DefaultDictionaryUseCase(DefaultDictionaryDataRepository());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AddFavoriteWordState(),
        ),
      ],
      child: CupertinoPageScaffold(
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
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.zero,
            child: const Text(AppStrings.add),
          ),
        ),
        child: SafeArea(
          right: false,
          left: false,
          bottom: false,
          child: FutureBuilder<DictionaryEntity>(
            future: _dictionaryUseCase.fetchWordById(wordId: widget.nr),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SerializableTranslationList(
                        model: snapshot.data!,
                      ),
                    ),
                    Padding(
                      padding: AppStyles.mardingWithoutTop,
                      child: CupertinoButton(
                        onPressed: () {},
                        color: CupertinoColors.systemBlue,
                        child: const Text(AppStrings.addAllTranslation),
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                );
              } else if (snapshot.hasError) {
                return ErrorDataText(errorText: snapshot.error.toString());
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
