import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/dependency_injection.dart';
import 'package:selling_food_store/modules/change_payment/bloc/change_payment_event.dart';
import 'package:selling_food_store/modules/change_payment/bloc/change_payment_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/utils/strings.dart';

class ChangePaymentBloc extends Bloc<ChangePaymentEvent, ChangePaymentState> {
  final prefs = getIt.get<SharedPreferences>();

  ChangePaymentBloc() : super(InitChangePaymentState()) {
    on<OnChoosePaymentMethodEvent>(_onChoosePayment);
  }

  void _onChoosePayment(
      OnChoosePaymentMethodEvent event, Emitter<ChangePaymentState> emitter) {
    prefs.setInt(Strings.paymentMethod, event.paymentMethod);
    emitter(ChoosePaymentMethodState(event.paymentMethod));
  }
}
