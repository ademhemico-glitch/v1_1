import 'package:flutter/material.dart';

void main() {
  runApp(const SimpleCalcApp());
}

class SimpleCalcApp extends StatelessWidget {
  const SimpleCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'آلة حاسبة بسيطة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        colorScheme: const ColorScheme.dark(primary: Colors.orange),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "+") _output = (num1 + num2).toString();
      if (operand == "-") _output = (num1 - num2).toString();
      if (operand == "×") _output = (num1 * num2).toString();
      if (operand == "÷") _output = (num1 / num2).toString();
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == ".") {
      if (!output.contains(".")) {
        _output = output + buttonText;
      }
    } else {
      _output = output + buttonText;
      if (_output.startsWith("0") && _output.length > 1) {
        _output = _output.substring(1);
      }
    }

    setState(() {
      output = double.parse(_output).toString();
      if (output.endsWith(".0")) {
        output = output.substring(0, output.length - 2);
      }
    });
  }

  Widget buildButton(String buttonText, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(24.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("آلة حاسبة"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const Divider(color: Colors.white30),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  buildButton("7", Colors.grey[800]!),
                  buildButton("8", Colors.grey[800]!),
                  buildButton("9", Colors.grey[800]!),
                  buildButton("÷", Colors.orange),
                ]),
                Row(children: <Widget>[
                  buildButton("4", Colors.grey[800]!),
                  buildButton("5", Colors.grey[800]!),
                  buildButton("6", Colors.grey[800]!),
                  buildButton("×", Colors.orange),
                ]),
                Row(children: <Widget>[
                  buildButton("1", Colors.grey[800]!),
                  buildButton("2", Colors.grey[800]!),
                  buildButton("3", Colors.grey[800]!),
                  buildButton("-", Colors.orange),
                ]),
                Row(children: <Widget>[
                  buildButton(".", Colors.grey[800]!),
                  buildButton("0", Colors.grey[800]!),
                  buildButton("C", Colors.red[800]!),
                  buildButton("+", Colors.orange),
                ]),
                Row(children: <Widget>[
                  buildButton("=", Colors.green[800]!),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}