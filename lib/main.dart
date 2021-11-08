import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverter());
}

/// This is the main application widget.
class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  TextEditingController t1 = TextEditingController();
  String desc = "No record";
  String result = "";
  String toCurrency = "";
  String dropdownValueA = 'JPY';
  String dropdownValueB = 'JPY';
  List<String> currencyListA = [
    'JPY',
    'BGN',
    'CZK',
    'DKK',
    'GBP',
  ];
  List<String> currencyListB = [
    'JPY',
    'BGN',
    'CZK',
    'DKK',
    'GBP',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/Cc5.png', scale: 2),
              const Text("Currency Converter",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              DropdownButton(
                value: dropdownValueA,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                itemHeight: 60,
                onChanged: (newValue) {
                  setState(() {
                    dropdownValueA = newValue.toString();
                  });
                },
                items: currencyListA.map((dropdownValue) {
                  return DropdownMenuItem(
                    child: Text(
                      dropdownValue,
                    ),
                    value: dropdownValue,
                  );
                }).toList(),
              ),
              TextField(
                controller: t1,
                keyboardType: TextInputType.number,
              ),
              DropdownButton(
                value: dropdownValueB,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                itemHeight: 60,
                onChanged: (newValue) {
                  setState(() {
                    dropdownValueB = newValue.toString();
                  });
                },
                items: currencyListB.map((dropdownValue) {
                  return DropdownMenuItem(
                    child: Text(
                      dropdownValue,
                    ),
                    value: dropdownValue,
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: _converter,
                child: const Text("Convert"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                ),
              ),
              Text(result.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _converter() async {
    var url = Uri.parse(
        'https://freecurrencyapi.net/api/v2/latest?apikey=YOUR-APIKEY');
    var response = await http.get(url);
    var responseBody = json.decode(response.body);
    setState(() {
      result = (double.parse(t1.text) * (responseBody["rates"][toCurrency]))
          .toString();
    });
  }
}
