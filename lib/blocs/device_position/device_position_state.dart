part of 'device_position_bloc.dart';

sealed class DevicePositionState extends Equatable {
  const DevicePositionState();

  @override
  List<Object> get props => [];
}

final class DevicePositionInitial extends DevicePositionState {}

final class DevicePositionLoading extends DevicePositionState {}

final class DevicePositionLoadSuccess extends DevicePositionState {
  const DevicePositionLoadSuccess(this.position);

  final Position position;

  @override
  List<Object> get props => [position];
}

final class DevicePositionLoadFailure extends DevicePositionState {
  const DevicePositionLoadFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
