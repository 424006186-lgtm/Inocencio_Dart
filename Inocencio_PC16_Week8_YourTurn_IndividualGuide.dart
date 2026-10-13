double calculateItemTotal(String rawPrice, int quantity) {
  double? price = double.tryParse(rawPrice.trim());

  if (price == null) {
    throw FormatException("'$rawPrice' is not a valid decimal price.");
  }

  if (price < 0 || quantity <= 0) {
    throw ArgumentError("Price and quantity must be greater than zero.");
  }

  double subtotal = 0.0;
  for (int i = 0; i < quantity; i++) {
    subtotal += price;
  }

  if (quantity >= 5) {
    print("  -> Bulk discount applied (10% off for 5+ items)!");
    subtotal *= 0.90;
  } else {
    print("  -> Standard pricing applied (No discount).");
  }

  return subtotal;
}

void main() {
  List<Map<String, dynamic>> testOrderItems = [
    {"price": "19.99", "qty": 3},
    {"price": "10.00", "qty": 6},
    {"price": "abc_invalid", "qty": 2},
    {"price": "-5.50", "qty": 1},
    {"price": "4.50", "qty": 4},
  ];

  double grandTotal = 0.0;

  print("=== Processing Order Line Items ===\n");

  for (int index = 0; index < testOrderItems.length; index++) {
    var item = testOrderItems[index];
    print(
      "Item #${index + 1}: Price = '${item['price']}', Qty = ${item['qty']}",
    );

    try {
      double total = calculateItemTotal(item['price'], item['qty']);
      grandTotal += total;
      print("  -> Item Total: \$${total.toStringAsFixed(2)}\n");
    } catch (e) {
      print("  [ERROR] Could not process item #${index + 1}: $e\n");
    }
  }

  print("=== Summary ===");
  print("Grand Total for Valid Items: \$${grandTotal.toStringAsFixed(2)}");
}
