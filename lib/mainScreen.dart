import 'package:flutter/material.dart';
import 'package:todostuffs/addFunction.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  void addTodo({required String todoText}){

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
      ),
    );
  }
}