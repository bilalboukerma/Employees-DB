//import 'package';
import 'package:flutter/material.dart';
import 'package:employeesdb/model/employee.dart';
import 'package:employeesdb/utils/database_helper.dart';
import 'package:employeesdb/ui/employee_screen.dart';
import 'package:employeesdb/ui/employee_info.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/bezier_hour_glass_header.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';

//import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import 'package:flutter_slidable/flutter_slidable.dart';


class ListViewEmployees extends StatefulWidget{
  
  @override
    _ListViewEmployeesState createState() => new _ListViewEmployeesState();
}

class _ListViewEmployeesState extends State<ListViewEmployees>{
//final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
 static int debut=1;
  List<Employee> items = new List();
  DatabaseHelper db = new DatabaseHelper();
GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
if(debut ==1){
    db.getAllEmployees().then((employees){
      setState(() {
        employees.forEach((employeed){
          items.add(Employee.fromMap(employeed));
        });
      });
    });
    debut=0;
  }
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Employees',
      home: Scaffold(
        appBar: AppBar(
          title: Text('All Employees'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: new EasyRefresh(

            key: _easyRefreshKey,
            refreshHeader: /*BezierHourGlassHeader*/BezierCircleHeader(
              key: _headerKey,
            ),
            refreshFooter: BezierBounceFooter(
              key: _footerKey,
            ),
             child:ListView.builder(
            itemCount: items.length,
              padding:const EdgeInsets.all(15.0),
              itemBuilder: (context , position){
              return Column(
                children: <Widget>[
                  
                  Divider(height: 5.0,),
                   new Slidable(
  delegate: new SlidableDrawerDelegate(),
  actionExtentRatio: 0.25,
  child: new Container(
    color: Colors.white,
    child: new ListTile(
      leading: new CircleAvatar(
        backgroundColor: Colors.deepPurpleAccent,
                                   radius: 18.0,
                                   child: Text('${items[position].id}',
                                     style: TextStyle(fontSize: 22.0,color: Colors.white
                                     ),
                                   ),
                                 ),
      title: new Text('${items[position].fullName}',
                               style: TextStyle(fontSize: 22.0,color: Colors.black//yellow[700]
                               )),
      subtitle: new Text('${items[position].adresse} - ${items[position].city} - ${items[position].department}',
                               style: TextStyle(fontSize: 14.0,fontStyle: FontStyle.italic,
                               ),
                             ),
    ),
  ),
  actions: <Widget>[
   /* new IconSlideAction(
      caption: 'Update',
      color: Colors.blue,
      icon: Icons.archive,
      onTap:
    ),*/
    new IconSlideAction(
      caption: 'Delete',
      color: Colors.red,
      icon: Icons.delete,
      onTap: () => _deleteEmployee(context,items[position],position)
    ),
    new IconSlideAction(
      caption: 'Edit',
      color: Colors.yellowAccent[400],
      icon: Icons.edit,
      onTap: () => _navigateToEmployee(context , items[position]),
    ),
  ],
  secondaryActions: <Widget>[
    new IconSlideAction(
      caption: 'More',
      color: Colors.black45,
      icon: Icons.more_horiz,
      onTap: ()=> _navigateToEmployeeInfo(context , items[position]),
    ),
    
  ],
  
),


                ],

              );
             }
          ),

          onRefresh: () async{
              await new Future.delayed(const Duration(seconds: 2), () {
                //setState(() {
                 db.getAllEmployees().then((employees){
      setState(() {
        items.clear();
        employees.forEach((employeed){
          items.add(Employee.fromMap(employeed));
        });
      });
    //});
                });
              });
            },
          /*  loadMore: () async {
              await new Future.delayed(const Duration(seconds: 1), () {
                if (str.length < 20) {
                  setState(() {
                    str.addAll(addStr);
                  });
                }
              });
            },*/
            ), 
        ),

        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () => _createNewEmployee(context)),
      )
    );
  
  
   

    

  }



_deleteEmployee(BuildContext context,Employee employee,int position) async{
    db.deleteEmployee(employee.id).then((employees){
      setState(() {
        items.removeAt(position);
      });
    });
  }


 void  _navigateToEmployee(BuildContext context ,Employee employee)async{
    String result = await Navigator.push(
        context,
      MaterialPageRoute(builder:(context) => EmployeeScreen(employee)),
    );

    if(result == 'update'){
      db.getAllEmployees().then((employees){
         setState(() {
           items.clear();
           employees.forEach((employee){
             items.add(Employee.fromMap(employee));
           });
         });
      });
    }
 }




  void  _navigateToEmployeeInfo(BuildContext context ,Employee employee)async{
      await Navigator.push(
      context,
      MaterialPageRoute(builder:(context) => EmployeeInfo(employee)),
    );


  }



 void _createNewEmployee(BuildContext context) async{
   String result = await Navigator.push(
     context,
     MaterialPageRoute(builder:(context) => EmployeeScreen(
         Employee(  '', '', '', '', ''))),
   );

   if(result == 'save'){
     db.getAllEmployees().then((employees){
       setState(() {
         items.clear();
         employees.forEach((employee){
           items.add(Employee.fromMap(employee));
         });
       });
     });
   }
 }


}

  


 