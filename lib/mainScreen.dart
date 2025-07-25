//import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:todostuffs/addFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todostuffs/appDrawer.dart';
import 'package:todostuffs/todoListBuilder.dart';
//import 'package:url_launcher/url_launcher.dart';

class Mainscreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkmode;
  const Mainscreen({super.key, required this.isDarkmode, required this.toggleTheme});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<TodoItem> todoList = [];
  bool isLoading =  true;
  bool addTodo({required String todoText}){

    String normalizedText = todoText.trim().toLowerCase();

    bool isDuplicate = todoList.any((item) => item.task.trim().toLowerCase() == normalizedText);
    if(isDuplicate){
      showDialog(
        
          context: context,
          builder: (context) {
            return AlertDialog(

              backgroundColor: Colors.red.withOpacity(.9),
              title: Text("Already exists",style: TextStyle(color: Colors.white),),
              content: Text("This todo data already exists.",style: TextStyle(color: Colors.white),),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(child: Text("Close",style: TextStyle(color: Colors.white),)))
              ],
            );
          });

      return false;
    }

    setState(() {
      todoList.insert(0, TodoItem(task: todoText, addedTime: DateTime.now()));
      updateLocalData();
    });

    return true;
    
  }

  void updateLocalData() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> formattedList = todoList.map((item) => item.toString()).toList();
  await prefs.setStringList('todoList', formattedList);
}



  void loadData() async {
  final prefs = await SharedPreferences.getInstance();
  final storedList = prefs.getStringList('todoList');

  if (storedList != null) {
    todoList = storedList.map((str) {
  try {
    return TodoItem.fromString(str);
  } catch (e) {
    print("Error parsing todo: $e"); // optional: for debugging
    return null; // skip this item
  }
}).whereType<TodoItem>().toList();

  } else {
    todoList = [];
  }

  setState(() {
    isLoading = false;
  });
}


  @override
  void initState() {
    super.initState();
    loadData();
  }


  void showaddtodoBottomSheet(){
    showModalBottomSheet(context: context,
    isScrollControlled: true,
     builder: (context){
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
            height: 200,
          width: double.infinity,
            padding: EdgeInsets.all(0),
            child: Addfunction(addTodo: addTodo,),
            
          
        
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), // loading spinner
      );
    }


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 148, 143, 148),
        shape: CircleBorder(),
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: showaddtodoBottomSheet
      ),

      drawer: Appdrawer(),
      

      appBar: AppBar(
        // backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "TODO Stuffs",
              style: TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),),
            Text("A Smart Task Organizer App",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)
          ],
        ),
        // iconTheme: IconThemeData(color: Colors.white),

        actions: [
          IconButton(
            onPressed: widget.toggleTheme, 
            icon: Icon(widget.isDarkmode ? Icons.sunny : Icons.nights_stay),

            tooltip: widget.isDarkmode ? 'Light Mode' : 'Dark Mode',
            ),

            

            
        ],

        //for thin line
        bottom: PreferredSize(
  preferredSize: Size.fromHeight(1),
  child: Container(
    color: const Color.fromARGB(255, 58, 58, 58), // or any color you want for the line
    height: 1,
  ),
),

      ),

      body:Todolistbuilder(todoList: todoList, updateLocalData: updateLocalData,)
      );
  }
}