import 'package:equatable/equatable.dart';
import 'package:selling_food_store/models/detail_brand.dart';

abstract class BrandInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitBrandInfoState extends BrandInfoState {}

class DisplayBrandInfoState extends BrandInfoState {

  final DetailBrand? detailBrand;

  DisplayBrandInfoState(this.detailBrand);

  @override
  List<Object?> get props => [detailBrand];
}
