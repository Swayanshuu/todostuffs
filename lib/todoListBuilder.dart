import 'package:flutter/material.dart';

class Todolistbuilder extends StatefulWidget {

  List<String> todoList;

  void Function() updateLocalData;

  

  
Todolistbuilder({super.key, required this.todoList,required this.updateLocalData});

  @override
  State<Todolistbuilder> createState() => _TodolistbuilderState();
}

class _TodolistbuilderState extends State<Todolistbuilder> {

  void onItemClicked( int index){
    showModalBottomSheet(context: context,
                  
                   builder: (context){
                return Container(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(onPressed: (){
                    setState(() {
                      widget.todoList.removeAt( index);
                    });
                    widget.updateLocalData();
                    Navigator.pop(context);
                  }, child: Text("Mark as done!"))
                );
              });
  }


  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty) ? Center(child: Text("Your List is Empty!!!", style: TextStyle(color: Colors.red),)) 
      :ListView.builder(
        itemCount: widget.todoList.length,
        itemBuilder: (BuildContext context, int index){
          final todolist = widget.todoList[index];
        return ListTile(
              onTap: (){
                onItemClicked(index);
              },
              splashColor: Colors.grey,
              // tileColor: Colors.white,  
              title: Text(todolist),
              
            
          );
          
      });
  }
}