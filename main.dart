import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const numBtnClr = Color.fromARGB(255, 100, 99, 99);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //I used a local font-------------------------
      theme: ThemeData(fontFamily: 'Inconsolata'),
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expression = '';
  String sym = '';
  num number1 = 0;
  num number2 = 0;
  num result = 0;

  @override
  void initState() {
    super.initState();
    expression = '';
    sym = '';
    number1 = 0;
    number2 = 0;
    result = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SizedBox(
          width: 370,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                expression,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getButton('1', numBtnClr, Colors.white),
                  getButton('2', numBtnClr, Colors.white),
                  getButton('3', numBtnClr, Colors.white),
                  getButton('C', const Color.fromARGB(255, 192, 192, 192),
                      Colors.black),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getButton('4', numBtnClr, Colors.white),
                  getButton('5', numBtnClr, Colors.white),
                  getButton('6', numBtnClr, Colors.white),
                  getButton('+', const Color.fromARGB(255, 192, 192, 192),
                      Colors.black),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getButton('7', numBtnClr, Colors.white),
                  getButton('8', numBtnClr, Colors.white),
                  getButton('9', numBtnClr, Colors.white),
                  getButton('*', const Color.fromARGB(255, 192, 192, 192),
                      Colors.black),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getButton('0', numBtnClr, Colors.white),
                  getButton('-', const Color.fromARGB(255, 192, 192, 192),
                      Colors.black),
                  getButton('/', const Color.fromARGB(255, 192, 192, 192),
                      Colors.black),
                  getButton('=', const Color.fromARGB(255, 241, 145, 19),
                      Colors.black),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

//---------------Get new button----------------------------------
  Widget getButton(String btn, Color btnClr, Color textClr) {
    return ElevatedButton(
      onPressed: () {
        calculation(btn);
        setState(() {});
      },
      child: Text(
        btn,
        style: TextStyle(
          color: textClr,
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        backgroundColor: MaterialStateProperty.all(btnClr),
        padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
      ),
    );
  }

//----------------------Calculation-----------------------------------
  String mark = '';
  String symbols = '+-*/C=';
  void calculation(String btn) {
    if (sym == '' && number1 == 0 && btn == '-') {
      mark = '-';
      expression = '-';
    } else if (sym == '' && !symbols.contains(btn)) {
      if (number1 == 0) {
        number1 = int.parse('$mark$btn');
      } else {
        number1 = int.parse('$number1$btn');
      }
      expression = '$number1';
    } else if (number1 != 0 && number2 == 0 &&
        (btn == '+' || btn == '-' || btn == '*' || btn == '/')) {
      sym = btn;
      expression = '$number1 $sym';
    } else if (btn == '=' && number1 != 0 && sym != '' && number2 != 0) {
      if (sym == '+') {
        result = number1 + number2;
      } else if (sym == '-') {
        result = number1 - number2;
      } else if (sym == '*') {
        result = number1 * number2;
      } else {
        result = number1 / number2;
      }
      expression = '$number1 $sym $number2 = $result';
    } else if (btn == 'C') {
      result = 0;
      number1 = 0;
      number2 = 0;
      sym = '';
      expression = '';
      mark = '';
    } else if (number1 != 0 &&
        sym != '' &&
        result == 0 &&
        !symbols.contains(btn)) {
      var value = number2 == 0 ? btn : '$number2$btn';
      number2 = int.parse(value);
      expression = '$number1 $sym $number2';
    } else if (result != 0 &&
        number1 != 0 &&
        number2 != 0 &&
        sym != '' &&
        btn != 'C' &&
        btn != '=' &&
        (btn == '+' || btn == '-' || btn == '*' || btn == '/')) {
      number1 = result;
      number2 = 0;
      result = 0;
      sym = btn;
      expression = '$number1 $sym';
    }
  }
}
