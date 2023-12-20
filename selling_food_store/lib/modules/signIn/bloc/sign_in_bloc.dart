import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selling_food_store/modules/signIn/bloc/sign_in_event.dart';
import 'package:selling_food_store/modules/signIn/bloc/sign_in_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dependency_injection.dart';
import '../../../shared/utils/strings.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {

  final prefs = getIt.get<SharedPreferences>();

  SignInBloc() : super(InitSignInState()) {
    on<OnUserSignInEvent>(_onSignIn);
    on<OnSignInSuccesEvent>(_onSuccess);
    on<OnSignInFailureEvent>(_onFailure);
    on<OnCloseDialogEvent>(_onClose);
  }

  void _onSignIn(OnUserSignInEvent event, Emitter<SignInState> emitter) {
    FirebaseService.signInFirebaseWithEmail(event.email, event.password,
        (idUser) {
      prefs.setString(Strings.email, event.email);
      prefs.setString(Strings.idUser, idUser);
      add(OnSignInSuccesEvent());
    }, (error) {
      add(OnSignInFailureEvent(error ?? 'errorStr'.tr()));
    });
  }

  void _onSuccess(OnSignInSuccesEvent event, Emitter<SignInState> emitter) {
    emitter(SignInSuccessState());
  }

  void _onFailure(OnSignInFailureEvent event, Emitter<SignInState> emitter) {
    emitter(SignInFailureState(event.error));
  }

  void _onClose(OnCloseDialogEvent event, Emitter<SignInState> emitter) {
    emitter(CloseDialogState());
  }
}
