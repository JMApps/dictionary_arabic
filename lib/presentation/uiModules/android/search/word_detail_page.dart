import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/default_dictionary_state.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';
import '../widgets/root_word_item.dart';
import 'items/detail_word_item.dart';

class WordDetailPage extends StatelessWidget {
  const WordDetailPage({
    super.key,
    required this.wordNumber,
  });

  final int wordNumber;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appColors.inversePrimary,
            stretch: true,
            forceElevated: true,
            centerTitle: true,
            floating: true,
            title: const Text(AppStrings.word),
          ),
          FutureBuilder<DictionaryEntity>(
            future: Provider.of<DefaultDictionaryState>(context, listen: false).getWordById(wordNumber: wordNumber),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      DetailWordItem(model: snapshot.data!),
                      Padding(
                        padding: AppStyles.mardingWithoutTopMini,
                        child: Text(
                          AppStrings.cognates,
                          style: TextStyle(
                            fontSize: 20,
                            color: appColors.primary,
                            fontFamily: 'SF Pro',
                            letterSpacing: 0.25,
                          ),
                        ),
                      ),
                      FutureBuilder<List<DictionaryEntity>>(
                        future: Provider.of<DefaultDictionaryState>(context, listen: false).getWordsByRoot(
                          wordRoot: snapshot.data!.root,
                          excludedId: snapshot.data!.wordNumber,
                        ),
                        builder: (context, wordRootsSnapshot) {
                          if (wordRootsSnapshot.hasData && wordRootsSnapshot.data!.isNotEmpty) {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: wordRootsSnapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final DictionaryEntity model = wordRootsSnapshot.data![index];
                                return RootWordItem(
                                  wordModel: model,
                                  index: index,
                                );
                              },
                            );
                          } else {
                            return const DataText(text: AppStrings.rootIsEmpty);
                          }
                        },
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorDataText(errorText: snapshot.error.toString()),
                );
              } else {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
