import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/models/user_info.dart';
import 'package:selling_food_store/modules/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:selling_food_store/modules/edit_profile/bloc/edit_profile_event.dart';
import 'package:selling_food_store/modules/edit_profile/view/edit_profile_view.dart';

class EditProfilePage extends StatelessWidget {
  final UserInfo userInfo;
  const EditProfilePage({
    super.key,
    required this.userInfo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc()..add(OnInitEditProfileEvent(userInfo)),
      child: const EditProfileView(),
    );
  }
}
