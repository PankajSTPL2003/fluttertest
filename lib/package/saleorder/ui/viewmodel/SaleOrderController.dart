
import 'package:get/get.dart';

import '../../../SEstimate/model/SaleDetails.dart';

class SaleOrderController extends GetxController{



  RxList<SaleDetails> saleOrders=<SaleDetails>[].obs;
  RxList<SaleDetails> filterSaleOrders=<SaleDetails>[].obs;

  @override
  void onReady() {
    super.onReady();

    load();

  }

  void load() {


  }
  Future<void> getSaleOrders() async
  {



  }
  Future<void> getSaleOrdersForClient(String clientId) async
  {



  }




}