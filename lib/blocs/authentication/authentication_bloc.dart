import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location_based_attendance_app/requests/login_request.dart';
import 'package:location_based_attendance_app/requests/register_request.dart';
import 'package:location_based_attendance_app/services/authentication_service.dart';
import 'package:location_based_attendance_app/services/user_session_service.dart';
import 'package:location_based_attendance_app/shared/constants/error_messages.dart';
import 'package:location_based_attendance_app/shared/constants/success_messages.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationService authenticationService,
    required UserSessionService userSessionService,
  }) : _authenticationService = authenticationService,
       _userSessionService = userSessionService,
       super(AuthenticationValidateInitial()) {
    on<ValidateAuthenticationStarted>(_onValidateAuthenticationStarted);
    on<RegisterStarted>(_onRegisterStarted);
    on<LoginStarted>(_onLoginStarted);
    on<LogoutStarted>(_onLogoutStarted);
  }

  final AuthenticationService _authenticationService;
  final UserSessionService _userSessionService;

  Future<void> _onValidateAuthenticationStarted(
    ValidateAuthenticationStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final String? userId = await _userSessionService.get();

      if (userId == null) {
        emit(AuthenticationValidateFailure(ErrorMessages.authenticationFailed));

        return;
      }

      emit(AuthenticationValidateSuccess(SuccessMessages.loginSuccess, userId: userId));
    } catch (error) {
      emit(AuthenticationValidateFailure(error.toString()));
    }
  }

  Future<void> _onRegisterStarted(RegisterStarted event, Emitter<AuthenticationState> emit) async {
    try {
      emit(RegisterInProgress());

      final String userId = await _authenticationService.registerWithEmail(event.request);

      await _userSessionService.save(userId: userId);

      emit(RegisterSuccess(SuccessMessages.registerSuccess));

      emit(AuthenticationValidateSuccess(SuccessMessages.registerSuccess, userId: userId));
    } catch (error) {
      emit(RegisterFailure(error.toString()));
    }
  }

  Future<void> _onLoginStarted(LoginStarted event, Emitter<AuthenticationState> emit) async {
    try {
      emit(LoginInProgress());

      final String userId = await _authenticationService.loginWithEmail(event.request);

      await _userSessionService.save(userId: userId);

      emit(LoginSuccess(SuccessMessages.loginSuccess));

      emit(AuthenticationValidateSuccess(SuccessMessages.loginSuccess, userId: userId));
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }

  Future<void> _onLogoutStarted(LogoutStarted event, Emitter<AuthenticationState> emit) async {
    try {
      emit(LogoutInProgress());

      await _authenticationService.logout();

      await _userSessionService.clear();

      emit(LogoutSuccess(SuccessMessages.logoutSuccess));

      emit(AuthenticationValidateInitial());
    } catch (error) {
      emit(LogoutFailure(error.toString()));
    }
  }
}
