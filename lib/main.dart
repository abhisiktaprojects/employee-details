import 'package:employee_application/addemployee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
    home: Employeedetails(),
  ));
}

class Employeedetails extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Employeedetails> {

  Map data;
  List userData;

  Future getData() async {
    http.Response response = await http.get("http://dummy.restapiexample.com/api/v1/employees");
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
  }

  Future deletedata(String id) async {
    final http.Response response = await http.delete(
      'http://dummy.restapiexample.com/api/v1/delete/$id'
    );

    if (response.statusCode == 200) {
      data = json.decode(response.body);
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete ');
    }
  }
  Future _futureemployee;

  @override
  void initState() {
    super.initState();
    _futureemployee = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Details"),
        backgroundColor: Color(0xFF6A1B9A),
      ),
      body: Column(children:[ Row(children:[IconButton(icon:Icon( Icons.add), onPressed: () {  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Addemployee()),
      );},)]),
        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Padding(padding: EdgeInsets.only(top:14, left: 0),),SizedBox(width:48,child:Text("Name", style: TextStyle(color:Color(0xFF6A1B9A), fontSize: 18),),),
          Padding(padding: EdgeInsets.only(top:14, left: 0),),Text("Salary" ,style: TextStyle(color: Color(0xFF6A1B9A), fontSize: 18)),
          Padding(padding: EdgeInsets.only(top:14, left: 0),),Text("Age", style: TextStyle(color:Color(0xFF6A1B9A), fontSize: 18)),
          Padding(padding: EdgeInsets.only(top:14, left: 0),),Text("Id", style: TextStyle(color:Color(0xFF6A1B9A), fontSize: 18)),
          Text("", style: TextStyle(color: Colors.blue, fontSize: 18)), Text("", style: TextStyle(color: Colors.blue, fontSize: 18)),Text("", style: TextStyle(color: Colors.blue, fontSize: 18))]),Expanded(child:ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(userData[index]["avatar"]),
                  // ),
                 Padding(padding:EdgeInsets.only(left:14),child:SizedBox(width:66,child:Text("${userData[index]["employee_name"]} ",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),),),),
          Padding(padding:EdgeInsets.only(left: 14),child:Text("${userData[index]["employee_salary"]} ",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),),),
                  Padding(padding:EdgeInsets.only(left: 34),child:Text("${userData[index]["employee_age"]} ",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),)),
            Padding(padding:EdgeInsets.only(left: 34),child:Text("${userData[index]["id"]} ",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    )),),


                  IconButton(icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _futureemployee =
                            deletedata(userData[index]["id"]);
                      });
                    },
                  ),






          ],
              ),
            );
        },
      ),
      )]) );
  }


}