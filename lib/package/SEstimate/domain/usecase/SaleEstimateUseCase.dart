
import '../../../model/SaleDetails.dart';
import '../repository/SaleEstimateRepository.dart';

class SaleEstimateUseCase {
final SaleEstimateRepository _orderRepository;


SaleEstimateUseCase(this._orderRepository);

  Future<List<SaleDetails>> saleEstimate() async{
    return await _orderRepository.saleEstimates();

  }

  Future<List<SaleDetails>> saleEstimateWithEntity(String entity) async {

    return await _orderRepository.saleEstimatesWithEntity(entity);
  }

  Future<bool> addSaleEstimate(SaleDetails saleEstimate) async{
    return await _orderRepository.addSaleEstimate(saleEstimate);
  }

  Future<bool> updateSaleEstimate(SaleDetails sale) async{
    return await _orderRepository.updateSaleEstimate(sale);
  }

  Future<bool> convertToBill(SaleDetails sale) async{
  return await _orderRepository.updateSaleEstimate(sale);
}

 Future<bool> markSaleOrderCompleted(String orderId) async {
  return await _orderRepository.markSaleOrderCompleted(orderId);
}

}