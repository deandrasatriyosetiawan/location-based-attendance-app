import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_based_attendance_app/blocs/attendance_detail/attendance_detail_bloc.dart';
import 'package:location_based_attendance_app/blocs/attendance_histories/attendance_histories_bloc.dart';
import 'package:location_based_attendance_app/blocs/create_attendance/create_attendance_bloc.dart';
import 'package:location_based_attendance_app/blocs/create_user/create_user_bloc.dart';
import 'package:location_based_attendance_app/blocs/user_detail/user_detail_bloc.dart';
import 'package:location_based_attendance_app/core/routes/routes.dart';
import 'package:location_based_attendance_app/cubits/image_picker/image_picker_cubit.dart';
import 'package:location_based_attendance_app/pages/attendance_histories_page.dart';
import 'package:location_based_attendance_app/pages/attendance_page.dart';
import 'package:location_based_attendance_app/pages/login_page.dart';
import 'package:location_based_attendance_app/pages/not_found_page.dart';
import 'package:location_based_attendance_app/pages/register_page.dart';
import 'package:location_based_attendance_app/pages/splash_page.dart';
import 'package:location_based_attendance_app/services/attendance_service.dart';
import 'package:location_based_attendance_app/services/image_picker_service.dart';
import 'package:location_based_attendance_app/services/user_service.dart';
import 'package:location_based_attendance_app/shared/helpers/database_helper.dart';

final class AppRouter {
  AppRouter();

  late final DatabaseHelper _databaseHelper;

  late final ImagePicker _imagePicker;
  late final ImagePickerService _imagePickerService;

  late final UserService _userService;

  late final AttendanceService _attendanceService;

  late final ImagePickerCubit _imagePickerCubit;

  late final CreateUserBloc _createUserBloc;
  late final UserDetailBloc _userDetailBloc;

  late final CreateAttendanceBloc _createAttendanceBloc;
  late final AttendanceDetailBloc _attendanceDetailBloc;
  late final AttendanceHistoriesBloc _attendanceHistoriesBloc;

  void initialize() {
    _databaseHelper = DatabaseHelper();

    _imagePicker = ImagePicker();
    _imagePickerService = ImagePickerService(imagePicker: _imagePicker);

    _userService = UserService();

    _attendanceService = AttendanceService(databaseHelper: _databaseHelper);

    _imagePickerCubit = ImagePickerCubit(imagePickerService: _imagePickerService);

    _createUserBloc = CreateUserBloc(userService: _userService);
    _userDetailBloc = UserDetailBloc(userService: _userService);

    _createAttendanceBloc = CreateAttendanceBloc(attendanceService: _attendanceService);
    _attendanceDetailBloc = AttendanceDetailBloc(attendanceService: _attendanceService);
    _attendanceHistoriesBloc = AttendanceHistoriesBloc(attendanceService: _attendanceService);
  }

  void dispose() {
    _imagePickerCubit.close();
    _createUserBloc.close();
    _userDetailBloc.close();
    _createAttendanceBloc.close();
    _attendanceDetailBloc.close();
    _attendanceHistoriesBloc.close();
  }

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final MaterialPageRoute<NotFoundPage> notFoundPage = MaterialPageRoute<NotFoundPage>(
      settings: routeSettings,
      builder: (_) => const NotFoundPage(),
    );

    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute<SplashPage>(settings: routeSettings, builder: (_) => const SplashPage());

      case Routes.login:
        return MaterialPageRoute<LoginPage>(settings: routeSettings, builder: (_) => const LoginPage());

      case Routes.register:
        return MaterialPageRoute<RegisterPage>(
          settings: routeSettings,
          builder: (_) => MultiBlocProvider(
            providers: [BlocProvider<CreateUserBloc>.value(value: _createUserBloc)],
            child: const RegisterPage(),
          ),
        );

      case Routes.notFound:
        return notFoundPage;

      case Routes.attendance:
        final String? userId = routeSettings.arguments?.toString();
        if (userId == null) {
          return notFoundPage;
        }
        return MaterialPageRoute<AttendancePage>(
          settings: routeSettings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ImagePickerCubit>.value(value: _imagePickerCubit),
              BlocProvider<UserDetailBloc>.value(value: _userDetailBloc),
              BlocProvider<CreateAttendanceBloc>.value(value: _createAttendanceBloc),
              BlocProvider<AttendanceDetailBloc>.value(value: _attendanceDetailBloc),
            ],
            child: AttendancePage(userId: userId),
          ),
        );

      case Routes.attendanceHistories:
        final String? userId = routeSettings.arguments?.toString();
        if (userId == null) {
          return notFoundPage;
        }
        return MaterialPageRoute<AttendanceHistoriesPage>(
          settings: routeSettings,
          builder: (_) => MultiBlocProvider(
            providers: [BlocProvider<AttendanceHistoriesBloc>.value(value: _attendanceHistoriesBloc)],
            child: AttendanceHistoriesPage(userId: userId),
          ),
        );

      default:
        return notFoundPage;
    }
  }
}
