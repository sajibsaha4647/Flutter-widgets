import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  bool checked = false ;
  bool fades = false;
  bool switchs = false;
  bool animatedContainer = false ;

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
                      : null
                  ),
              ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context,i){
                    return Dismissible(key: UniqueKey(),
                        direction: DismissDirection.horizontal,
                        // shrinkWrap: true,
                        background: Container(
                          color: Colors.pink,
                          child: Icon(Icons.delete),
                        ),
                        onDismissed: (direction) {
                          print(direction);
                        },
                        child:  ListTile(
                          title: Text("title"),
                          subtitle: Text("this is subtitle"),
                        ));
              }),
              Container(
                alignment: Alignment.topLeft,
                child: Checkbox(value: checked, onChanged: (e){
                  setState(() {
                    checked = e! ;
                  });
                }),
              ),
              AnimatedCrossFade(firstChild: Container(
                height: 50,
                color: Colors.orange,
                child:ElevatedButton(
                  onPressed: (){
                    setState(() {
                      fades = true ;
                    });
                  },
                  child: Text("click"),
                ) ,
              ), secondChild:  Container(
                height: 50,
                // color: Colors.green,
                child:ElevatedButton(
                  onPressed: (){
                    setState(() {
                      fades = false ;
                    });
                  },
                  child: Text("Welcome"),
                ) ,
              ), crossFadeState:fades?CrossFadeState.showSecond : CrossFadeState.showFirst , duration: Duration(seconds: 1)),
              Switch(value: switchs, onChanged: (e){
                setState(() {
                  switchs = e;
                });
              }),
              AnimatedContainer(
                  height:animatedContainer ? 150:100,
                  width: animatedContainer ? 150:100,
                  color:animatedContainer ? Colors.green : Colors.orange,
                  duration: Duration(seconds: 1)),
              RaisedButton(
                  child: Text("animated container"),
                  onPressed: (){
                    setState(() {
                      animatedContainer = !animatedContainer;
                    });
                  }),
              ExpansionTile(title: Text("title"),subtitle: Text("subtitle"),leading: Icon(Icons.account_balance),
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






              SizedBox(height: 100,),

            ],
          ),
        ),
      ),
    ));
  }
}
