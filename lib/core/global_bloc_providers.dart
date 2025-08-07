import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_based_attendance_app/blocs/authentication/authentication_bloc.dart';
import 'package:location_based_attendance_app/blocs/device_position/device_position_bloc.dart';
import 'package:location_based_attendance_app/cubits/device_location/device_location_cubit.dart';
import 'package:location_based_attendance_app/cubits/location_permission/location_permission_cubit.dart';
import 'package:location_based_attendance_app/services/authentication_service.dart';
import 'package:location_based_attendance_app/services/device_location_service.dart';
import 'package:location_based_attendance_app/services/device_position_service.dart';
import 'package:location_based_attendance_app/services/location_permission_service.dart';
import 'package:location_based_attendance_app/services/user_session_service.dart';
import 'package:provider/single_child_widget.dart';

final class GlobalBlocProviders {
  GlobalBlocProviders();

  late final AuthenticationService _authenticationService;
  late final UserSessionService _userSessionService;

  late final DeviceLocationService _deviceLocationService;
  late final LocationPermissionService _locationPermissionService;
  late final DevicePositionService _devicePositionService;

  late final AuthenticationBloc _authenticationBloc;

  late final DeviceLocationCubit _deviceLocationCubit;
  late final LocationPermissionCubit _locationPermissionCubit;
  late final DevicePositionBloc _devicePositionBloc;

  void initialize() {
    _authenticationService = AuthenticationService();
    _userSessionService = UserSessionService();

    _deviceLocationService = DeviceLocationService();
    _locationPermissionService = LocationPermissionService();
    _devicePositionService = DevicePositionService();

    _authenticationBloc = AuthenticationBloc(
      authenticationService: _authenticationService,
      userSessionService: _userSessionService,
    )..add(ValidateAuthenticationStarted());

    _deviceLocationCubit = DeviceLocationCubit(deviceLocationService: _deviceLocationService);
    _locationPermissionCubit = LocationPermissionCubit(permissionService: _locationPermissionService);
    _devicePositionBloc = DevicePositionBloc(devicePositionService: _devicePositionService);
  }

  void dispose() {
    _authenticationBloc.close();
    _deviceLocationCubit.close();
    _locationPermissionCubit.close();
    _devicePositionBloc.close();
  }

  List<SingleChildWidget> get all {
    return <SingleChildWidget>[
      BlocProvider<AuthenticationBloc>(create: (_) => _authenticationBloc),
      BlocProvider<DeviceLocationCubit>(create: (_) => _deviceLocationCubit),
      BlocProvider<LocationPermissionCubit>(create: (_) => _locationPermissionCubit),
      BlocProvider<DevicePositionBloc>(create: (_) => _devicePositionBloc),
    ];
  }
}
