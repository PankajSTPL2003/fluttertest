
import '../../../model/SaleDetails.dart';
import '../repository/SaleOrderRepository.dart';

class SaleOrderUseCase {
final SaleOrderRepository _orderRepository;


SaleOrderUseCase(this._orderRepository);

  Future<List<SaleDetails>> SOrders() async{
    return await _orderRepository.saleOrders();

  }

  Future<List<SaleDetails>> SOrdersWithEntity(String entity) async {

    return await _orderRepository.saleOrdersWithEntity(entity);
  }

  Future<bool> addSOrder(SaleDetails sOrder) async{
    return await _orderRepository.addSOrder(sOrder);
  }

  Future<bool> updateSorder(SaleDetails sale) async{
    return await _orderRepository.updateSorder(sale);
  }

  Future<bool> convertToBill(SaleDetails sale) async{
  return await _orderRepository.updateSorder(sale);
}

 Future<bool> markSaleOrderCompleted(String orderId) async {
  return await _orderRepository.markSaleOrderCompleted(orderId);
}

}