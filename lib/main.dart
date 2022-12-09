import 'package:flutter/material.dart';
import 'button.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var userEntry = '';
  var finalAnswer = '0';

  // all buttons
  final List<String> buttonList = [
    'C', '+/-', '%', 'DEL',
    '7', '8', '9', '/',
    '4', '5', '6', 'x',
    '1', '2', '3', '-',
    '0', '.', '=', '+',
    ];

  bool isOperator(String x){
    if(x == '+' || x == '-' || x == 'x' || x == '/' || x == '%'){
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userEntry,
                      style: const TextStyle(
                        fontSize: 60.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      finalAnswer,
                      style: const TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index){
                  if(index == 0){
                    return buttonStyle(
                      onTap: (){
                        setState(() {
                          userEntry = '';
                          finalAnswer = '0';
                        });
                      },
                      color: Colors.grey.shade600,
                      textColor: Colors.white,
                      buttonText: buttonList[index],
                    );
                  }
                  // +/- button
                  else if(index == 1){
                    return buttonStyle(
                      color: Colors.grey.shade600,
                      textColor: Colors.white,
                      buttonText: buttonList[index],


                    );
                  }
                  else if(index == 2){
                    return buttonStyle(
                      onTap: (){
                        setState(() {
                          userEntry = userEntry + buttonList[index];
                        });
                      },
                      color: Colors.grey.shade600,
                      textColor: Colors.white,
                      buttonText: buttonList[index],
                    );
                  }
                  // DEL button
                  else if(index == 3){
                    return buttonStyle(
                      onTap: (){
                        setState(() {
                          userEntry = userEntry.substring(0, userEntry.length - 1);
                          if(userEntry == ''){
                            userEntry = '0';
                          }
                        });
                      },
                      color: Colors.grey.shade600,
                      textColor: Colors.white,
                      buttonText: buttonList[index],
                    );
                  }
                  // = button
                  else if(index == 18){
                    return buttonStyle(
                      onTap: (){
                        setState(() {
                          calculate();
                        });
                      },
                      color: Colors.orange,
                      textColor: Colors.white,
                      buttonText: buttonList[index],
                    );
                  }
                  else{
                    return buttonStyle(
                      onTap: (){
                        setState((){
                          userEntry += buttonList[index];
                        });
                      },
                      color: isOperator(buttonList[index]) ? Colors.grey.shade600 : Colors.grey.shade400,
                      textColor: isOperator(buttonList[index]) ? Colors.white : Colors.black,
                      buttonText: buttonList[index],
                    );
                  }
                }
              )
            )
          ),
        ]
      ),
    );
  }



  // calculate function
  void calculate(){
    String finalEquation = userEntry;
    finalEquation = finalEquation.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalEquation);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    finalAnswer = eval.toString();
  }
}
