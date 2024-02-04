import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/cupertino_routes.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../data/state/search_values_state.dart';
import '../../../../data/state/word_exact_match_state.dart';
import 'main_cupertino_page.dart';

class RootCupertinoPage extends StatelessWidget {
  const RootCupertinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WordExactMatchState(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchValuesState(),
        ),
        ChangeNotifierProvider(
          create: (_) => CollectionsState(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteWordsState(),
        ),
      ],
      child: const CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        onGenerateRoute: CupertinoRoutes.onGeneratorRoute,
        home: MainCupertinoPage(),
      ),
    );
  }
}
