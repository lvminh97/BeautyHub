abstract class ChangePaymentEvent {}

class OnChoosePaymentMethodEvent extends ChangePaymentEvent {
  //0: Thanh toáng khi nhận hàng, 1: Ví điện tử MOMO
  int paymentMethod;

  OnChoosePaymentMethodEvent(this.paymentMethod);
}
