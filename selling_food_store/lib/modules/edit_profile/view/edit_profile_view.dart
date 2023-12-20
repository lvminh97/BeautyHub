import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:selling_food_store/modules/edit_profile/bloc/edit_profile_event.dart';
import 'package:selling_food_store/modules/edit_profile/bloc/edit_profile_state.dart';
import 'package:selling_food_store/shared/widgets/general/avatar_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dependency_injection.dart';
import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
import '../../../shared/utils/bottomsheet_utils.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/general/general_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final prefs = getIt.get<SharedPreferences>();
  DateTime dateTime = DateTime.now();
  int sex = 0;
  String? content;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      if (state is InitEditProfileState) {
        log('InitEditProfileState');
      } else if (state is DisplayEditProfileState) {
        log('DisplayEditProfileState');
        fullNameController.text = state.userInfo.fullName;
        content = state.userInfo.avatar ?? state.userInfo.fullName;
        addressController.text = state.userInfo.address!;
        dateTime = state.userInfo.birthDay!;
        birthDayController.text = AppUtils.formatDateTime(dateTime);
        emailController.text = prefs.getString(Strings.email) ?? '';
        sexController.text =
            state.userInfo.sex == 0 ? 'male'.tr() : 'female'.tr();
      } else if (state is ChooseBirthDayState) {
        dateTime = state.dateTime;
        birthDayController.text = AppUtils.formatDateTime(state.dateTime);
      }
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColor.whiteColor,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.blackColor,
              )),
          title: Text(
            'titleUpdateProfileInfo'.tr(),
            style: const TextStyle(
              color: AppColor.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24.0),
              content != null
                  ? AvatarProfile(
                      avatar: content!,
                      onEdit: (imageAvatar) {
                        context
                            .read<EditProfileBloc>()
                            .add(OnUpdateAvatarUserEvent(imageAvatar));
                      },
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(height: 56.0),
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: 'fullNameInputUserInfo'.tr(),
                  hintText: 'hintTextInputNameUserInfo'.tr(),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'phoneInputUserInfo'.tr(),
                  hintText: 'hintTextInputPhoneUserInfo'.tr(),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                readOnly: true,
                controller: sexController,
                decoration: InputDecoration(
                  labelText: 'sexEditProfile'.tr(),
                  hintText: 'hintSexEditProfile'.tr(),
                  suffixIcon: InkWell(
                    child: const Icon(Icons.arrow_drop_down),
                    onTap: () {
                      showMenu(
                        initialValue: sex,
                        context: context,
                        position:
                            const RelativeRect.fromLTRB(16, 400, 200, 200),
                        items: [
                          PopupMenuItem(
                            value: 1,
                            child: Text('male'.tr()),
                            onTap: () {
                              setState(() {
                                sex = 1;
                                sexController.text = 'male'.tr();
                              });
                            },
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text('female'.tr()),
                            onTap: () {
                              setState(() {
                                sex = 2;
                                sexController.text = 'female'.tr();
                              });
                            },
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: Text('otherSex'.tr()),
                            onTap: () {
                              setState(() {
                                sex = 3;
                                sexController.text = 'otherSex'.tr();
                              });
                            },
                          ),
                        ],
                        elevation: 8.0,
                      );
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: emailController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'emailProfile'.tr(),
                  hintText: 'hintTextEmailProfile'.tr(),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: birthDayController,
                decoration: InputDecoration(
                  labelText: 'birthDayInputUserInfo'.tr(),
                  hintText: 'hintTextInputBirthDayUserInfo'.tr(),
                  suffixIcon: InkWell(
                    child: const Icon(Icons.event),
                    onTap: () {
                      BottomSheetUtils.showBottomSheetChooseBirthDay(
                          context: context,
                          onSelect: (newDateTime) {
                            context
                                .read<EditProfileBloc>()
                                .add(OnChooseBirthDayEvent(newDateTime));
                          });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'textInputAddressUserInfo'.tr(),
                  hintText: 'hintTextInputAddressUserInfo'.tr(),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32.0),
              GeneralButton(
                title: 'updateProfileInfo'.tr(),
                onClick: () {
                  context.read<EditProfileBloc>().add(OnUpdateUserInfoEvent(
                      fullNameController.text,
                      addressController.text,
                      dateTime));
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
