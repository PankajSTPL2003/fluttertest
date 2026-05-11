
import 'package:fluttertest/package/model/SaleDetails.dart';
import 'package:get/get.dart';

class SOrderController extends GetxController{



  RxList<SaleDetails> sOrders=<SaleDetails>[].obs;
  RxList<SaleDetails> filterSOrders=<SaleDetails>[].obs;

  @override
  void onReady() {
    super.onReady();

    load();

  }

  void load() {


  }
  Future<void> getSOrders() async
  {



  }
  Future<void> getSOrdersForClient(String clientId) async
  {



  }




}