
import '../../../model/SaleDetails.dart';
import '../../domain/repository/SaleEstimateRepository.dart';
import '../dataSource/hive/HiveServiceSaleEstimate.dart';


class SaleEstimateRepositoryImpl extends SaleEstimateRepository
{
  final HiveServiceSaleEstimate _hiveServiceSaleEstimate;


  SaleEstimateRepositoryImpl(this._hiveServiceSaleEstimate);

  @override
  Future<List<SaleDetails>> saleEstimates() async{
    return await _hiveServiceSaleEstimate.saleEstimates();

  }

  @override
  Future<List<SaleDetails>> saleEstimatesWithEntity(String entity) async {

    return await _hiveServiceSaleEstimate.saleEstimatesWithEntity(entity);
  }

  @override
  Future<bool> addSaleEstimate(SaleDetails saleEstimate) async{
    return await _hiveServiceSaleEstimate.addSaleEstimate(saleEstimate);
  }

  @override
  Future<bool> updateSaleEstimate(SaleDetails sale) async{
    return await _hiveServiceSaleEstimate.updateSaleEstimate(sale);
  }
  @override
  Future<bool> markSaleOrderCompleted(String orderId) async {
  return await _hiveServiceSaleEstimate.markSaleOrderCompleted(orderId);
  }

}