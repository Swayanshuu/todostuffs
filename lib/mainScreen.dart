import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:todostuffs/addFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todostuffs/todoListBuilder.dart';
import 'package:url_launcher/url_launcher.dart';

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

            // top profile section
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

            SizedBox(height: 20,),


            // social link section
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text("SOCIAL LINKS : ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),)),
                
                
                SizedBox(height: 7,),
                
                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(color: Colors.grey.withOpacity(.3),borderRadius: BorderRadius.circular(12)),
                
                    child: Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                
                      IconButton(
                        icon: Icon(FeatherIcons.instagram), 
                        onPressed: (){
                          launchUrl(Uri.parse("instagram.com/swayan.shuuu"));
                        }),
                
                        IconButton(
                        icon: Icon(FeatherIcons.linkedin), 
                        onPressed: (){
                          launchUrl(Uri.parse("https://www.linkedin.com/in/swayanshu-sarthak-sadangi-b6751931a/"));
                        }),
                
                        IconButton(
                        icon: Icon(FeatherIcons.github), 
                        onPressed: (){
                          launchUrl(Uri.parse("https://github.com/Swayanshuu"));
                        }),
                
                        IconButton(
                        icon: Icon(FeatherIcons.mail), 
                        onPressed: (){
                          launchUrl(Uri.parse("mailto:swayanshu119@gmail.com"));
                        }),
                     ],
                    ),
                
                
                  ),
                ),
              ],
            ),

            Spacer(), // pushes the folowing widget to the bottom

            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Text("© 2025 TODO Stuffs. All rights reserved.",style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold, fontSize: 10),),
            ),
          ],
        ),
      ),

      appBar: AppBar(
        // backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "TODO Stuffs",
          style: TextStyle(
            // color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins'),),
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