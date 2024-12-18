import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/strings/app_constraints.dart';
import 'data/services/default_dictionary_service.dart';
import 'data/services/notifications/local_notice_service.dart';
import 'presentation/uiModules/android/main/root_material_page.dart';
import 'presentation/uiModules/ios/main/root_cupertino_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNoticeService().setupNotification();
  await DefaultDictionaryService().initializeDatabase();

  await Hive.initFlutter();
  await Hive.openBox(AppConstraints.keyMainAppSettingsBox);

  runApp(
    Platform.isAndroid ? const RootMaterialPage() : const RootCupertinoPage(),
  );
}
