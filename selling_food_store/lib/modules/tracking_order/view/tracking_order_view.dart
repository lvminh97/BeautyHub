import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paypal_api/models/models.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_bloc.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_state.dart';
import 'package:selling_food_store/shared/widgets/items/item_product_in_tracking_order.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/tracking_order_event.dart';

class TrackingOrderView extends StatefulWidget {
  const TrackingOrderView({super.key});

  @override
  State<TrackingOrderView> createState() => _TrackingOrderViewState();
}

class _TrackingOrderViewState extends State<TrackingOrderView> {
  InvoiceDetail? detail;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackingOrderBloc, TrackingOrderState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: detail != null
            ? SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                      title: Text(
                        'Đang chờ thanh toán'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'Đơn hàng của bạn đã được tạo',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RichText(
                          text: TextSpan(
                              text: 'Tổng giá trị đơn hàng: ',
                              style: const TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                                text:
                                    '${detail!.amount!.value} ${detail!.amount!.currencyCode}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ))
                          ])),
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            detail!.recipients!.first.billingInfo!.email!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            detail!.recipients!.first.billingInfo!.address!
                                .address,
                            style: const TextStyle(
                                color: Colors.black38, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            ItemProductInTrackingOrder(
                                item: detail!.items![index]),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: detail!.items!.length),
                    const SizedBox(height: 8.0),
                    Container(
                      height: 8.0,
                      color: Colors.grey.shade100,
                    ),
                    const SizedBox(height: 8.0),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Chi tiết đơn hàng',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Mã số đơn hàng',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black38,
                            ),
                          ),
                          Text(
                            detail!.id,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ngày đặt hàng',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black38,
                            ),
                          ),
                          Text(
                            '${detail!.detail?.invoiceDate}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phương thức thanh toán',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black38,
                            ),
                          ),
                          Text(
                            'PayPal',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
        persistentFooterButtons: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: MaterialButton(
                  height: 48.0,
                  onPressed: () {
                    context
                        .read<TrackingOrderBloc>()
                        .add(OnCancelPaymentEvent());
                  },
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.5, color: Colors.black),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  elevation: 0.0,
                  color: Colors.white,
                  child: Text(
                    'cancel'.tr(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: MaterialButton(
                  height: 48.0,
                  onPressed: () {
                    context
                        .read<TrackingOrderBloc>()
                        .add(OnPaymentEvent(detail!.id));
                  },
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  color: Colors.green,
                  child: Text(
                    'payment'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    }, listener: (context, state) async {
      if (state is GetInvoiceDetailState) {
        detail = state.detail;
      } else if (state is PaymentState) {
        await launchUrl(Uri.parse(state.urlRequest));
        backToHome();
      } else if (state is ConfirmCancelPaymentState) {
        backToHome();
      }
    });
  }

  void backToHome() {
    Navigator.popUntil(context, ModalRoute.withName('home'));
  }
}
