import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {

  final product = Get.arguments;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();


  @override
  void onInit() {

    super.onInit();
  }

}