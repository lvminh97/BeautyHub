import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/profile/bloc/profile_bloc.dart';
import 'package:selling_food_store/modules/profile/bloc/profile_event.dart';
import 'package:selling_food_store/modules/profile/view/profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        bool isClosed = ProfileBloc().isClosed;
        if (isClosed) {
          return ProfileBloc();
        }
        return ProfileBloc()..add(OnLoadingProfileEvent());
      },
      child: const ProfileView(),
    );
  }
}
