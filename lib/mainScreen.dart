import 'package:flutter/material.dart';
import 'package:todostuffs/addFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todostuffs/todoListBuilder.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<String> todoList = [];
  bool addTodo({required String todoText}){

    String normalizedText = todoText.trim().toLowerCase();

    bool isDuplicate = todoList.any((item) => item.trim().toLowerCase() == normalizedText);
    if(isDuplicate){
      showDialog(
        
          context: context,
          builder: (context) {
            return AlertDialog(

              backgroundColor: Colors.red,
              title: Text("Already exists",style: TextStyle(color: Colors.white),),
              content: Text("This todo data already exists.",style: TextStyle(color: Colors.white),),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(child: Text("Close")))
              ],
            );
          });

      return false;
    }

    setState(() {
      todoList.insert(0, todoText);
      updateLocalData();
    });

    return true;
    
  }

  void updateLocalData()async{
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todoList', todoList);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = prefs.getStringList("todoList") ?? [];
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    // Super.initState
    super.initState();
  }


  void showaddtodoBottomSheet(){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          child: Addfunction(addTodo: addTodo,)
          ),
        height: 200,
        width: double.infinity,
      
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add,color: Colors.black),
        onPressed: showaddtodoBottomSheet
      ),

      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Center(child: Text(
          "Shibu",
          style: TextStyle(color: Colors.black),)),
      ),

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "TODO Stuffs",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold),),
        iconTheme: IconThemeData(color: Colors.white),

        //for thin line
        bottom: PreferredSize(
  preferredSize: Size.fromHeight(.5),
  child: Container(
    color: Colors.grey[300], // or any color you want for the line
    height: .2,
  ),
),

      ),

      body: Container(
        color: Colors.black,
        child: Todolistbuilder(todoList:   todoList, updateLocalData: updateLocalData,))
      );
  }
}