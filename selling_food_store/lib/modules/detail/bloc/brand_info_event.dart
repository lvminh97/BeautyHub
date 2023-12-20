import '../../../models/detail_brand.dart';

abstract class BrandInfoEvent {}

class LoadingBrandInfoEvent extends BrandInfoEvent {
  String idBrand;

  LoadingBrandInfoEvent(this.idBrand);
}

class DisplayBrandDetailEvent extends BrandInfoEvent {
  DetailBrand? detailBrand;

  DisplayBrandDetailEvent(this.detailBrand);

}
