import 'dart:async';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:via_cep/core/injection.dart';
import 'package:via_cep/core/main_app.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    initDependencyInjection();

    runApp(const MainApp());
  }, (error, stack) => log('Error : $error, Stack : $stack'));
}
