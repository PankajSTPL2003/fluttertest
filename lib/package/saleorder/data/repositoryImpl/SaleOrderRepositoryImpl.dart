
import 'package:fluttertest/package/model/SaleDetails.dart';

import '../../domain/repository/SaleOrderRepository.dart';
import '../dataSource/hive/HiveServiceSaleOrder.dart';

class SaleOrderRepositoryImpl extends SaleOrderRepository
{
  final HiveServiceSaleOrder _hiveServiceSOrder;


  SaleOrderRepositoryImpl(this._hiveServiceSOrder);

  @override
  Future<List<SaleDetails>> saleOrders() async{
    return await _hiveServiceSOrder.saleOrders();

  }

  @override
  Future<List<SaleDetails>> saleOrdersWithEntity(String entity) async {

    return await _hiveServiceSOrder.saleOrdersWithEntity(entity);
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