import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../data/state/constructor_mode_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../widgets/flip_translation_text.dart';

class WordConstructorDetailPage extends StatefulWidget {
  const WordConstructorDetailPage({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  State<WordConstructorDetailPage> createState() => _WordConstructorDetailPageState();
}

class _WordConstructorDetailPageState extends State<WordConstructorDetailPage> {
  final PageController _constructorController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConstructorModeState(),
        ),
      ],
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.collectionModel.title),
          previousPageTitle: AppStrings.toBack,
        ),
        child: FutureBuilder(
          future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordsByCollectionId(
            collectionId: widget.collectionModel.id,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _constructorController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final FavoriteDictionaryEntity wordModel = snapshot.data![index];
                          final List<String> translationLines = wordModel.translation.split('\\n');
                          return Consumer<ConstructorModeState>(
                            builder: (BuildContext context, constructorState, _) {
                              return Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      wordModel.serializableIndex != -1
                                          ? FlipTranslationText(translation: translationLines[wordModel.serializableIndex])
                                          : FlipTranslationText(translation: wordModel.translation),
                                      const SizedBox(height: 28),
                                      Text(
                                        constructorState.getInputWord,
                                        style: const TextStyle(
                                          fontSize: 50,
                                          fontFamily: 'Uthmanic',
                                        ),
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Wrap(
                                        spacing: 7,
                                        alignment: WrapAlignment.center,
                                        runAlignment: WrapAlignment.center,
                                        children: wordModel.arabicWord.split('').map((letter) {
                                          return CupertinoButton(
                                            onPressed: constructorState.getInputWord.length < wordModel.arabicWord.length
                                                ? () => constructorState.setInputLetters = letter : null,
                                            child: Text(
                                              letter,
                                              style: const TextStyle(
                                                fontSize: 40,
                                                fontFamily: 'Uthmanic',
                                              ),
                                              textDirection: TextDirection.rtl,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      const SizedBox(height: 14),
                                      CupertinoButton(
                                        onPressed: constructorState.getInputWord.length < wordModel.arabicWord.length
                                            ? () {
                                          constructorState.removeLastLetter();
                                        } : null,
                                        child: const Icon(
                                          CupertinoIcons.delete_right,
                                          color: CupertinoColors.systemRed,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
