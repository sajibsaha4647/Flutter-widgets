import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:date_time_picker/date_time_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  var _value = 10.0;
  // Initial Selected Value
  String? dropdownvalue;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  bool checked = false;
  bool fades = false;
  bool switchs = false;
  bool animatedContainer = false;

  DateTime? dateTime;
  TimeOfDay? timeOfDay;

  void getDates() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().day),
        firstDate: DateTime(DateTime.now().day),
        lastDate: DateTime(DateTime.now().year + 6));
    setState(() {
      dateTime = date;
    });
  }

  void getTimes() async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      timeOfDay = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Flutter widgets"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //flutter snack
              Builder(builder: (BuildContext con) {
                return ElevatedButton(
                    onPressed: () {
                      Scaffold.of(con).showSnackBar(SnackBar(
                        content: Text("I am snacbar"),
                        duration: Duration(seconds: 10),
                        action: SnackBarAction(label: "ok", onPressed: () {}),
                      ));
                    },
                    child: const Text("click"));
              }),
              ElevatedButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "This is Center Short Toast",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: const Text("toast")),
              SizedBox(
                height: 50,
              ),
              Text(
                "slider text",
                style: TextStyle(fontSize: _value),
              ),
              Slider(
                  min: 10,
                  max: 50,
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              RichText(
                  text: TextSpan(
                      text: "you did not have an account",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      children: [
                    TextSpan(
                      text: " ?signup",
                      style: TextStyle(fontSize: 22, color: Colors.green),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Fluttertoast.showToast(
                              msg: "Signup",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                    )
                  ])),
              // Text(selected,style: TextStyle(fontSize: 30),),
              DropdownButton(
                  // Initial Value
                  hint: Text("SELECT WORKSPACE"),
                  value: dropdownvalue,
                  onChanged: (dropdownValueSelected) {
                    setState(() {
                      dropdownvalue = dropdownValueSelected.toString();
                    });
                  },
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items != null && items.length > 0
                      ? items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList()
                      : null),
              ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.horizontal,
                        // shrinkWrap: true,
                        background: Container(
                          color: Colors.pink,
                          child: Icon(Icons.delete),
                        ),
                        onDismissed: (direction) {
                          print(direction);
                        },
                        child: ListTile(
                          title: Text("title"),
                          subtitle: Text("this is subtitle"),
                        ));
                  }),
              Container(
                alignment: Alignment.topLeft,
                child: Checkbox(
                    value: checked,
                    onChanged: (e) {
                      setState(() {
                        checked = e!;
                      });
                    }),
              ),
              AnimatedCrossFade(
                  firstChild: Container(
                    height: 50,
                    color: Colors.orange,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          fades = true;
                        });
                      },
                      child: Text("click"),
                    ),
                  ),
                  secondChild: Container(
                    height: 50,
                    // color: Colors.green,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          fades = false;
                        });
                      },
                      child: Text("Welcome"),
                    ),
                  ),
                  crossFadeState: fades
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(seconds: 1)),
              Switch(
                  value: switchs,
                  onChanged: (e) {
                    setState(() {
                      switchs = e;
                    });
                  }),
              AnimatedContainer(
                  height: animatedContainer ? 150 : 100,
                  width: animatedContainer ? 150 : 100,
                  color: animatedContainer ? Colors.green : Colors.orange,
                  duration: Duration(seconds: 1)),
              RaisedButton(
                  child: Text("animated container"),
                  onPressed: () {
                    setState(() {
                      animatedContainer = !animatedContainer;
                    });
                  }),
              ExpansionTile(
                title: Text("title"),
                subtitle: Text("subtitle"),
                leading: Icon(Icons.account_balance),
                children: [
                  Container(
                    height: 50,
                    color: Colors.orange,
                  )
                ],
              ),
              Tooltip(
                message: "this is icon",
                child: Icon(Icons.account_balance),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    color: Colors.orange,
                    child: Text("Back drop filter"),
                  ),
                  // BackdropFilter(filter: ImageFilter.blur(sigmaX: 5,sigmaY: 10,tileMode: TileMode.clamp), child: Container(),)
                ],
              ),
              DateTimePicker(
                // type: DateTimePickerType.dateTimeSeparate,
                type: DateTimePickerType.date,

                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onChanged: (val) => print(val),
                onSaved: (val) => print(val),
              ),
              Text(dateTime == '' || dateTime == null
                  ? "choose date"
                  : dateTime.toString()),
              Text(timeOfDay == '' || timeOfDay == null
                  ? "choose time"
                  : timeOfDay.toString()),
              RaisedButton(
                  child: Text("GetDate"),
                  onPressed: () {
                    getDates();
                  }),
              RaisedButton(
                  child: Text("GetTimes"),
                  onPressed: () {
                    getTimes();
                  }),
              SizedBox(
                height: 40,
              ),
              Transform.rotate(
                angle: pi / 9,
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Transform.scale(
                scale: 1.1,
                child: Container(
                  height: 150,
                  width: 150,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Transform.translate(
                offset: Offset(50, 100),
                child: Container(
                  height: 150,
                  width: 150,
                  color: Colors.green,
                ),
              ),
              DataTable(columns: [
                DataColumn(label: Text("Name"), tooltip: "name"),
                DataColumn(label: Text("Age"), tooltip: "age"),
                DataColumn(label: Text("School"), tooltip: "school"),
                DataColumn(label: Text("Edit"), tooltip: "edit"),
              ], rows: [
                DataRow(cells: [
                  DataCell(Text("sajib")),
                  DataCell(Text("29")),
                  DataCell(Text("bdtask accademy")),
                  DataCell(Icon(Icons.account_balance))
                ]),
                DataRow(cells: [
                  DataCell(Text("sajib")),
                  DataCell(Text("29")),
                  DataCell(Text("bdtask accademy")),
                  DataCell(Icon(Icons.account_balance))
                ]),
                DataRow(cells: [
                  DataCell(Text("sajib")),
                  DataCell(Text("29")),
                  DataCell(Text("bdtask accademy")),
                  DataCell(Icon(Icons.account_balance))
                ]),
                DataRow(cells: [
                  DataCell(Text("sajib")),
                  DataCell(Text("29")),
                  DataCell(Text("bdtask accademy")),
                  DataCell(Icon(Icons.account_balance))
                ]),
              ]),

              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
