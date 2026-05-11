

import '../../../model/SaleDetails.dart';

abstract class SaleEstimateRepository {

  Future<bool> addSaleEstimate(SaleDetails saleEstimate);

  Future<List<SaleDetails>> saleEstimates();

  Future<List<SaleDetails>> saleEstimatesWithEntity(String entity);

  Future<bool> updateSaleEstimate(SaleDetails sale);

  Future<bool> markSaleOrderCompleted(String orderId);
}