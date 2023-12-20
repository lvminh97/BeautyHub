import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/profile/bloc/profile_bloc.dart';
import 'package:selling_food_store/modules/profile/bloc/profile_event.dart';
import 'package:selling_food_store/modules/profile/bloc/profile_state.dart';
import 'package:selling_food_store/shared/widgets/general/avatar_profile.dart';
import 'package:selling_food_store/shared/widgets/general/empty_data_widget.dart';
import 'package:selling_food_store/shared/widgets/general/loading_data_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dependency_injection.dart';
import '../../../models/user_info.dart';
import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
import '../../../shared/utils/image_constants.dart';
import '../../../shared/utils/show_dialog_utils.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/dialog/notify_dialog.dart';
import '../../../shared/widgets/general/general_button.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isDisplay = false;
  String chooseLanguage = 'vi';
  UserInfo? userInfo;

  final prefs = getIt.get<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is DisplayProfileState) {
          isDisplay = true;
          userInfo = state.userInfo;
          chooseLanguage = prefs.getString(Strings.language) ?? 'vi';
        }
        return Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AppColor.whiteColor,
            leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColor.blackColor,
                )),
            actions: [
              userInfo != null
                  ? IconButton(
                      onPressed: () {
                        context.goNamed('editProfile', extra: userInfo);
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: AppColor.blackColor,
                      ))
                  : const SizedBox(),
            ],
          ),
          body: isDisplay
              ? userInfo != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AvatarProfile(
                                avatar: userInfo!.fullName,
                                width: 64.0,
                                height: 64.0,
                                isEdit: false,
                              ),
                              const SizedBox(width: 12.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    userInfo!.fullName,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  userInfo!.address != null &&
                                          userInfo!.address!.isEmpty &&
                                          userInfo!.address != ''
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Text(
                                            userInfo!.address!,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(height: 8.0),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        '${'sexProfile'.tr()} ${userInfo!.sex == 0 ? 'male'.tr() : 'female'.tr()}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      const SizedBox(width: 12.0),
                                      Text(
                                        '${'birthDayProfile'.tr()} ${AppUtils.formatDateTime(userInfo!.birthDay!)}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          _buildLabel(
                              name: 'orderManage'.tr(),
                              icon: Icons.assessment_outlined,
                              onClicked: () {
                                context.goNamed('orderList');
                              }),
                          const SizedBox(height: 8.0),
                          _buildLabel(
                              name: 'paymentManage'.tr(),
                              icon: Icons.attach_money_outlined,
                              onClicked: () {
                                context.goNamed('changePayment');
                              }),
                          const SizedBox(height: 8.0),
                          _buildLabel(
                              name: 'yourCart'.tr(),
                              icon: Icons.shopping_bag_outlined,
                              onClicked: () {
                                context.goNamed('profileCart');
                              }),
                          const SizedBox(height: 8.0),
                          _buildLabel(
                            name: 'changeLanguage'.tr(),
                            icon: Icons.language,
                            isExpand: true,
                            onSelect: (locale) {
                              context
                                  .read<ProfileBloc>()
                                  .add(OnChangeLanguageEvent(locale));
                            },
                          ),
                          // const SizedBox(height: 8.0),
                          // _buildLabel(
                          //     name: 'changePassword'.tr(),
                          //     icon: Icons.autorenew,
                          //     onClicked: () {
                          //       context.goNamed('changePassword');
                          //     }),
                          const SizedBox(height: 24.0),
                          GeneralButton(
                            title: 'signOut'.tr(),
                            backgroundColor: Colors.red,
                            onClick: () {
                              context.read<ProfileBloc>().add(OnSignOutEvent());
                            },
                          ),
                          const SizedBox(height: 8.0),
                          GeneralButton(
                            title: 'deleteAccount'.tr(),
                            isStroke: true,
                            isTransparent: true,
                            borderColor: Colors.red,
                            textColor: Colors.red,
                            onClick: () {},
                          ),
                        ],
                      ))
                  : EmptyDataWidget(
                      emptyType: EmptyType.profileEmpty,
                      onClick: () {
                        context.pushNamed('signIn');
                      })
              : const LoadingDataWidget(
                  loadingType: LoadingDataType.loadingUserInfo),
        );
      },
      listener: (context, state) {
        if (state is ConfirmSignOutState) {
          context.pop();
        } else if (state is SignOutState) {
          ShowDialogUtils.showDialogNotify(
            context: context,
            typeDialog: NotifyTypeDialog.notifyConfirmSignOut,
            message: 'signOutRequest'.tr(),
            onConfirm: () {
              context.read<ProfileBloc>().add(OnConfirmSignOutEvent());
            },
            onClose: () {},
          );
        } else if (state is ErrorState) {
          EasyLoading.showError(state.error);
        } else if (state is ChangeLanguageState) {
          prefs.setString(Strings.language, state.locale.languageCode);
          context.setLocale(state.locale);
        }
      },
    );
  }

  Widget _buildLabel({
    required String name,
    required IconData icon,
    Function()? onClicked,
    Function(Locale)? onSelect,
    bool isExpand = false,
  }) {
    return isExpand
        ? ExpandablePanel(
            theme: ExpandableThemeData(
              tapBodyToExpand: true,
              hasIcon: true,
              expandIcon: Icons.chevron_right_outlined,
              iconColor: AppColor.hintBlackColor,
              iconSize: 32.0,
            ),
            header: ListTile(
              leading: Icon(icon),
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 0.0,
              title: Text(
                name,
                style: const TextStyle(
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            collapsed: const SizedBox(),
            expanded: Column(
              children: [
                ListTile(
                  leading: Image.asset(
                    ImageConstants.flagOfVietNam,
                    width: 24.0,
                    height: 24.0,
                  ),
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 12.0,
                  title: const Text(
                    'Vietnam',
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Radio(
                    value: 'vi',
                    groupValue: chooseLanguage,
                    onChanged: (String? value) {
                      setState(() {
                        chooseLanguage = value ?? 'vi';
                        if (onSelect != null) {
                          onSelect(const Locale('vi', 'VN'));
                        }
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      chooseLanguage = 'vi';
                      if (onSelect != null) {
                        onSelect(const Locale('vi', 'VN'));
                      }
                    });
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    ImageConstants.flagOfEngland,
                    width: 24.0,
                    height: 24.0,
                  ),
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 12.0,
                  title: const Text(
                    'English',
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Radio(
                    value: 'en',
                    groupValue: chooseLanguage,
                    onChanged: (String? value) {
                      setState(() {
                        chooseLanguage = value ?? 'en';
                        if (onSelect != null) {
                          onSelect(const Locale('en', 'US'));
                        }
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      chooseLanguage = 'en';
                      if (onSelect != null) {
                        onSelect(const Locale('en', 'US'));
                      }
                    });
                  },
                ),
              ],
            ),
          )
        : ListTile(
            leading: Icon(icon),
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0.0,
            title: Text(
              name,
              style: const TextStyle(
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                if (onClicked != null) {
                  onClicked();
                }
              },
              icon: const Icon(
                Icons.chevron_right_outlined,
                size: 32.0,
              ),
            ),
            onTap: () {
              if (onClicked != null) {
                onClicked();
              }
            },
          );
  }
}
