// Events
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcredo/src/resources/user_management_api.dart';

abstract class RegistrationEvent {}

class RegisterUserEvent extends RegistrationEvent {
  final String businessName;
  final String businessYear;
  final String businessMonth;
  final String ownerName;
  final List<String>? PartnerName;
  final String mobileNumber;
  final String address1;
  final String landmark;
  final String city;
  final String state;
  final String country;
  final String pinCode;
  final String businessType;
  final String businessLevel;
  final String password;

  RegisterUserEvent({
    required this.businessName,
    required this.businessYear,
    required this.businessMonth,
    required this.ownerName,
    required this.PartnerName,
    required this.mobileNumber,
    required this.address1,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.country,
    required this.businessLevel,
    required this.businessType,
    required this.password,
  });
}

// state

abstract class RegistrationState {}

class RegisterInitState extends RegistrationState {}

class RegisterLoadingState extends RegistrationState {}

class RegisterSuccessState extends RegistrationState {
  final String message;

  RegisterSuccessState({required this.message});
}

class RegisterFailedState extends RegistrationState {
  final String error;

  RegisterFailedState({required this.error});
}

class RegisterBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthenticationService authService;

  RegisterBloc({required this.authService}) : super(RegisterInitState()) {
    on<RegisterUserEvent>(_onUserRegiUser);
  }

  Future<void> _onUserRegiUser(
    RegisterUserEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegisterLoadingState());
  }
}
