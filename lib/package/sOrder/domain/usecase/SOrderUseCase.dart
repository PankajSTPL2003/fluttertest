import 'package:fluttertest/package/sOrder/domain/repository/SOrderRepository.dart';

import '../../model/SaleDetails.dart';

class SOrderUseCase {
final SOrderRepository _orderRepository;


SOrderUseCase(this._orderRepository);

  Future<List<SaleDetails>> SOrders() async{
    return await _orderRepository.SOrders();

  }

  Future<List<SaleDetails>> SOrdersWithEntity(String entity) async {

    return await _orderRepository.SOrdersWithEntity(entity);
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