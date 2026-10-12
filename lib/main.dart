import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() =>
      _CalculatorAppState();
}

class _CalculatorAppState
    extends State<CalculatorApp> {
  var inputUser = '';
  var result = '';
  void buttonPressed(String text) {
    setState(() {
      if (inputUser.isEmpty || inputUser == '0') {
        inputUser = text;
      } else {
        inputUser = inputUser + text;
      }
    });
  }

  Widget getRow(
    String text1,
    String text2,
    String text3,
    String text4,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgroundColor(
              text1,
            ),
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else {
              buttonPressed(text1);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getTextColor(text1),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgroundColor(
              text2,
            ),
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              if (text2 == 'ce') {
                if (inputUser == '') {
                  return;
                }
                inputUser = inputUser.substring(
                  0,
                  inputUser.length - 1,
                );
                return;
              } else {
                buttonPressed(text2);
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getTextColor(text2),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgroundColor(
              text3,
            ),
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getTextColor(text3),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgroundColor(
              text4,
            ),
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            if (text4 == '=') {
              if (inputUser == '') {
                return;
              }
              final parser = ShuntingYardParser();
              final expression = parser.parse(
                inputUser,
              );
              final contextModel = ContextModel();
              final eval = expression.evaluate(
                EvaluationType.REAL,
                contextModel,
              );
              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: getTextColor(text4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundGrey,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .stretch,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.all(
                              8.0,
                            ),
                        child: Text(
                          inputUser,
                          textAlign:
                              TextAlign.end,
                          style: TextStyle(
                            color: textGreen,
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          8,
                        ),
                        child: Text(
                          result,
                          textAlign:
                              TextAlign.end,
                          style: TextStyle(
                            fontSize: 62,
                            color: textGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceAround,
                    children: [
                      getRow(
                        'ac',
                        'ce',
                        '%',
                        "/",
                      ),
                      getRow('7', '8', '9', '*'),
                      getRow('4', '5', '6', '-'),
                      getRow('1', '2', '3', '+'),
                      getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String text) {
    var list = [
      'ac',
      'ce',
      '%',
      "/",
      '*',

      '-',

      '+',

      '=',
    ];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getTextColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}
