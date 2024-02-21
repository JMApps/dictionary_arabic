import 'package:arabic/core/styles/material_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/material_routes.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../data/state/app_settings_state.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../data/state/default_dictionary_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../data/state/word_exact_match_state.dart';
import 'main_material_page.dart';

class RootMaterialPage extends StatelessWidget {
  const RootMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppSettingsState(),
        ),
        ChangeNotifierProvider(
          create: (_) => DefaultDictionaryState(),
        ),
        ChangeNotifierProvider(
          create: (_) => WordExactMatchState(),
        ),
        ChangeNotifierProvider(
          create: (_) => CollectionsState(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteWordsState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: MaterialThemes.lightTheme,
        darkTheme: MaterialThemes.darkTheme,
        onGenerateRoute: MaterialRoutes.onGeneratorRoute,
        home: const MainMaterialPage(),
      ),
    );
  }
}
