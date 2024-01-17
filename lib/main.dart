import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'presentation/uiModules/android/pages/root_material_page.dart';
import 'presentation/uiModules/ios/pages/root_cupertino_page.dart';

void main() {
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
  runApp(
    Platform.isIOS ? const RootCupertinoPage() : const RootMaterialPage(),
  );
}
