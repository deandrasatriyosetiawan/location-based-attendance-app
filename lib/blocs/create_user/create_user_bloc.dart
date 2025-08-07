import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location_based_attendance_app/requests/create_user_request.dart';
import 'package:location_based_attendance_app/services/user_service.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  CreateUserBloc({required UserService userService}) : _userService = userService, super(CreateUserInitial()) {
    on<CreateUserRequested>(_onCreateRequested);
  }

  final UserService _userService;

  Future<void> _onCreateRequested(CreateUserRequested event, Emitter<CreateUserState> emit) async {
    try {
      emit(CreateUserInProgress());

      await _userService.createUser(event.request);

      emit(CreateUserSuccess());
    } catch (error) {
      emit(CreateUserFailure(error.toString()));
    }
  }
}
