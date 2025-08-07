part of 'device_position_bloc.dart';

sealed class DevicePositionEvent extends Equatable {
  const DevicePositionEvent();

  @override
  List<Object> get props => [];
}

final class GetCurrentPositionStarted extends DevicePositionEvent {}

final class ClearCurrentPositionStarted extends DevicePositionEvent {}
