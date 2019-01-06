import 'package:flutter/material.dart';
import 'package:employeesdb/model/employee.dart';
import 'package:employeesdb/utils/database_helper.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class EmployeeInfo extends StatefulWidget{
  final Employee employee;
  EmployeeInfo(this.employee);
  @override
  _EmployeeInfoState createState() => new _EmployeeInfoState();

}

class _EmployeeInfoState extends State<EmployeeInfo> {

  DatabaseHelper db = new DatabaseHelper();

  String age = '';
  String name = '';
  String department = '';
  String city = '';
  String description = '';
//
//  TextEditingController _ageController;
//  TextEditingController _nameController;
//  TextEditingController _departmentController;
//  TextEditingController _cityController;
//  TextEditingController _descriptionController;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

     name  = widget.employee.fullName;
      age = widget.employee.adresse;
      department = widget.employee.department;
      city = widget.employee.city;
      description = widget.employee.description;

//      _ageController = new TextEditingController(text: widget.employee.age);
//      _nameController = new TextEditingController(text: widget.employee.name);
//      _departmentController = new TextEditingController(text: widget.employee.department);
//      _cityController = new TextEditingController(text: widget.employee.city);
//      _descriptionController = new TextEditingController(text: widget.employee.description);

  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.deepPurple,
       appBar: AppBar(
         title: Text('Employee Information',
          style: TextStyle(color: Colors.white,  fontSize: 23.0),) ,
       backgroundColor: Colors.deepPurple[300],
       
//         backgroundColor:Colors.yellow,
       ),
       body: Container(
         
         margin: EdgeInsets.all(15.0),
//         alignment: Alignment.center,
         child: Column(
           children: <Widget>[
             Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
              
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    SizedBox(width: 20.0, height: 100.0),
    Text(
      "Name :",
      style: TextStyle(color: Colors.yellow,  fontSize: 43.0),
    ),
    SizedBox(width: 20.0, height: 100.0),
    RotateAnimatedTextKit(
      onTap: () {
        print("Tap Event");
      },
      text: [" $name"],
      textStyle: TextStyle(color: Colors.yellow ,fontSize: 40.0, fontFamily: "Horizon"),
    ),
  ],
),
            
            
             SizedBox(
  width: 250.0,
  child: TyperAnimatedTextKit(
    onTap: () {
        print("Tap Event");
      },
    text: [
      "",
      "adress : $age,",
      "department: $department",
      "city: $city",
       "description: $description",
    ],
    textStyle: TextStyle(color: Colors.yellow ,
        fontSize: 30.0,
        fontFamily: "Bobbers"
    ),
  ),
),
         /*     Text('name : $name',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 22.0,
                ),
              ),
             Padding(padding: EdgeInsets.only(top: 20.0)),
             Text('age : $age',
               style: TextStyle(
                 fontStyle: FontStyle.normal,
                 fontSize: 22.0,
               ),),
             Padding(padding: EdgeInsets.only(top: 20.0)),
             Text('department: $department',
               style: TextStyle(
                 fontStyle: FontStyle.normal,
                 fontSize: 22.0,
               ),),
             Padding(padding: EdgeInsets.only(top: 20.0)),
             Text('city: $city',
               style: TextStyle(
                 fontStyle: FontStyle.normal,
                 fontSize: 22.0,
               ),),
             Padding(padding: EdgeInsets.only(top: 20.0)),
             Text('description: $description',
               style: TextStyle(
                 fontStyle: FontStyle.normal,
                 fontSize: 22.0,
               ),   maxLines: 10,),
*/


           ],
         ),
       ),
     );
  }
}