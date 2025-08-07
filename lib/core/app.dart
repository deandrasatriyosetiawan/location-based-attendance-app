import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_based_attendance_app/core/global_bloc_providers.dart';
import 'package:location_based_attendance_app/core/routes/app_router.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';

class App extends StatefulWidget {
  const App({super.key, required GlobalBlocProviders globalBlocProviders, required AppRouter appRouter})
    : _globalBlocProviders = globalBlocProviders,
      _appRouter = appRouter;

  final GlobalBlocProviders _globalBlocProviders;
  final AppRouter _appRouter;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    widget._globalBlocProviders.dispose();
    widget._appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: widget._globalBlocProviders.all,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(primary: AppColors.primary, seedColor: AppColors.lightBackground),
          scaffoldBackgroundColor: AppColors.lightBackground,
          appBarTheme: AppBarTheme(centerTitle: true),
        ),
        onGenerateRoute: widget._appRouter.generateRoute,
      ),
    );
  }
}
