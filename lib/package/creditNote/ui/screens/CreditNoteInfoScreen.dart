import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditNoteInfoscreen extends StatefulWidget {
  const CreditNoteInfoscreen({super.key});

  @override
  State<CreditNoteInfoscreen> createState() =>
      _CreditNoteInfoscreenState();
}

class _CreditNoteInfoscreenState
    extends State<CreditNoteInfoscreen> {
  final TextEditingController billSearchController =
  TextEditingController();

  final TextEditingController itemSearchController =
  TextEditingController();

  int selectedBillIndex = 0;
  Map<int, TextEditingController> qtyControllers = {};
  final List<Map<String, dynamic>> bills = [
    {
      "billId": "INV-1025",
      "name": "Rahul Sharma",
      "mobile": "+91 9876543210",
      "date": "11 May 2026",
      "gst": "09ABCDE1234F1Z5",
      "address": "Kanpur, Uttar Pradesh",
      "total": 12450,
      "received": 12450,
      "items": [
        {
          "name": "Parle G Biscuit",
          "price": 20,
          "qty": 5,
          "returnQty":0
        },
        {
          "name": "Maggie Noodles",
          "price": 15,
          "qty": 10,
          "returnQty":0
        },
        {
          "name": "Soap Lux",
          "price": 40,
          "qty": 4,
          "returnQty":0
        },
      ]
    },
    {
      "billId": "INV-1024",
      "name": "Amit Kumar",
      "mobile": "+91 9123456780",
      "date": "10 May 2026",
      "gst": "09ABCDE1234F1Z5",
      "address": "Lucknow, Uttar Pradesh",
      "total": 8200,
      "received": 8200,
      "items": [
        {
          "name": "Rice Bag",
          "price": 850,
          "qty": 2,
          "returnQty":0
        },
      ]
    },
  ];

  List<Map<String, dynamic>> selectedReturnItems = [];

  Map<String, dynamic> get selectedBill =>
      bills[selectedBillIndex];

  void addItem(Map<String, dynamic> item) {
    bool alreadyAdded = selectedReturnItems.any(
          (e) => e["name"] == item["name"],
    );

    if (!alreadyAdded) {
      selectedReturnItems.add({
        ...item,
        "returnQty": 1,
      });

      setState(() {});
    }
  }

  void removeItem(int index) {
    selectedReturnItems.removeAt(index);
    setState(() {});
  }

  double get totalRefund {
    double total = 0;

    for (var item in selectedReturnItems) {
      total += item["returnQty"] * item["price"];
    }

    return total;
  }

  int get totalQty {
    int qty = 0;

    for (var item in selectedReturnItems) {
      qty += item["returnQty"] as int;
    }

    return qty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar:  AppBar(
        title: Text(
          "Credit Note",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  buildSectionTitle("Search Previous Bill"),

                  const SizedBox(height: 10),

                  buildSearchBox(),

                  const SizedBox(height: 14),

                  buildBillList(),

                  const SizedBox(height: 18),

                  buildSectionTitle("Bill Details"),

                  const SizedBox(height: 10),

                  buildBillDetailsCard(),

                  const SizedBox(height: 20),

                  buildSectionTitle("Return Items"),

                  const SizedBox(height: 10),

                  buildItemSearchBox(),

                  const SizedBox(height: 12),

                  buildItemSuggestionList(),

                  const SizedBox(height: 18),

                  if (selectedReturnItems.isNotEmpty)
                    buildAddedItemsList(),

                  const SizedBox(height: 100),
                ],
              ),
            ),

            buildBottomSummary(),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: CupertinoColors.black,
      ),
    );
  }

  Widget buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: CupertinoTextField(
        controller: billSearchController,
        padding: const EdgeInsets.symmetric(vertical: 14),
        placeholder:
        "Search by Bill ID / Name / Mobile",
        prefix: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            CupertinoIcons.search,
            color: CupertinoColors.systemGrey,
          ),
        ),
        decoration: null,
      ),
    );
  }

  Widget buildBillList() {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        itemCount: bills.length,
        itemBuilder: (context, index) {
          final bill = bills[index];

          final bool selected =
              selectedBillIndex == index;

          return GestureDetector(
            onTap: () {
              selectedBillIndex = index;
              selectedReturnItems.clear();
              setState(() {});
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xffEEF3FF)
                    : CupertinoColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected
                      ? CupertinoColors.activeBlue
                      : const Color(0xffE6E8EC),
                  width: 1.2,
                ),
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue
                          .withOpacity(.12),
                      borderRadius:
                      BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      CupertinoIcons.doc_text_fill,
                      color:
                      CupertinoColors.activeBlue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          bill["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          bill["billId"],
                          style: const TextStyle(
                            color: CupertinoColors
                                .systemGrey,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          bill["mobile"],
                          style: const TextStyle(
                            color: CupertinoColors
                                .systemGrey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹${bill["total"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        bill["date"],
                        style: const TextStyle(
                          fontSize: 12,
                          color: CupertinoColors
                              .systemGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBillDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          rowData(
            "Customer",
            selectedBill["name"],
          ),
          rowData(
            "Bill ID",
            selectedBill["billId"],
          ),
          rowData(
            "Date",
            selectedBill["date"],
          ),
          rowData(
            "GST",
            selectedBill["gst"],
          ),
          rowData(
            "Total",
            "₹${selectedBill["total"]}",
          ),
          rowData(
            "Received",
            "₹${selectedBill["received"]}",
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              selectedBill["address"],
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowData(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: CupertinoTextField(
        controller: itemSearchController,
        padding: const EdgeInsets.symmetric(vertical: 14),
        placeholder: "Search Item",
        prefix: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            CupertinoIcons.search,
            color: CupertinoColors.systemGrey,
          ),
        ),
        decoration: null,
      ),
    );
  }

  Widget buildItemSuggestionList() {
    final items =
    List<Map<String, dynamic>>.from(
      selectedBill["items"],
    );

    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: items.map((item) {
          return GestureDetector(
            onTap: () => addItem(item),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffECECEC),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item["name"],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "₹${item["price"]}",
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildAddedItemsList() {
    return Column(
      children: List.generate(
        selectedReturnItems.length,
            (index) {
          final item =
          selectedReturnItems[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius:
              BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item["name"],
                        style: const TextStyle(
                          fontWeight:
                          FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          removeItem(index),
                      child: const Icon(
                        CupertinoIcons.delete,
                        color:
                        CupertinoColors.systemRed,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    buildInfoChip(
                      "Price",
                      "₹${item["price"]}",
                    ),
                    const SizedBox(width: 8),
                    buildInfoChip(
                      "Sold Qty",
                      "${item["qty"]}",
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Return Qty",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF2F4F7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SizedBox(
                        width: 60,
                        child: TextFormField(
                          controller: getController(index, item),

                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,

                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),

                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: "0",
                          ),

                          onChanged: (value) {
                            int qty = int.tryParse(value) ?? 1;

                            // ✅ VALIDATION
                            //if (qty < 1) qty = 1;
                           // if (qty > item["qty"]) qty = item["qty"];

                            item["returnQty"] = qty;

                            // sync controller
                            qtyControllers[index]!.text = qty.toString();

                            qtyControllers[index]!.selection =
                                TextSelection.fromPosition(
                                  TextPosition(
                                    offset: qtyControllers[index]!.text.length,
                                  ),
                                );

                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    const Text(
                      "Amount",
                      style: TextStyle(
                        color: CupertinoColors
                            .systemGrey,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "₹${item["returnQty"] * item["price"]}",
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.w700,
                        fontSize: 16,
                        color:
                        CupertinoColors.systemRed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget qtyButton(
      IconData icon,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
          color: CupertinoColors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
        ),
      ),
    );
  }

  Widget buildInfoChip(
      String title,
      String value,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF5F6FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$title : ",
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        24,
      ),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Total Return Qty",
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const Spacer(),
              Text(
                "$totalQty",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Text(
                "Total Refund",
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const Spacer(),
              Text(
                "₹${totalRefund.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color:
                  CupertinoColors.systemRed,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: CupertinoButton(
              borderRadius:
              BorderRadius.circular(16),
              color: CupertinoColors.activeBlue,
              onPressed:
              selectedReturnItems.isEmpty
                  ? null
                  : () {},
              child: const Text(
                "Create Credit Note",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: CupertinoColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController getController(int index, Map item) {
    if (!qtyControllers.containsKey(index)) {
      qtyControllers[index] = TextEditingController(
        text: item["returnQty"].toString(),
      );
    }
    return qtyControllers[index]!;
  }
}