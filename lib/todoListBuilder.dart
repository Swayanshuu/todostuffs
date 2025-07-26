import 'package:flutter/material.dart';

class TodoItem {
  final String task;
  final DateTime addedTime;

  TodoItem({required this.task, required this.addedTime});

  @override
  String toString() {
    return '$task|${addedTime.toIso8601String()}';
  }

  factory TodoItem.fromString(String str) {
    final parts = str.split('|');
    return TodoItem(
      task: parts[0],
      addedTime: DateTime.parse(parts[1]),
    );
  }
}



// ignore: must_be_immutable
class Todolistbuilder extends StatefulWidget {

  

  List<TodoItem> todoList;

  void Function() updateLocalData;

  

  
Todolistbuilder({super.key, required this.todoList,required this.updateLocalData});

  @override
  State<Todolistbuilder> createState() => _TodolistbuilderState();
}

class _TodolistbuilderState extends State<Todolistbuilder> {


  void showEditdialog(int index){
    final todolist = widget.todoList[index];
    TextEditingController editController = TextEditingController(text: todolist.task); // main thing that edit the text and it is pre-filled

    showDialog(context: context,
     builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,//color changes acc. to theme
        title: Center(child: Text("EDIT",style: TextStyle(fontWeight: FontWeight.bold),)),
        content: TextField( //text input for editing
          controller: editController,
          autofocus: true,
          autocorrect: true,
          decoration: InputDecoration(
            hintText: "Update your task...",
            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            //border: OutlineInputBorder(),

            enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: const Color.fromARGB(255, 71, 72, 72)), //  Default border color
          ),
            focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: const Color.fromARGB(255, 81, 81, 81), width: 2), //  Border when focused
          ),
          ),
        ),

        //buttons i.e casancel and save and their funtions on clicking them
        actions: [

          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel",style: TextStyle(color: const Color.fromARGB(255, 105, 103, 103)))),

          ElevatedButton(onPressed: (){
            String updateText = editController.text.trim();
            if(updateText.isNotEmpty){
              setState(() {
                // upadte the list with new text
                widget.todoList[index] = TodoItem(task: updateText, addedTime: todolist.addedTime); // added the task with the wrong task's place
                widget.updateLocalData();
              });
            Navigator.pop(context);
              
            }
          }, 
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey, // background color of the save button
            foregroundColor: Colors.black //text color
          ),
          child: Text("Save",)),
        ],
      );
     });
  }

  void onItemClicked( int index){
    final todolist = widget.todoList[index];
    showModalBottomSheet(context: context,
                  
                   builder: (context){
                return Container(
                  padding: EdgeInsets.all(20),
                  height: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(onPressed: (){
                        final removedTasked = todolist.task;
                        setState(() {
                          widget.todoList.removeAt(index);
                        });
                        widget.updateLocalData();
                        Navigator.pop(context);
                      
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$removedTasked removed!")));
                      }, 
                      icon: Icon(Icons.check),
                      label: Text("Mark as done!")),

                      SizedBox(height: 10,),

                      ElevatedButton.icon(onPressed: (){
                        Navigator.pop(context); //close the bottom sheet first
                        showEditdialog(index); //then open edit dialog box
                      }, 
                      icon: Icon( Icons.edit),
                      label: Text("Edit"))
                    ],
                  )
                );
              });
  }


  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty) ? Center(child: Text("Your List is Empty!!!", style: TextStyle(color: Colors.red),)) 
      :ListView.builder(
        itemCount: widget.todoList.length,
        itemBuilder: (BuildContext context, int index){
          final todoItem = widget.todoList[index];
        return ListTile(
              onTap: (){
                onItemClicked(index);
              },
              splashColor: Colors.grey,
              // tileColor: Colors.white,  
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todoItem.task),

                  SizedBox(height: 4,),

                  Text(widget.todoList[index].addedTime.toLocal().toString().substring(0, 16).replaceFirst('T', ' '),
      style: TextStyle(fontSize: 10, color: const Color.fromARGB(255, 113, 110, 110)),)
                ],
              ),
              //subtitle: Text("Added on : ${todoItem.addedTime.toLocal().toString().substring(0,16)}"),
              
            
          );
          
      });
  }
}