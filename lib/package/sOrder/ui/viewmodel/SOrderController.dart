import 'package:fluttertest/package/model/SDetails.dart';
import 'package:get/get.dart';

class SOrderController extends GetxController{



  RxList<SDetails> sOrders=<SDetails>[].obs;
  RxList<SDetails> filterSOrders=<SDetails>[].obs;

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