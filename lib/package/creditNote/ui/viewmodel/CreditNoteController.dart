import 'package:get/get.dart';

class CreditNoteController extends GetxController {
  // Search
  var billSearch = ''.obs;
  var itemSearch = ''.obs;

  // Selected bill index
  var selectedBillIndex = 0.obs;

  // Bills data
  var bills = <Map<String, dynamic>>[].obs;

  // Return items
  var returnItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();

    // dummy data (replace with API/Hive)
    bills.value = [
      {
        "billId": "INV-1025",
        "name": "Rahul Sharma",
        "mobile": "9876543210",
        "date": "11 May 2026",
        "total": 12450,
        "received": 12450,
        "gst": "09ABCDE1234F1Z5",
        "address": "Kanpur",
        "items": [
          {"name": "Parle G", "price": 20, "qty": 5},
          {"name": "Maggie", "price": 15, "qty": 10},
        ]
      },
      {
        "billId": "INV-1024",
        "name": "Amit Kumar",
        "mobile": "9123456780",
        "date": "10 May 2026",
        "total": 8200,
        "received": 8200,
        "gst": "09ABCDE1234F1Z5",
        "address": "Lucknow",
        "items": [
          {"name": "Rice", "price": 850, "qty": 2},
        ]
      },
    ];
  }

  // 🔍 BILL FILTER (FIXED)
  List<Map<String, dynamic>> get filteredBills {
    if (billSearch.value.isEmpty) return bills;

    return bills.where((bill) {
      final q = billSearch.value.toLowerCase();

      return bill["billId"].toString().toLowerCase().contains(q) ||
          bill["name"].toString().toLowerCase().contains(q) ||
          bill["mobile"].toString().toLowerCase().contains(q);
    }).toList()
      ..sort((a, b) => b["date"].compareTo(a["date"]));
  }

  // SELECT BILL
  void selectBill(int index) {
    selectedBillIndex.value = index;
    returnItems.clear();
  }

  Map<String, dynamic> get selectedBill =>
      filteredBills[selectedBillIndex.value];

  // ADD ITEM
  void addItem(Map<String, dynamic> item) {
    final exists =
    returnItems.any((e) => e["name"] == item["name"]);

    if (!exists) {
      returnItems.add({
        ...item,
        "returnQty": 1,
      });
    }
  }

  // REMOVE ITEM
  void removeItem(int index) {
    returnItems.removeAt(index);
  }

  // UPDATE QTY
  void updateQty(int index, int qty) {
    final item = returnItems[index];

    if (qty <= 0) return;

    if (qty <= item["qty"]) {
      returnItems[index]["returnQty"] = qty;
      returnItems.refresh();
    }
  }

  // TOTAL
  double get totalRefund {
    double total = 0;

    for (var e in returnItems) {
      total += (e["price"] * e["returnQty"]);
    }
    return total;
  }

  int get totalQty {
    int q = 0;
    for (var e in returnItems) {
      q += (e["returnQty"] as int);
    }
    return q;
  }
}