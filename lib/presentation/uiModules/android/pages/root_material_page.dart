import 'package:arabic/core/strings/app_strings.dart';
import 'package:flutter/material.dart';

import 'main_material_page.dart';

class RootMaterialPage extends StatelessWidget {
  const RootMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      home: MainMaterialPage(),
    );
  }
}
