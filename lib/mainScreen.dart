import 'package:flutter/material.dart';
import 'package:todostuffs/addFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todostuffs/todoListBuilder.dart';

class Mainscreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkmode;
  const Mainscreen({super.key, required this.isDarkmode, required this.toggleTheme});

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
        backgroundColor: const Color.fromARGB(255, 148, 143, 148),
        shape: CircleBorder(),
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: showaddtodoBottomSheet
      ),

      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 108, 109, 109),
              height: 200,
              width: double.infinity,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Container(height: 30,
                  width: double.infinity,),

                  ClipOval(
                    child: Image.asset(assets/images/SHIBU.jpg),
                  )
                  
                  // Container(
                  //     height: 100,
                  //     width: 100,
                  //     decoration: BoxDecoration(
                  //       color: const Color.fromARGB(255, 23, 23, 23),
                  //       borderRadius: BorderRadius.circular(1000),
                  //       border: Border.all(color: Colors.white,width: 2)
                        
                  //     ),
                  //   ),

                    SizedBox(height: 10,),

                    Text("SWAYANSHU", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25,fontFamily: 'Poppins'),),

                    SizedBox(height: 20,)
                  
                ],
              ),
            ),

            SizedBox(height: 1,),

            Text("SOCIAL LINKS: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),

            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.blueGrey),
            )
          ],
        ),
      ),

      appBar: AppBar(
        // backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "TODO Stuffs",
          style: TextStyle(
            // color: Colors.white,
            fontWeight: FontWeight.bold),),
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

      body:Todolistbuilder(todoList:   todoList, updateLocalData: updateLocalData,)
      );
  }
}