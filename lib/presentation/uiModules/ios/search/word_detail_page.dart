import 'package:flutter/cupertino.dart';
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
    required this.wordNr,
  });

  final int wordNr;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DictionaryEntity>(
      future: Provider.of<DefaultDictionaryState>(context, listen: false).getWordById(wordNr: wordNr),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: const CupertinoNavigationBar(
              middle: Text(AppStrings.word),
              previousPageTitle: AppStrings.close,
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
                          DetailWordItem(model: snapshot.data!),
                          const Padding(
                            padding: AppStyles.mainMardingMini,
                            child: Text(
                              AppStrings.cognates,
                              style: TextStyle(
                                fontSize: 20,
                                color: CupertinoColors.systemBlue,
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
                                    return RootWordItem(model: model, index: index);
                                  },
                                );
                              } else {
                                return const DataText(text: AppStrings.rootIsEmpty);
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
