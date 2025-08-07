import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:location_based_attendance_app/core/app.dart';
import 'package:location_based_attendance_app/core/global_bloc_providers.dart';
import 'package:location_based_attendance_app/core/routes/app_router.dart';
import 'package:location_based_attendance_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeDateFormatting('id_ID');

  final GlobalBlocProviders globalBlocProviders = GlobalBlocProviders()..initialize();

  final AppRouter appRouter = AppRouter()..initialize();

  runApp(App(globalBlocProviders: globalBlocProviders, appRouter: appRouter));
}
