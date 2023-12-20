import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paypal_api/paypal_api.dart';
import 'package:selling_food_store/models/order.dart';
import 'package:selling_food_store/models/order_item.dart';
import 'package:selling_food_store/models/user_info.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/services/hive_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../dependency_injection.dart';
import '../../../shared/utils/strings.dart';
import 'order_event.dart';
import 'order_state.dart';

import 'dart:convert';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final prefs = getIt.get<SharedPreferences>();
  final paypalRepository = getIt.get<PaypalRepository>();
  final List<Item> items = [];
  final List<OrderItem> orderItems = [];
  UserInfo? userInfo;
  bool _isBuyNow = false;

  OrderBloc() : super(InitRequestOrderState()) {
    on<OnLoadingUserInfoEvent>(_onLoadingUserInfo);
    on<OnDisplayUserInfoEvent>(_onDisplayUserInfo);
    on<OnLoadingRequestOrderEvent>(_onLoadingRequestOrder);
    on<OnDisplayRequestOrderEvent>(_onDisplayRequestOrder);
    on<OnChoosePaymentMethodEvent>(_onChoosePaymentMethod);
    on<OnRequestOrderProductEvent>(_onRequestOrderProduct);
    on<OnRequestOrderProductFailureEvent>(_onRequestOrderFailure);
    on<OnAddProductToOrderInfoEvent>(_onAddProduct);
    on<OnAddTrackingOrderEvent>(_onAddTrackingOrder);
    on<OnConfirmOrderEvent>(_onConfirmOrder);
  }

  Future<void> _onLoadingUserInfo(
      OnLoadingUserInfoEvent event, Emitter<OrderState> emitter) async {
    userInfo = await FirebaseService.getUserInfo((error) {});
    if (userInfo != null) {
      add(OnDisplayUserInfoEvent(userInfo!.fullName, userInfo!.address!));
    }
  }

  void _onDisplayUserInfo(
      OnDisplayUserInfoEvent event, Emitter<OrderState> emitter) {
    emitter(DisplayUserInfoState(event.name, event.address));
  }

  void _onLoadingRequestOrder(
      OnLoadingRequestOrderEvent event, Emitter<OrderState> emitter) {
    _isBuyNow = event.isBuyNow;
    log('Buy now: $_isBuyNow');
    add(OnDisplayRequestOrderEvent(event.cartList));
  }

  void _onDisplayRequestOrder(
      OnDisplayRequestOrderEvent event, Emitter<OrderState> emitter) {
    emitter(DisplayProductForRequestOrderState(event.cartList));
  }

  void _onAddProduct(
      OnAddProductToOrderInfoEvent event, Emitter<OrderState> emitter) {
    items.add(event.item);
    orderItems.add(event.orderItem);
  }

  void _onChoosePaymentMethod(
      OnChoosePaymentMethodEvent event, Emitter<OrderState> emitter) {
    prefs.setInt(Strings.paymentMethod, event.value);
    emitter(ChoosePaymentMethodState(event.value));
  }

  Future<void> _onRequestOrderProduct(
      OnRequestOrderProductEvent event, Emitter<OrderState> emitter) async {
    if (userInfo != null) {
      int paymentMethodValue = prefs.getInt(Strings.paymentMethod) ?? -1;
      if (paymentMethodValue == 2) {
        EasyLoading.showToast('feature_in_development'.tr());
      } else if (paymentMethodValue == -1) {
        add(OnRequestOrderProductFailureEvent('choosePaymentMethod'.tr()));
      } else {
        try {
          EasyLoading.show();
          if (paymentMethodValue == 0) {
            String idOrder = const Uuid().v4();
            Order order = Order(idOrder, userInfo!.idAccount, DateTime.now(),
                'CREATED', orderItems);
            FirebaseService.createOrder(order, () {
              EasyLoading.dismiss();
              //Chuyển sang màn hình xác nhận đơn hàng (Confirm Order)
              FirebaseService.writeOrderByUser(idOrder);
              FirebaseService.writeOrderByStore(idOrder, orderItems);
              add(OnConfirmOrderEvent());
            }, (error) => log('Error: $error'));
          } else if (paymentMethodValue == 1) {
            _createOrder(paymentMethodValue);
          }
        } on DioException catch (error) {
          if (error.response != null) {
            log('Error: ${error.message.toString()}');
            add(OnRequestOrderProductFailureEvent(error.message.toString()));
          }
        }
      }
    }
  }

  void _onConfirmOrder(OnConfirmOrderEvent event, Emitter<OrderState> emitter) {
    HiveService.deleteAllItemCart();
    emitter(ConfirmOrderState());
  }

  void _onAddTrackingOrder(
      OnAddTrackingOrderEvent event, Emitter<OrderState> emitter) {
    emitter(AddTrackingOrderState(event.idInvoice, userInfo!.idAccount));
  }

  void _onRequestOrderFailure(
      OnRequestOrderProductFailureEvent event, Emitter<OrderState> emitter) {
    emitter(RequestOrderProductFailureState(event.error));
  }

  Future<void> _createOrder(int paymentMethod) async {
    String credentials =
        "${AppConstants.clientID}:${AppConstants.clientSecret}";
    String encoded = base64.encode(utf8.encode(credentials));
    final author = await paypalRepository.authorize(
        authorization: 'Basic $encoded', grantType: AppConstants.grantType);
    final result = await paypalRepository.createInvoiceNumber(
        token: 'Bearer ${author.accessToken}');
    if (result.invoiceNumber.isNotEmpty) {
      InvoiceRequest request = InvoiceRequest(
          detail: Detail('USD', result.invoiceNumber),
          invoicer: Invoicer(
              Name('Jeremie Nguyen'),
              Address('US', '1234 First Street', '98765'),
              'sb-9sy6b28569522@business.example.com'),
          recipients: [
            Recipient(
                BillingInfo(
                    Name(userInfo!.fullName),
                    Address('US', userInfo!.address ?? '1234 First Street',
                        '98765'),
                    'sb-di8k928585644@personal.example.com'),
                null)
          ],
          items: items);
      final response = await paypalRepository.createInvoice(
          request: request, token: 'Bearer ${author.accessToken}');
      if (response.href.isNotEmpty) {
        EasyLoading.dismiss();
        String idInvoice = response.href.split('/').last;
        //Chuyển sang màn hình theo dõi đơn hàng (Tracking Order)
        add(OnAddTrackingOrderEvent(idInvoice));
      }
    }
  }
}
