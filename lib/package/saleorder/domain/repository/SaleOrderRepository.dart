
import 'package:fluttertest/package/model/SaleDetails.dart';

abstract class SaleOrderRepository {

  Future<bool> addSOrder(SaleDetails sOrder);

  Future<List<SaleDetails>> saleOrders();

  Future<List<SaleDetails>> saleOrdersWithEntity(String entity);

  Future<bool> updateSorder(SaleDetails sale);

  Future<bool> markSaleOrderCompleted(String orderId);
}