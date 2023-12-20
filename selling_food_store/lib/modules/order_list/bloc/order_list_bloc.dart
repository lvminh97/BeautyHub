import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/dependency_injection.dart';
import 'package:selling_food_store/models/review.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_event.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../models/order.dart';
import '../../../shared/utils/strings.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  List<Order> orderList = [];
  List<Order> orderedList = [];
  List<Order> confirmOrderList = [];
  List<Order> successOrderList = [];
  List<Order> cancelOrderList = [];

  OrderListBloc() : super(LoadingOrderListState()) {
    on<OnLoadingOrderListEvent>(_onLoadingOrderList);
    on<OnDisplayOrderListEvent>(_onDisplayOrderList);
    on<OnCancelOrderEvent>(_onCancelOrder);
    on<OnCloseBottomSheetEvent>(_onCloseBottomSheet);
    on<OnConfirmCancelOrderEvent>(_onConfirmCancelOrder);
    on<OnErrorEvent>(_onErrorCancelOrder);
    on<OnCancelOrderSuccessEvent>(_onCancelOrderSuccess);
    on<OnFeedbackProductEvent>(_onFeedback);
  }

  void _onLoadingOrderList(
      OnLoadingOrderListEvent event, Emitter<OrderListState> emitter) {
    FirebaseService.getOrderList((dataList) {
      orderList = dataList;
      orderedList = filterOrderListFromStatus('CREATED');
      confirmOrderList = filterOrderListFromStatus('CONFIRM');
      successOrderList = filterOrderListFromStatus('SUCCESS');
      cancelOrderList = filterOrderListFromStatus('CANCEL');
      add(OnDisplayOrderListEvent(orderList, orderedList, confirmOrderList,
          successOrderList, cancelOrderList));
    }, (error) {
      add(OnErrorEvent(error));
    });
  }

  void _onDisplayOrderList(
      OnDisplayOrderListEvent event, Emitter<OrderListState> emitter) {
    emitter(DisplayOrderListState(event.allOrders, event.requestOrders,
        event.confirmOrders, event.successOrders, event.cancelOrders));
  }

  void _onCancelOrder(
      OnCancelOrderEvent event, Emitter<OrderListState> emitter) {
    emitter(CancelOrderState(event.idOrder));
  }

  void _onCloseBottomSheet(
      OnCloseBottomSheetEvent event, Emitter<OrderListState> emitter) {
    emitter(CloseBottomSheetState());
  }

  void _onConfirmCancelOrder(
      OnConfirmCancelOrderEvent event, Emitter<OrderListState> emitter) {
    FirebaseService.updateReasonForCancelOrder(event.idOrder, event.reason, () {
      add(OnCancelOrderSuccessEvent());
    }, (error) {
      add(OnErrorEvent(error));
    });
  }

  void _onFeedback(
      OnFeedbackProductEvent event, Emitter<OrderListState> emitter) {
    String idReview = const Uuid().v1();
    final prefs = getIt.get<SharedPreferences>();
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      final review = Review(idReview, idUser, event.review, event.rating ?? 0);
      FirebaseService.writeReviewForProduct(event.idProduct, review);
      emitter(FeedbackProductState());
    }
  }

  void _onCancelOrderSuccess(
      OnCancelOrderSuccessEvent event, Emitter<OrderListState> emitter) {
    emitter(ConfirmCancelOrderState());
  }

  void _onErrorCancelOrder(
      OnErrorEvent event, Emitter<OrderListState> emitter) {
    emitter(ErrorCancelOrderState(event.error));
  }

  List<Order> filterOrderListFromStatus(String value) {
    List<Order> dataList =
        orderList.where((element) => element.status == value).toList();
    return dataList;
  }
}
