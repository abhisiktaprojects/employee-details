import 'package:employee_application/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'usermodel.dart';


void main() => runApp(Addemployee());

class Addemployee extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Add Employee'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<UserModel> createUser(String name, String salary, String age) async{
  final String apiUrl = "https://reqres.in/api/users";

  final response = await http.post(apiUrl, body: {
    "name": name,
    "salary": salary,
    "age": age

  });

  if(response.statusCode == 201){
    final String responseString = response.body;

    return userModelFromJson(responseString);
  }else{
    return null;
  }
}

class _MyHomePageState extends State<MyHomePage> {

  UserModel _user;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),backgroundColor: Color(0xFF6A1B9A),
      ),
      body:Container(
        padding: EdgeInsets.all(22),
        child: Column(
          children: <Widget>[
           Row(children:[ Text("Add new Employee Details", style:TextStyle(color:Colors.black, fontSize: 18, fontWeight: FontWeight.bold))]),

            TextFormField( decoration: InputDecoration(contentPadding:EdgeInsets.only(bottom: -18),
                hintText: 'Enter the employee name'
            ),
              controller: nameController,
            ),
            TextFormField( decoration: InputDecoration(contentPadding:EdgeInsets.only(bottom: -18),
                hintText: 'Enter the employee salary'
            ),
              controller: salaryController,
            ),
            TextFormField( decoration: InputDecoration(contentPadding:EdgeInsets.only(bottom: -18),
                hintText: 'Enter the employee age'
            ),
              controller: ageController,
            ),


            SizedBox(height: 32,),

            _user == null ? Container() :
            Text("The user ${_user.name}, ${_user.id}, ${_user.salary},${_user.age} is created successfully"),

           Padding(padding:EdgeInsets.only(top:14),child:Container(width:200,height:38,child: MaterialButton(shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(6.0),
           ),elevation: 4,
              textColor: Colors.white,
              color: Color(0xFF6A1B9A),
              onPressed: () async{
                final String name = nameController.text;
                final String salary = salaryController.text;
                final String age = ageController.text;



                final UserModel user = await createUser(name, salary, age);

                setState(() {
                  _user = user;
                });

              },
              child: Text("Submit", style: TextStyle(fontSize: 18),),
            )) )],
        ),
      ),
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}