import 'package:flutter/material.dart';
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          RadioListTile<String>(
            title: Text('BKash'),
            value: 'BKash',
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Nagad'),
            value: 'Nagad',
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Rocket'),
            value: 'Rocket',
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Amazon Pay'),
            value: 'Amazon Pay',
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
          SizedBox(height: 20),
          Text(
            'Selected Value: $selectedValue',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
