import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
import '../../../shared/widgets/general/general_button.dart';
import '../bloc/order_state.dart';
import '../bloc/update_number_product_bloc.dart';

class BottomPanel extends StatelessWidget {
  final Function() onOrder;
  const BottomPanel({
    super.key,
    required this.onOrder,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    return BlocBuilder<UpdateNumberProductBloc, OrderState>(
        builder: ((context, state) {
      if (state is DisplayTotalPriceState) {
        totalPrice = state.value + 20000;
      } else if (state is UpdateNumberProductState) {
        totalPrice = state.price + 20000;
      }
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'totalPrice'.tr(),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${AppUtils.formatPrice(totalPrice)}đ',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            GeneralButton(
              title: 'order'.tr(),
              onClick: () {
                onOrder();
              },
            )
          ],
        ),
      );
    }));
  }
}
