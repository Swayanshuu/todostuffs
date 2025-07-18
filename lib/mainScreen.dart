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

                  Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/SHIBU.jpg",
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                    SizedBox(height: 10,),

                    Text("SWAYANSHU", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25,fontFamily: 'Poppins'),),

                    SizedBox(height: 20,)
                  
                ],
              ),
            ),

            SizedBox(height: 7,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Text("SOCIAL LINKS : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),)),


            SizedBox(height: 7,),


            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(.3),borderRadius: BorderRadius.circular(12)),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.linked_camera_outlined),
                    Icon(Icons.linked_camera_outlined),
                    Icon(Icons.linked_camera_outlined),
                    Icon(Icons.linked_camera_outlined),
                  ],
                )
              ),
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