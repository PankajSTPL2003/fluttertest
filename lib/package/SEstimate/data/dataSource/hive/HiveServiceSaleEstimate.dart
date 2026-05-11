import 'package:hive/hive.dart';
import '../../../model/SaleDetails.dart';

class HiveServiceSaleEstimate {

  static const String boxName = "SaleEstimateDetails";

  /// Open Box
  Future<Box<SaleDetails>> _openBox() async {
    return await Hive.openBox<SaleDetails>(boxName);
  }

  /// Get All Sale Orders
  /// Get All Sale Orders
  Future<List<SaleDetails>> saleEstimates() async {
    try {
      final box = await _openBox();

      return box.values
          .cast<SaleDetails>()
          .toList();

    } catch (e) {
      print("SaleEstimates Error: $e");
      return [];
    }
  }

  /// Get Sale Orders By Entity
  Future<List<SaleDetails>> saleEstimatesWithEntity(String entity) async {
    try {
      final box = await _openBox();

      final data = box.values
          .cast<SaleDetails>() // important
          .where((e) =>
      (e.entity ?? '').toLowerCase().trim() ==
          entity.toLowerCase().trim())
          .toList();

      return data;
    } catch (e) {
      print("SaleEstimatesWithEntity Error: $e");
      return [];
    }
  }
  /// Add Sale Order
  Future<bool> addSaleEstimate(SaleDetails saleEstimate) async {
    try {
      final box = await _openBox();

      /// If id available use it
      final key = saleEstimate.id ?? DateTime.now().millisecondsSinceEpoch;

      await box.put(key, saleEstimate);

      return true;

    } catch (e) {
      print("addSaleEstimate Error: $e");
      return false;
    }
  }

  /// Update Sale Order
  Future<bool> updateSaleEstimate(SaleDetails sale) async {
    try {
      final box = await _openBox();

      final key = sale.id;

      if (key == null) return false;

      await box.put(key, sale);

      return true;

    } catch (e) {
      print("updateSaleEstimate Error: $e");
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