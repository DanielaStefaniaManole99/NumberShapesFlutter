import 'package:flutter/material.dart';

void main() {
  runApp(const NumberShapesApp());
}

class NumberShapesApp extends StatelessWidget {
  const NumberShapesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _myController = TextEditingController();
  String _result = "";

@override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(

        appBar: AppBar(
          title: const Text('Number Shapes'),
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
        ),

        body: Column(

          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(32.0),
              child: const Text("Please insert a number to see if it is square or triangular.",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              )
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _myController,
                keyboardType: const TextInputType.numberWithOptions(),
                validator: (String? value){
                  if(value == null || value.isEmpty){
                    return "please enter an integer number";
                  }

                  final int? result = int.tryParse(value);

                  if(result == null){
                    return "please enter an integer number";
                  }
                },
              )
            ),
          ],
        ),

        floatingActionButton: Builder(
            builder: (context) {
              return FloatingActionButton(
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
                hoverElevation: 16,
                mini: true,
                onPressed: () {
                  //verificam daca inputul este un numar intreg
                  final bool valid = Form.of(context)!.validate();

                  if(valid) {
                    //verificam daca numarul este square sau triangular si salvam rezultatul intr o variabila String
                    String actualResult = checkNumber(int.parse(_myController.text));

                    //folosim setState ca sa actualizam raspunsul constant
                    setState(() {
                      _result = actualResult;
                    });

                    //functie care afiseaza widgetul Alert Dialog
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              title: Text('${int.parse(_myController.text)}'),
                              content: Text(_result),
                            )
                    );
                  }
                },
                child: const Icon(Icons.check),
              );
            }
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  //functia care verifica toate cazurile
  checkNumber(int value) {
    if (checkSquare(value) && checkTriangular(value)) {
      return 'Number $value is both SQUARE and TRIANGULAR.';
    }

    if (checkSquare(value)) {
      return 'Number $value is SQUARE.';
    }

    if (checkTriangular(value)) {
      return 'Number $value is TRIANGULAR.';
    }

    return 'Number $value is neither SQUARE or TRIANGULAR.';
  }

  //functia care verifica daca un numar este square
  checkSquare(int number) {
    for (int i=1; i*i<=number; i++) {
      if((number%i == 0) && (number/i == i)) {
        return true;
      }
    }
    return false;
  }

  //functia care verifica daca un numar este triangle
  checkTriangular(int number) {
    for (int i=1; i*i*i<=number; i++) {
      if((number%i == 0) && (number/i == i*i) && ((number/i)/i == i)) {
        return true;
      }
    }
    return false;
  }
}