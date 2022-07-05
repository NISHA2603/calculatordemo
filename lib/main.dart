import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    home: SIForm(),
    theme: ThemeData(
      primaryColor: Colors.deepPurpleAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final double _minimumPadding = 5.0;
  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Simple Interest Calculator'),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(children: [
                getImageAsset(),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: principalController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'please enter principal amount';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Principal e.g.1200',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                Container(width: 20.0, height: 15.0,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: roiController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'please enter rate of interest';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'In Percent',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: termController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter team';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Team',
                              hintText: 'Time in Years',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: 20.5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ))
                      ],
                    )),
                Padding(padding: EdgeInsets.all(10.5)),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      child: Text('Calculate'),
                      onPressed: () {
                        print(principalController.text);
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            this.displayResult = _calculateTotalResult();
                          }
                          this.displayResult = _calculateTotalResult();
                        });
                      },
                    )),
                    Expanded(
                        child: ElevatedButton(
                      child: Text('Reset'),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(this.displayResult),
                )
              ]),
            )));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/cal.png');
    Image image = Image(
      image: assetImage,
      width: 125.05,
      height: 125.05,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(20.0),
    );
  }

  void _onDropDownItemSelected(newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalResult() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years , your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
