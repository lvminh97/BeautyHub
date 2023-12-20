import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_bloc.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_event.dart';
import 'package:selling_food_store/modules/signUp/bloc/signUp_state.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';
import 'package:selling_food_store/shared/utils/bottomsheet_utils.dart';
import 'package:selling_food_store/shared/utils/validate_utils.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/widgets/general/general_button.dart';

part 'signUp_extension.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool isAccept = false;
  int sex = 0;
  DateTime dateTime = DateTime.now();
  String? error;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      if (state is ErrorSignUpState) {
        error = state.message;
        EasyLoading.showError(error ?? 'unknown'.tr());
        _globalKey.currentState!.reset();
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
            ),
          ),
          title: Text(
            'signUp'.tr(),
            style: const TextStyle(
              fontSize: 16.0,
              color: AppColor.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildUserSignUpForm(),
                const SizedBox(height: 16.0),
                CheckboxListTile(
                  value: isAccept,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: RichText(
                      text: TextSpan(
                          text: 'titleAccept'.tr(),
                          style: const TextStyle(
                              color: AppColor.blackColor, fontSize: 12.0),
                          children: [
                        TextSpan(
                            text: 'terms'.tr(),
                            style: const TextStyle(
                                color: AppColor.primaryAppColor,
                                fontSize: 12.0)),
                        TextSpan(text: 'toOur'.tr()),
                        TextSpan(text: 'acknowledge'.tr()),
                        TextSpan(
                            text: 'privacyPolicy'.tr(),
                            style: const TextStyle(
                                color: AppColor.primaryAppColor,
                                fontSize: 12.0)),
                      ])),
                  onChanged: (value) {
                    setState(() {
                      isAccept = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                GeneralButton(
                  title: 'textSignUp'.tr(),
                  onClick: () {
                    if (_globalKey.currentState!.validate()) {
                      if (isAccept) {
                        context.read<SignUpBloc>().add(OnSignUpAccountEvent(
                            emailController.text,
                            passwordController.text,
                            fullNameController.text,
                            dateTime,
                            sex,
                            addressController.text));
                      } else {
                        EasyLoading.showToast(
                            'Bạn chưa đồng ý điều khoản của chúng tôi');
                      }
                    }
                  },
                ),
                const SizedBox(height: 12.0),
                error != null
                    ? Text(
                        error!,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.red,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildUserSignUpForm() {
    return Form(
      key: _globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'sign_up_title'.tr(),
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: emailController,
            validator: (value) => ValidateUtils.validateEmail(value),
            decoration: InputDecoration(
              labelText: 'email'.tr(),
              hintText: 'hintEmailText'.tr(),
              hintStyle: const TextStyle(fontSize: 14.0),
              prefixIcon: const Icon(Icons.email_outlined),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: passwordController,
            validator: (value) => ValidateUtils.validatePassword(value),
            decoration: InputDecoration(
              labelText: 'password'.tr(),
              hintText: 'hintPasswordText'.tr(),
              hintStyle: const TextStyle(fontSize: 14.0),
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: const Icon(Icons.visibility_outlined),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            ),
          ),
          const SizedBox(height: 24.0),
          Text(
            'user_info'.tr(),
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'fullNameInputUserInfo'.tr(),
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryAppColor,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: fullNameController,
            validator: (value) => ValidateUtils.validateEmptyData(value),
            decoration: InputDecoration(
              hintText: 'hintTextInputNameUserInfo'.tr(),
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'birthDayInputUserInfo'.tr(),
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryAppColor,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: birthDayController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'hintTextInputBirthDayUserInfo'.tr(),
              suffixIcon: InkWell(
                onTap: () {
                  BottomSheetUtils.showBottomSheetChooseBirthDay(
                      context: context,
                      onSelect: (birthDay) {
                        setState(() {
                          dateTime = birthDay;
                          birthDayController.text =
                              AppUtils.formatDateTime(dateTime);
                        });
                      });
                },
                child: const Icon(Icons.event),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'textInputSexUserInfo'.tr(),
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryAppColor,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primaryAppColor),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: 0,
                    child: Text('male'.tr()),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text('female'.tr()),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('otherSex'.tr()),
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    sex = value ?? 0;
                  });
                },
                value: sex,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'textInputAddressUserInfo'.tr(),
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColor.primaryAppColor,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: addressController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'hintTextInputAddressUserInfo'.tr(),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
