import 'package:arabic/core/routes/cupertino_routes.dart';
import 'package:arabic/core/strings/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../data/state/collections_state.dart';
import 'main_cupertino_page.dart';

class RootCupertinoPage extends StatefulWidget {
  const RootCupertinoPage({super.key});

  @override
  State<RootCupertinoPage> createState() => _RootCupertinoPageState();
}

class _RootCupertinoPageState extends State<RootCupertinoPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CollectionsState(),
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
