import 'package:fluttertest/package/sOrder/data/dataSource/hive/HiveServiceSOrder.dart';
import 'package:fluttertest/package/sOrder/model/SaleDetails.dart';

import '../../domain/repository/SOrderRepository.dart';

class SOrderRepositoryImpl extends SOrderRepository
{
  final HiveServiceSOrder _hiveServiceSOrder;


  SOrderRepositoryImpl(this._hiveServiceSOrder);

  @override
  Future<List<SaleDetails>> SOrders() async{
    return await _hiveServiceSOrder.SOrders();

  }

  @override
  Future<List<SaleDetails>> SOrdersWithEntity(String entity) async {

    return await _hiveServiceSOrder.SOrdersWithEntity(entity);
  }

  @override
  Future<bool> addSOrder(SaleDetails sOrder) async{
    return await _hiveServiceSOrder.addSOrder(sOrder);
  }

  @override
  Future<bool> updateSorder(SaleDetails sale) async{
    return await _hiveServiceSOrder.updateSorder(sale);
  }
  @override
  Future<bool> markSaleOrderCompleted(String orderId) async {
  return await _hiveServiceSOrder.markSaleOrderCompleted(orderId);
  }

}