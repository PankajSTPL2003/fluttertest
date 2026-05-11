import 'package:hive/hive.dart';
import '../../../../model/SaleDetails.dart';

class HiveServiceSaleOrder {

  static const String boxName = "SaleOrderDetails";

  /// Open Box
  Future<Box<SaleDetails>> _openBox() async {
    return await Hive.openBox<SaleDetails>(boxName);
  }

  /// Get All Sale Orders
  Future<List<SaleDetails>> saleOrders() async {
    try {
      final box = await _openBox();

      return box.values.toList();
    } catch (e) {
      print("SOrders Error: $e");
      return [];
    }
  }

  /// Get Sale Orders By Entity
  Future<List<SaleDetails>> saleOrdersWithEntity(String entity) async {
    try {
      final box = await _openBox();

      return box.values
          .where((e) =>
      (e.entity ?? "").toLowerCase() ==
          entity.toLowerCase())
          .toList();

    } catch (e) {
      print("SOrdersWithEntity Error: $e");
      return [];
    }
  }

  /// Add Sale Order
  Future<bool> addSOrder(SaleDetails sOrder) async {
    try {
      final box = await _openBox();

      /// If id available use it
      final key = sOrder.id ?? DateTime.now().millisecondsSinceEpoch;

      await box.put(key, sOrder);

      return true;

    } catch (e) {
      print("addSOrder Error: $e");
      return false;
    }
  }

  /// Update Sale Order
  Future<bool> updateSorder(SaleDetails sale) async {
    try {
      final box = await _openBox();

      final key = sale.id;

      if (key == null) return false;

      await box.put(key, sale);

      return true;

    } catch (e) {
      print("updateSorder Error: $e");
      return false;
    }
  }


  Future<bool> markSaleOrderCompleted(dynamic orderId) async {
    try {
      final box = await _openBox();

      // get existing order
      final SaleDetails? order = box.get(orderId);

      if (order == null) {
        print("Order not found");
        return false;
      }

      // update status
      order.status = "Completed";

      // save updated order
      await box.put(orderId, order);

      print("✅ Sale Order marked completed");

      return true;

    } catch (e) {
      print("markSaleOrderCompleted Error: $e");
      return false;
    }
  }
}