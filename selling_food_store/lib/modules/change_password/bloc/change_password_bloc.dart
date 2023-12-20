import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/change_password/bloc/change_password_event.dart';
import 'package:selling_food_store/modules/change_password/bloc/change_password_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(InitChangePasswordState()) {
    on<OnInitChangePasswordEvent>(_onInit);
    on<OnGetCredentialEvent>(_onGetUserCredential);
    on<OnChangePasswordEvent>(_onChangePassword);
    on<OnErrorEvent>(_onError);
  }

  void _onInit(
      OnInitChangePasswordEvent event, Emitter<ChangePasswordState> emitter) {
    FirebaseService.getUserCredential((credential) {}, (error) {
      add(OnErrorEvent(error));
    });
  }

  void _onGetUserCredential(
      OnGetCredentialEvent event, Emitter<ChangePasswordState> emitter) {
    emitter(GetCredentialState(event.password));
  }

  void _onChangePassword(
      OnChangePasswordEvent event, Emitter<ChangePasswordState> emitter) {
    String newPassword = event.password;
    if (newPassword.isNotEmpty) {
      FirebaseService.changePassword(event.oldPassword, newPassword, () {
        emitter(ChangePasswordSuccessState());
      }, (error) {
        add(OnErrorEvent(error));
      });
    }
  }

  void _onError(OnErrorEvent event, Emitter<ChangePasswordState> emitter) {
    emitter(ChangePasswordFailureState(event.error));
  }
}
