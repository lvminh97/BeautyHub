import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:selling_food_store/dependency_injection.dart';
import 'package:selling_food_store/models/credential.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_event.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_info.dart';
import '../../../shared/utils/strings.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final prefs = getIt.get<SharedPreferences>();

  SignUpBloc() : super(InitialSignUpState()) {
    on<OnSignUpAccountEvent>(_onSignUp);
    on<OnInitInputUserProfileEvent>(_onInputUserProfile);
    on<OnErrorEvent>(_onErrorSignUp);
  }

  Future<void> _onSignUp(
      OnSignUpAccountEvent event, Emitter<SignUpState> emitter) async {
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      final authCredential = await FirebaseService.signUpFirebaseWithEmail(
          event.email, event.password, (error) => add(OnErrorEvent(error)));
      if (authCredential != null && authCredential.user != null) {
        String idUser = authCredential.user!.uid;
        prefs.setString(Strings.email, event.email);
        prefs.setString(Strings.idUser, idUser);
        final credential = Credential(
            idUser: idUser, email: event.email, createAt: DateTime.now());
        FirebaseService.insertCredentialToDb(credential, () {
          final userInfo = UserInfo(idUser, event.name, null, event.birthDay,
              event.address, event.sex);
          FirebaseService.insertUserInfoToDb(userInfo, () {
            EasyLoading.showSuccess('signUpSuccess'.tr());
          }, (error) {
            add(OnErrorEvent(error));
          });
        }, (error) {
          add(OnErrorEvent(error));
        });
      }
    } else {
      add(OnErrorEvent('emptyInputData'.tr()));
    }
  }

  void _onInputUserProfile(
      OnInitInputUserProfileEvent event, Emitter<SignUpState> emitter) {
    emitter(SuccessSignUpWithEmailPasswordState());
  }

  void _onErrorSignUp(OnErrorEvent event, Emitter<SignUpState> emitter) {
    emitter(ErrorSignUpState(event.message));
  }
}
