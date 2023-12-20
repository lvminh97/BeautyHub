import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/change_password/bloc/change_password_bloc.dart';
import 'package:selling_food_store/modules/change_password/bloc/change_password_event.dart';
import 'package:selling_food_store/modules/change_password/view/change_password_view.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc()..add(OnInitChangePasswordEvent()),
      child: const ChangePasswordView(),
    );
  }
}
