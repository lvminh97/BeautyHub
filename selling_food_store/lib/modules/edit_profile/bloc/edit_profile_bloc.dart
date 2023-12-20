import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:selling_food_store/modules/edit_profile/bloc/edit_profile_event.dart';
import 'package:selling_food_store/modules/edit_profile/bloc/edit_profile_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(InitEditProfileState()) {
    if (!isClosed) {
      on<OnInitEditProfileEvent>(_onHandlerUserInfo);
      on<OnChooseBirthDayEvent>(_onChooseBirthDay);
      on<OnUpdateUserInfoEvent>(_onUpdateUserInfo);
      on<OnUpdateAvatarUserEvent>(_onUpdateAvatar);
    }
  }

  void _onHandlerUserInfo(
      OnInitEditProfileEvent event, Emitter<EditProfileState> emitter) {
    emitter(DisplayEditProfileState(event.userInfo));
  }

  void _onChooseBirthDay(
      OnChooseBirthDayEvent event, Emitter<EditProfileState> emitter) {
    emitter(ChooseBirthDayState(event.dateTime));
  }

  void _onUpdateUserInfo(
      OnUpdateUserInfoEvent event, Emitter<EditProfileState> emitter) {
    FirebaseService.updateUserInfo(event.name, event.address, event.dateTime);
  }

  void _onUpdateAvatar(
      OnUpdateAvatarUserEvent event, Emitter<EditProfileState> emitter) {
    FirebaseService.updateAvatarProfileToStorage(event.imageFile, () {
      EasyLoading.showSuccess('updateAvatarSuccess'.tr());
    }, (error) {
      EasyLoading.showError('unknown'.tr());
    });
  }
}
