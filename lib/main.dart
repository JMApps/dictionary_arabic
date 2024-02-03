import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/strings/app_constraints.dart';
import 'data/services/default_dictionary_service.dart';
import 'presentation/uiModules/android/pages/root_material_page.dart';
import 'presentation/uiModules/ios/main/root_cupertino_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }
  await DefaultDictionaryService().initializeDatabase();
  await Hive.initFlutter();
  await Hive.openBox(AppConstraints.keyMainAppSettingsBox);
  runApp(
    Platform.isIOS ? const RootCupertinoPage() : const RootMaterialPage(),
  );
}
