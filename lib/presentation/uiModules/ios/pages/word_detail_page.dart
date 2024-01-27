import 'package:arabic/presentation/uiModules/ios/widgets/share_word_button.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/repositories/default_dictionary_data_repository.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../../../../domain/usecases/default_dictionary_use_case.dart';
import '../items/word_detail_item.dart';
import '../items/word_item.dart';
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
  final DefaultDictionaryUseCase _dictionaryUseCase = DefaultDictionaryUseCase(DefaultDictionaryDataRepository());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DictionaryEntity>(
      future: _dictionaryUseCase.fetchWordById(wordId: widget.wordId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: CupertinoNavigationBar(
              middle: Text(
                snapshot.data!.root,
                style: const TextStyle(
                  fontSize: 25,
                  fontFamily: 'Uthmanic',
                ),
              ),
              previousPageTitle: AppStrings.toBack,
              trailing: ShareWordButton(content: snapshot.data!.wordContent()),
            ),
            child: SafeArea(
              bottom: false,
              child: CupertinoScrollbar(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
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
                                color: CupertinoColors.systemBlue,
                                fontFamily: 'SF Pro',
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          FutureBuilder<List<DictionaryEntity>>(
                            future: _dictionaryUseCase.fetchWordsByRoot(wordRoot: snapshot.data!.root),
                            builder: (context, wordRootsSnapshot) {
                              if (wordRootsSnapshot.hasData && wordRootsSnapshot.data!.isNotEmpty) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: wordRootsSnapshot.data!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final DictionaryEntity model = wordRootsSnapshot.data![index];
                                    return WordItem(
                                      model: model,
                                      index: index,
                                    );
                                  },
                                );
                              } else {
                                return const CupertinoActivityIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
