import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_based_attendance_app/blocs/attendance_histories/attendance_histories_bloc.dart';
import 'package:location_based_attendance_app/models/attendance_model.dart';
import 'package:location_based_attendance_app/shared/extensions/widget_gap_extension.dart';
import 'package:location_based_attendance_app/shared/helpers/date_time_formatter.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';
import 'package:location_based_attendance_app/shared/styles/font_sizes.dart';
import 'package:location_based_attendance_app/shared/styles/font_weights.dart';
import 'package:location_based_attendance_app/shared/widgets/loading_indicator.dart';

class AttendanceHistoriesPage extends StatefulWidget {
  const AttendanceHistoriesPage({super.key, required this.userId});

  final String userId;

  @override
  State<AttendanceHistoriesPage> createState() => _AttendanceHistoriesPageState();
}

class _AttendanceHistoriesPageState extends State<AttendanceHistoriesPage> {
  late final AttendanceHistoriesBloc _attendanceHistoriesBloc;

  @override
  void initState() {
    super.initState();

    _attendanceHistoriesBloc = context.read<AttendanceHistoriesBloc>();

    _attendanceHistoriesBloc.add(AllAttendanceHistoriesRequested(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Presensi Anda')),
      body: SafeArea(
        child: BlocBuilder<AttendanceHistoriesBloc, AttendanceHistoriesState>(
          builder: (context, state) {
            if (state is AttendanceHistoriesLoadFailure) {
              return Center(
                child: Text(
                  'Gagal mengambil data riwayat presensi Anda',
                  style: TextStyle(
                    color: AppColors.statusError,
                    fontSize: FontSizes.standard,
                    fontWeight: FontWeights.regular,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (state is AttendanceHistoriesLoadInProgress) {
              return LoadingIndicator();
            } else if (state is AttendanceHistoriesLoadSuccess) {
              if (state.attendances.isEmpty) {
                return Center(
                  child: Text(
                    'Anda belum memiliki riwayat presensi',
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontSize: FontSizes.standard,
                      fontWeight: FontWeights.regular,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView.separated(
                padding: EdgeInsets.all(16),
                separatorBuilder: (context, index) => 16.gapHeight,
                itemCount: state.attendances.length,
                itemBuilder: (context, index) {
                  final AttendanceModel attendance = state.attendances[index];
                  final String? imagePath = attendance.imagePath;
                  final String dateTime = DateTimeFormatter.formatDateTimeWithMonthName(attendance.createdAt);

                  return ListTile(
                    leading: imagePath == null
                        ? Icon(Icons.person, size: 50)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: RepaintBoundary(
                              child: Image.file(File(imagePath), width: 50, height: 50, fit: BoxFit.cover),
                            ),
                          ),
                    title: Text(dateTime),
                    subtitle: Text('Status presensi: ${attendance.status}'),
                  );
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
