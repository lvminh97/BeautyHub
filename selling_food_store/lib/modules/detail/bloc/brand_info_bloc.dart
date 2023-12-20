import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:selling_food_store/modules/detail/bloc/brand_info_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';

import 'brand_info_event.dart';

class BrandInfoBloc extends Bloc<BrandInfoEvent, BrandInfoState> {
  BrandInfoBloc() : super(InitBrandInfoState()) {
    on<LoadingBrandInfoEvent>(_onLoadingBrandInfo);
    on<DisplayBrandDetailEvent>(_onDisplayBrandInfo);
  }

  void _onLoadingBrandInfo(
      LoadingBrandInfoEvent event, Emitter<BrandInfoState> emitter) {
    FirebaseService.fetchDetailBrand(event.idBrand, (dataValue) {
      add(DisplayBrandDetailEvent(dataValue));
    }, (error) {
      log(error);
      add(DisplayBrandDetailEvent(null));
      EasyLoading.showError(error);
    });
  }

  void _onDisplayBrandInfo(
      DisplayBrandDetailEvent event, Emitter<BrandInfoState> emitter) {
    emitter(DisplayBrandInfoState(event.detailBrand));
  }
}
