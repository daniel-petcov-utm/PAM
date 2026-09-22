import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiscountCalculatorPage(),
    );
  }
}

class DiscountCalculatorPage extends StatefulWidget {
  const DiscountCalculatorPage({super.key});

  @override
  State<DiscountCalculatorPage> createState() => _DiscountCalculatorPageState();
}

class _DiscountCalculatorPageState extends State<DiscountCalculatorPage> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  double discountValue = 0;
  double finalPrice = 0;
  double selectedDiscount = 10;

  void calculateDiscount() {
    final price = double.tryParse(priceController.text) ?? 0;
    final discount = double.tryParse(discountController.text) ?? 0;

    setState(() {
      discountValue = price * discount / 100;
      finalPrice = price - discountValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator de reducere')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Preț inițial',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: discountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Reducere (%)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            DropdownButton<double>(
              value: selectedDiscount,
              items: const [
                DropdownMenuItem(value: 5, child: Text('5%')),
                DropdownMenuItem(value: 10, child: Text('10%')),
                DropdownMenuItem(value: 20, child: Text('20%')),
                DropdownMenuItem(value: 50, child: Text('50%')),
              ],
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  selectedDiscount = value;
                  discountController.text = value.toString();
                });
              },
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calculateDiscount,
              child: const Text('Calculează'),
            ),

            const SizedBox(height: 30),

            Text('Valoarea reducerii: ${discountValue.toStringAsFixed(2)} MDL'),

            const SizedBox(height: 10),

            Text('Preț final: ${finalPrice.toStringAsFixed(2)} MDL'),
          ],
        ),
      ),
    );
  }
}
