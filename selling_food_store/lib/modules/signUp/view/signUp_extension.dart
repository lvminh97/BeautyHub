part of 'signUp_view.dart';

extension SignUpExtension on SignUpView {

  //  Widget buildUserSignUpForm(Bui) {
  //   return Form(
  //     key: globalKey,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           'sign_up_title'.tr(),
  //           style: const TextStyle(
  //             fontSize: 16.0,
  //             color: Colors.black,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 8.0),
  //         TextFormField(
  //           controller: emailController,
  //           validator: (value) => ValidateUtils.validateEmail(value),
  //           decoration: InputDecoration(
  //             labelText: 'email'.tr(),
  //             hintText: 'hintEmailText'.tr(),
  //             hintStyle: const TextStyle(fontSize: 14.0),
  //             prefixIcon: const Icon(Icons.email_outlined),
  //             border: const OutlineInputBorder(),
  //             contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
  //           ),
  //         ),
  //         const SizedBox(height: 16.0),
  //         TextFormField(
  //           controller: passwordController,
  //           decoration: InputDecoration(
  //             labelText: 'password'.tr(),
  //             hintText: 'hintPasswordText'.tr(),
  //             hintStyle: const TextStyle(fontSize: 14.0),
  //             prefixIcon: const Icon(Icons.lock_outlined),
  //             suffixIcon: const Icon(Icons.visibility_outlined),
  //             border: const OutlineInputBorder(),
  //             contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
  //           ),
  //         ),
  //         const SizedBox(height: 16.0),
  //         Text(
  //           'user_info'.tr(),
  //           style: const TextStyle(
  //             fontSize: 16.0,
  //             color: Colors.black,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 8.0),
  //         Text(
  //           'fullNameInputUserInfo'.tr(),
  //           style: const TextStyle(
  //             fontSize: 14.0,
  //             color: AppColor.primaryAppColor,
  //           ),
  //         ),
  //         const SizedBox(height: 8.0),
  //         TextFormField(
  //           controller: fullNameController,
  //           decoration: InputDecoration(
  //             hintText: 'hintTextInputNameUserInfo'.tr(),
  //             prefixIcon: const Icon(Icons.person),
  //           ),
  //         ),
  //         const SizedBox(height: 16.0),
  //         Text(
  //           'birthDayInputUserInfo'.tr(),
  //           style: const TextStyle(
  //             fontSize: 14.0,
  //             color: AppColor.primaryAppColor,
  //           ),
  //         ),
  //         const SizedBox(height: 8.0),
  //         TextFormField(
  //           controller: birthDayController,
  //           readOnly: true,
  //           decoration: InputDecoration(
  //             hintText: 'hintTextInputBirthDayUserInfo'.tr(),
  //             suffixIcon: InkWell(
  //               onTap: () {
  //                 BottomSheetUtils.showBottomSheetChooseBirthDay(
  //                     context: context,
  //                     onSelect: (birthDay) {
  //                       setState(() {
  //                         dateTime = birthDay;
  //                         birthDayController.text =
  //                             AppUtils.formatDateTime(dateTime);
  //                       });
  //                     });
  //               },
  //               child: const Icon(Icons.event),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 16.0),
  //         Text(
  //           'textInputSexUserInfo'.tr(),
  //           style: const TextStyle(
  //             fontSize: 14.0,
  //             color: AppColor.primaryAppColor,
  //           ),
  //         ),
  //         const SizedBox(height: 8.0),
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //           decoration: BoxDecoration(
  //             border: Border.all(color: AppColor.primaryAppColor),
  //             borderRadius: BorderRadius.circular(4.0),
  //           ),
  //           child: DropdownButtonHideUnderline(
  //             child: DropdownButton<int>(
  //               isExpanded: true,
  //               items: [
  //                 DropdownMenuItem(
  //                   value: 0,
  //                   child: Text('male'.tr()),
  //                 ),
  //                 DropdownMenuItem(
  //                   value: 1,
  //                   child: Text('female'.tr()),
  //                 ),
  //                 DropdownMenuItem(
  //                   value: 2,
  //                   child: Text('otherSex'.tr()),
  //                 )
  //               ],
  //               onChanged: (value) {
  //                 setState(() {
  //                   sex = value ?? 0;
  //                 });
  //               },
  //               value: sex,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 16.0),
  //         Text(
  //           'textInputAddressUserInfo'.tr(),
  //           style: const TextStyle(
  //             fontSize: 14.0,
  //             color: AppColor.primaryAppColor,
  //           ),
  //         ),
  //         const SizedBox(height: 8.0),
  //         TextFormField(
  //           controller: addressController,
  //           maxLines: 5,
  //           decoration: InputDecoration(
  //             hintText: 'hintTextInputAddressUserInfo'.tr(),
  //             border: const OutlineInputBorder(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

}