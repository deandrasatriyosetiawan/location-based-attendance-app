import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_based_attendance_app/blocs/attendance_detail/attendance_detail_bloc.dart';
import 'package:location_based_attendance_app/blocs/authentication/authentication_bloc.dart';
import 'package:location_based_attendance_app/blocs/create_attendance/create_attendance_bloc.dart';
import 'package:location_based_attendance_app/blocs/device_position/device_position_bloc.dart';
import 'package:location_based_attendance_app/blocs/user_detail/user_detail_bloc.dart';
import 'package:location_based_attendance_app/core/routes/routes.dart';
import 'package:location_based_attendance_app/cubits/device_location/device_location_cubit.dart';
import 'package:location_based_attendance_app/cubits/image_picker/image_picker_cubit.dart';
import 'package:location_based_attendance_app/cubits/location_permission/location_permission_cubit.dart';
import 'package:location_based_attendance_app/requests/create_attendance_request.dart';
import 'package:location_based_attendance_app/shared/extensions/navigator_extension.dart';
import 'package:location_based_attendance_app/shared/extensions/snack_bar_extension.dart';
import 'package:location_based_attendance_app/shared/extensions/widget_gap_extension.dart';
import 'package:location_based_attendance_app/shared/helpers/date_time_formatter.dart';
import 'package:location_based_attendance_app/shared/helpers/distance_counter.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';
import 'package:location_based_attendance_app/shared/styles/font_sizes.dart';
import 'package:location_based_attendance_app/shared/styles/font_weights.dart';
import 'package:location_based_attendance_app/shared/widgets/custom_elevated_button.dart';
import 'package:location_based_attendance_app/shared/widgets/image_picker_tile.dart';
import 'package:location_based_attendance_app/shared/widgets/loading_indicator.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key, required this.userId});

  final String userId;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late final AuthenticationBloc _authenticationBloc;
  late final DeviceLocationCubit _deviceLocationCubit;
  late final LocationPermissionCubit _locationPermissionCubit;
  late final DevicePositionBloc _devicePositionBloc;
  late final ImagePickerCubit _imagePickerCubit;
  late final UserDetailBloc _userDetailBloc;
  late final CreateAttendanceBloc _createAttendanceBloc;
  late final AttendanceDetailBloc _attendanceDetailBloc;

  DeviceLocationState _deviceLocationState = DeviceLocationState.loading;
  LocationPermissionState _locationPermissionState = LocationPermissionState.loading;

  @override
  void initState() {
    super.initState();

    _authenticationBloc = context.read<AuthenticationBloc>();
    _deviceLocationCubit = context.read<DeviceLocationCubit>();
    _locationPermissionCubit = context.read<LocationPermissionCubit>();
    _devicePositionBloc = context.read<DevicePositionBloc>();
    _imagePickerCubit = context.read<ImagePickerCubit>();
    _userDetailBloc = context.read<UserDetailBloc>();
    _createAttendanceBloc = context.read<CreateAttendanceBloc>();
    _attendanceDetailBloc = context.read<AttendanceDetailBloc>();

    _deviceLocationCubit.checkSettings();
    _locationPermissionCubit.checkPermission();
    _userDetailBloc.add(UserDetailRequested(userId: widget.userId));
    _attendanceDetailBloc.add(LatestAttendanceRequested(userId: widget.userId));
    _imagePickerCubit.clear();
  }

  void _refreshLocation() {
    final bool isLocationDisabled = _deviceLocationState == DeviceLocationState.disabled;
    final bool isPermissionDisabled = _locationPermissionState == LocationPermissionState.disabled;

    if (isLocationDisabled) {
      context.showFloatingErrorSnackBar(message: 'Mohon aktifkan layanan lokasi di perangkat Anda.');

      Timer(const Duration(seconds: 1), () => _deviceLocationCubit.goToSettings());
    } else if (isPermissionDisabled) {
      context.showFloatingErrorSnackBar(message: 'Mohon izinkan aplikasi untuk mengakses lokasi perangkat Anda.');

      Timer(const Duration(seconds: 1), () => _locationPermissionCubit.requestPermission());
    }

    if (isLocationDisabled || isPermissionDisabled) {
      _devicePositionBloc.add(ClearCurrentPositionStarted());

      return;
    }

    _devicePositionBloc.add(GetCurrentPositionStarted());
  }

  void _presence({required String imagePath, required double deviceLatitude, required double deviceLongitude}) {
    _createAttendanceBloc.add(
      CreateAttendanceRequested(
        CreateAttendanceRequest(
          userId: widget.userId,
          status: 'Sudah presensi',
          imagePath: imagePath,
          createdAt: DateTime.now(),
          distanceFromOfficeInMeters: DistanceCounter.countDistance(
            deviceLatitude: deviceLatitude,
            deviceLongitude: deviceLongitude,
          ),
        ),
      ),
    );
  }

  void _logout() => _authenticationBloc.add(LogoutStarted());

  void _handleAuthenticationState(BuildContext context, AuthenticationState state) {
    if (state is LogoutSuccess) {
      context.pushNamedAndRemoveUntil(pageRoute: Routes.login);
      context.showFloatingSuccessSnackBar(message: state.message);
    } else if (state is LogoutFailure) {
      context.read<AuthenticationBloc>().add(ValidateAuthenticationStarted());
      context.showFloatingErrorSnackBar(message: state.message);
    }
  }

  void _handleDeviceLocationState(BuildContext context, DeviceLocationState state) {
    _deviceLocationState = state;
  }

  void _handleLocationPermissionState(BuildContext context, LocationPermissionState state) {
    _locationPermissionState = state;
  }

  void _handleCreateAttendanceState(BuildContext context, CreateAttendanceState state) {
    if (state is CreateAttendanceSuccess) {
      _attendanceDetailBloc.add(LatestAttendanceRequested(userId: widget.userId));
      _imagePickerCubit.clear();
      context.showFloatingSuccessSnackBar(message: state.message);
    } else if (state is CreateAttendanceFailure) {
      context.showFloatingErrorSnackBar(message: state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presensi Anda'),
        actions: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: _handleAuthenticationState,
            child: IconButton(
              onPressed: _logout,
              icon: Tooltip(message: 'Log out', child: Icon(Icons.logout)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            BlocBuilder<UserDetailBloc, UserDetailState>(
              builder: (context, state) {
                if (state is UserDetailLoadFailure) {
                  return Text(
                    state.message,
                    style: TextStyle(
                      color: AppColors.statusError,
                      fontSize: FontSizes.standard,
                      fontWeight: FontWeights.regular,
                    ),
                  );
                } else if (state is UserDetailLoadSuccess) {
                  return Text(
                    'Nama pengguna:\n${state.user.name}',
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontSize: FontSizes.standard,
                      fontWeight: FontWeights.regular,
                    ),
                  );
                } else if (state is UserDetailLoadInProgress) {
                  return LoadingIndicator();
                }
                return SizedBox();
              },
            ),
            16.gapHeight,
            Text(
              'Tanggal dan waktu saat ini:\n${DateTimeFormatter.formatDateTimeWithMonthName(DateTime.now())}',
              style: TextStyle(
                color: AppColors.darkGray,
                fontSize: FontSizes.standard,
                fontWeight: FontWeights.regular,
              ),
            ),
            16.gapHeight,
            BlocBuilder<DevicePositionBloc, DevicePositionState>(
              builder: (context, state) {
                if (state is DevicePositionLoadFailure) {
                  return Text(
                    state.message,
                    style: TextStyle(
                      color: AppColors.statusError,
                      fontSize: FontSizes.standard,
                      fontWeight: FontWeights.regular,
                    ),
                  );
                } else if (state is DevicePositionInitial) {
                  return Text(
                    'Lokasi pengguna (koordinat):\nRefresh lokasi Anda terlebih dahulu',
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontSize: FontSizes.standard,
                      fontWeight: FontWeights.regular,
                    ),
                  );
                } else if (state is DevicePositionLoading) {
                  return LoadingIndicator();
                } else if (state is DevicePositionLoadSuccess) {
                  return Text(
                    'Lokasi pengguna (koordinat):\n${state.position.latitude}, ${state.position.longitude}',
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontSize: FontSizes.standard,
                      fontWeight: FontWeights.regular,
                    ),
                  );
                }
                return SizedBox();
              },
            ),
            16.gapHeight,
            BlocBuilder<AttendanceDetailBloc, AttendanceDetailState>(
              builder: (context, state) {
                if (state is AttendanceDetailLoadFailure) {
                  return Text(
                    state.message,
                    style: TextStyle(
                      color: AppColors.statusError,
                      fontSize: FontSizes.standard,
                      fontWeight: FontWeights.regular,
                    ),
                  );
                } else if (state is AttendanceDetailLoadInProgress) {
                  return LoadingIndicator();
                } else if (state is AttendanceDetailLoadSuccess) {
                  final bool isPresentToday = state.attendance.isPresentToday;
                  final String status = isPresentToday ? state.attendance.status! : 'Belum presensi';

                  return Text(
                    'Status presensi hari ini:\n$status',
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontSize: FontSizes.standard,
                      fontWeight: FontWeights.regular,
                    ),
                  );
                }
                return SizedBox();
              },
            ),
            32.gapHeight,
            ImagePickerTile(),
            32.gapHeight,
            MultiBlocListener(
              listeners: [
                BlocListener<DeviceLocationCubit, DeviceLocationState>(listener: _handleDeviceLocationState),
                BlocListener<LocationPermissionCubit, LocationPermissionState>(
                  listener: _handleLocationPermissionState,
                ),
              ],
              child: CustomElevatedButton.secondary(
                onPressed: () {
                  _deviceLocationCubit.checkSettings();
                  _locationPermissionCubit.checkPermission();
                  Timer(const Duration(seconds: 1), () => _refreshLocation());
                },
                title: 'Refresh Lokasi Anda',
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
            32.gapHeight,
            BlocBuilder<ImagePickerCubit, ImagePickerState>(
              builder: (context, imagePickerState) {
                return BlocBuilder<DevicePositionBloc, DevicePositionState>(
                  builder: (context, devicePositionState) {
                    if (devicePositionState is DevicePositionLoadFailure) {
                      return Text(
                        'Anda tidak dapat presensi karena koordinat Anda tidak ditemukan.',
                        style: TextStyle(
                          color: AppColors.statusError,
                          fontSize: FontSizes.standard,
                          fontWeight: FontWeights.regular,
                        ),
                        textAlign: TextAlign.center,
                      );
                    } else if (devicePositionState is DevicePositionLoadSuccess) {
                      return BlocConsumer<CreateAttendanceBloc, CreateAttendanceState>(
                        listener: _handleCreateAttendanceState,
                        builder: (context, createAttendanceState) {
                          if (createAttendanceState is CreateAttendanceInProgress) {
                            return LoadingIndicator();
                          }

                          return BlocBuilder<AttendanceDetailBloc, AttendanceDetailState>(
                            builder: (context, attendanceDetailState) {
                              if (attendanceDetailState is AttendanceDetailLoadSuccess) {
                                final bool isPresentToday = attendanceDetailState.attendance.isPresentToday;

                                if (isPresentToday) {
                                  return Text(
                                    'Anda sudah presensi hari ini',
                                    style: TextStyle(
                                      color: AppColors.statusSuccess,
                                      fontSize: FontSizes.standard,
                                      fontWeight: FontWeights.regular,
                                    ),
                                    textAlign: TextAlign.center,
                                  );
                                }
                              }

                              return CustomElevatedButton.primary(
                                onPressed: () => _presence(
                                  imagePath: imagePickerState.localPath ?? '',
                                  deviceLatitude: devicePositionState.position.latitude,
                                  deviceLongitude: devicePositionState.position.longitude,
                                ),
                                title: 'Presensi Sekarang',
                              );
                            },
                          );
                        },
                      );
                    } else if (devicePositionState is DevicePositionInitial) {
                      return Text(
                        'Mohon refresh lokasi Anda agar dapat presensi hari ini',
                        style: TextStyle(
                          color: AppColors.darkGray,
                          fontSize: FontSizes.standard,
                          fontWeight: FontWeights.regular,
                        ),
                        textAlign: TextAlign.center,
                      );
                    } else if (devicePositionState is DevicePositionLoading) {
                      return LoadingIndicator();
                    }
                    return SizedBox();
                  },
                );
              },
            ),
            32.gapHeight,
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationValidateSuccess) {
                  return CustomElevatedButton.primary(
                    onPressed: () => context.pushNamed(pageRoute: Routes.attendanceHistories, arguments: state.userId),
                    title: 'Lihat Riwayat Presensi',
                    margin: EdgeInsets.only(bottom: 16),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
