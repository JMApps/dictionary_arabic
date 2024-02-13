import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/default_dictionary_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../widgets/error_data_text.dart';
import '../widgets/short_translation_text.dart';

class QuizDetailPage extends StatelessWidget {
  const QuizDetailPage({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(collectionModel.title),
      ),
      child: SafeArea(
        bottom: false,
        child: FutureBuilder<List<FavoriteDictionaryEntity>>(
          future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordsByCollectionId(collectionId: collectionModel.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final FavoriteDictionaryEntity model = snapshot.data![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        model.arabicWord,
                        style: const TextStyle(
                          fontSize: 50,
                          fontFamily: 'Uthmanic',
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: FutureBuilder<List<DictionaryEntity>>(
                          future: Provider.of<DefaultDictionaryState>(context).fetchWordsByQuiz(wordNr: model.nr),
                          builder: (context, quizSnapshot) {
                            if (quizSnapshot.hasData) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: quizSnapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final DictionaryEntity quizModel = quizSnapshot.data![index];
                                  return CupertinoListSection(
                                    children: [
                                      Padding(
                                        padding: AppStyles.mainMardingMini,
                                        child: ShortTranslationText(
                                          translation: quizModel.translation,
                                        ),
                                      ),
                                    ],
                                  );
                                },
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
                    ],
                  );
                },
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
