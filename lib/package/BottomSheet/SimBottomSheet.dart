import 'package:flutter/material.dart';
import 'package:fluttertest/package/SimReader/SimReader.dart';

class SimBottomSheet {

  static Future<String?> show(BuildContext context) async {

    List<dynamic> simCards = [];

    try {

      simCards = await SimReader.getSimNumbers();

    } catch (e) {

      debugPrint(e.toString());
    }

    if (simCards.isEmpty) {
      return null;
    }

    return await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {

        return SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 60),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Select SIM",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ListView.separated(
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    itemCount: simCards.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 12),
                    itemBuilder: (context, index) {

                      final sim = simCards[index];

                      final number =
                      (sim['number'] ?? "")
                          .toString();

                      final carrier =
                      (sim['carrier'] ?? "Unknown")
                          .toString();

                      return InkWell(
                        borderRadius:
                        BorderRadius.circular(18),
                        onTap: () {

                          Navigator.pop(context, number.isNotEmpty ? formatIndianNumber(number) : null,
                          );
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius:
                            BorderRadius.circular(18),
                            border: Border.all(
                              color:
                              Colors.grey.shade300,
                            ),
                          ),
                          child: Row(
                            children: [

                              Container(
                                padding:
                                const EdgeInsets.all(
                                    12),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .blue.shade100,
                                  borderRadius:
                                  BorderRadius
                                      .circular(14),
                                ),
                                child: Icon(
                                  Icons
                                      .sim_card_rounded,
                                  color: Colors
                                      .blue.shade700,
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [

                                    Text(
                                      carrier,
                                      style:
                                      const TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight
                                            .w600,
                                      ),
                                    ),

                                    const SizedBox(
                                        height: 4),

                                    Text(
                                      number.isNotEmpty
                                          ? number
                                          : "Number Not Available",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors
                                            .grey
                                            .shade700,
                                      ),
                                    ),

                                    const SizedBox(
                                        height: 4),

                                    Text(
                                      "SIM ${index + 1}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors
                                            .grey
                                            .shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Icon(
                                Icons
                                    .arrow_forward_ios_rounded,
                                size: 18,
                                color: Colors
                                    .grey.shade500,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  static String formatIndianNumber(String number) {

    number = number.trim().replaceAll(" ", "");

    // Remove all non-digit except +
    number = number.replaceAll(RegExp(r'[^\d+]'), '');

    if (number.startsWith("+")) {
      return number;
    }
    // Already with +91
    if (number.startsWith("+91")) {
      return number;
    }

    // Starts with 91
    if (number.startsWith("91")) {
      return "+$number";
    }

    // Normal 10 digit
    if (number.length == 10) {
      return "+91$number";
    }

    return number;
  }
}