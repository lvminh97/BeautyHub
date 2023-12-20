import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paypal_api/paypal_api.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_event.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_state.dart';
import 'package:uuid/uuid.dart';

import '../../../dependency_injection.dart';
import '../../../models/order.dart';
import '../../../models/order_item.dart';
import '../../../shared/services/firebase_service.dart';

class TrackingOrderBloc extends Bloc<TrackingOrderEvent, TrackingOrderState> {
  final paypalRepository = getIt.get<PaypalRepository>();
  final List<OrderItem> orderItems = [];
  String idAccount;
  InvoiceDetail? detail;

  TrackingOrderBloc(this.idAccount) : super(InitTrackingOrderState()) {
    on<OnInitTrackingOrderEvent>(_onInit);
    on<OnGetInvoiceDetailEvent>(_onGetIDInvoice);
    on<OnPaymentEvent>(_onPayment);
    on<OnCancelPaymentEvent>(_onCancel);
    on<OnAddProductToTrackingOrderEvent>(_onAddProductToTrackingOrder);
    on<OnConfirmCancelPaymentEvent>(_onConfirmCancel);
  }

  Future<void> _onInit(OnInitTrackingOrderEvent event,
      Emitter<TrackingOrderState> emitter) async {
    try {
      String credentials =
          "${AppConstants.clientID}:${AppConstants.clientSecret}";
      String encoded = base64.encode(utf8.encode(credentials));
      final author = await paypalRepository.authorize(
          authorization: 'Basic $encoded', grantType: AppConstants.grantType);
      final detailInvoice = await paypalRepository.getInvoiceDetail(
          invoiceId: event.id, token: 'Bearer ${author.accessToken}');
      add(OnGetInvoiceDetailEvent(detailInvoice));
    } on DioException catch (error) {
      log('Error: ${error.message}');
    }
  }

  void _onGetIDInvoice(
      OnGetInvoiceDetailEvent event, Emitter<TrackingOrderState> emitter) {
    emitter(GetInvoiceDetailState(event.detailInvoice));
  }

  void _onAddProductToTrackingOrder(OnAddProductToTrackingOrderEvent event,
      Emitter<TrackingOrderState> emitter) {
    orderItems.add(event.orderItem);
  }

  void _onCancel(
      OnCancelPaymentEvent event, Emitter<TrackingOrderState> emitter) {
    String idOrder = const Uuid().v4();
    Order order =
        Order(idOrder, idAccount, DateTime.now(), 'CANCEL', orderItems);
    FirebaseService.createOrder(order, () {
      FirebaseService.writeOrderByUser(idOrder);
      add(OnConfirmCancelPaymentEvent());
    }, (error) => log('Error: $error'));
  }

  void _onConfirmCancel(
      OnConfirmCancelPaymentEvent event, Emitter<TrackingOrderState> emitter) {
    emitter(ConfirmCancelPaymentState());
  }

  Future<void> _onPayment(
      OnPaymentEvent event, Emitter<TrackingOrderState> emitter) async {
    try {
      EasyLoading.show();
      String credentials =
          "${AppConstants.clientID}:${AppConstants.clientSecret}";
      String encoded = base64.encode(utf8.encode(credentials));
      final author = await paypalRepository.authorize(
          authorization: 'Basic $encoded', grantType: AppConstants.grantType);
      SendInvoiceRequest request =
          SendInvoiceRequest('Test Send Invoice', true, true);
      final response = await paypalRepository.sendInvoice(
          idInvoice: event.id,
          request: request,
          token: 'Bearer ${author.accessToken}');
      if (response.href.isNotEmpty) {
        EasyLoading.dismiss();
        String idOrder = const Uuid().v4();
        Order order =
            Order(idOrder, idAccount, DateTime.now(), 'SUCCESS', orderItems);
        FirebaseService.createOrder(order, () {
          EasyLoading.dismiss();
          FirebaseService.writeOrderByUser(idOrder);
          FirebaseService.writeOrderByStore(idOrder, orderItems);
        }, (error) => log('Error: $error'));
        emitter(PaymentState(response.href));
      }
    } on DioException catch (error) {
      log('Error: ${error.message}');
    }
  }
}
