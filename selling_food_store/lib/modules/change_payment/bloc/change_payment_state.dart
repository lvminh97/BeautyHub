import 'package:equatable/equatable.dart';

abstract class ChangePaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitChangePaymentState extends ChangePaymentState {}

class ChoosePaymentMethodState extends ChangePaymentState {
  final int value;

  ChoosePaymentMethodState(this.value);

  @override
  List<Object?> get props => [value];
}
