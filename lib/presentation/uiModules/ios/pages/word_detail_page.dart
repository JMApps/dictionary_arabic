import 'package:arabic/core/strings/app_strings.dart';
import 'package:arabic/core/styles/app_styles.dart';
import 'package:arabic/presentation/uiModules/ios/items/word_item.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/repositories/default_dictionary_data_repository.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../../../../domain/usecases/default_dictionary_use_case.dart';
import '../items/word_detail_item.dart';
import '../widgets/error_data_text.dart';

class WordDetailPage extends StatefulWidget {
  const WordDetailPage({
    super.key,
    required this.wordId,
  });

  final int wordId;

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  final DefaultDictionaryUseCase _dictionaryUseCase =
      DefaultDictionaryUseCase(DefaultDictionaryDataRepository());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DictionaryEntity>(
      future: _dictionaryUseCase.fetchWordById(wordId: widget.wordId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Слово'),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.share),
                onPressed: () {},
              ),
            ),
            child: SafeArea(
              right: false,
              left: false,
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WordDetailItem(model: snapshot.data!),
                  const Padding(
                    padding: AppStyles.mainMardingMini,
                    child: Text(
                      AppStrings.cognates,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'SF Pro',
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<DictionaryEntity>>(
                      future: _dictionaryUseCase.fetchWordsByRoot(
                          wordRoot: snapshot.data!.root),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final DictionaryEntity model =
                                  snapshot.data![index];
                              return WordItem(model: model, index: index);
                            },
                          );
                        } else {
                          return const CupertinoActivityIndicator();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return ErrorDataText(errorText: snapshot.error.toString());
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }
}
