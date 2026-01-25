import 'package:bloc/bloc.dart';
import 'package:xcredo/src/resources/user_management_api.dart';

// Events
abstract class LoginEvent {}

class LoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmittedEvent({required this.email, required this.password});
}

// States
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState({required this.error});
}

// BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService authService;

  LoginBloc({required this.authService}) : super(LoginInitialState()) {
    on<LoginSubmittedEvent>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());

    try {
      // await authService.loginAPi(event.email, event.password);
      emit(LoginSuccessState());
    } catch (error) {
      emit(LoginFailureState(error: error.toString()));
    }
  }
}
