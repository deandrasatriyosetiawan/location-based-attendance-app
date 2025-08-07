import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location_based_attendance_app/models/user_model.dart';
import 'package:location_based_attendance_app/services/user_service.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc({required UserService userService}) : _userService = userService, super(UserDetailInitial()) {
    on<UserDetailRequested>(_onDetailRequested);
  }

  final UserService _userService;

  Future<void> _onDetailRequested(UserDetailRequested event, Emitter<UserDetailState> emit) async {
    try {
      emit(UserDetailLoadInProgress());

      final UserModel user = await _userService.fetchUser(id: event.userId);

      emit(UserDetailLoadSuccess(user));
    } catch (error) {
      emit(UserDetailLoadFailure(error.toString()));
    }
  }
}
