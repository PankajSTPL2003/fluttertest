import 'package:fluttertest/package/model/SDetails.dart';
import 'package:fluttertest/package/sOrder/model/SaleDetails.dart';

abstract class SOrderRepository {

  Future<bool> addSOrder(SaleDetails sOrder);

  Future<List<SaleDetails>> SOrders();

  Future<List<SaleDetails>> SOrdersWithEntity(String entity);

  Future<bool> updateSorder(SaleDetails sale);

  Future<bool> markSaleOrderCompleted(String orderId);
}