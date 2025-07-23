import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Addfunction extends StatefulWidget {
  bool Function({required String todoText}) addTodo;
 Addfunction({super.key, required this.addTodo});

  @override
  State<Addfunction> createState() => _AddfunctionState();
}

class _AddfunctionState extends State<Addfunction> {
  TextEditingController todoText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        
        Text("TASK",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),

        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            autocorrect: true,
            autofocus: true,
            onSubmitted: (value) {
              if(todoText.text.trim().isNotEmpty){
                widget.addTodo(todoText: todoText.text.trim());
              }
              todoText.text = "";
            },
            controller: todoText,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: "Write your task",hintStyle: TextStyle(color: Colors.black),
              labelText: "Tap to write here..."
            ),
          ),
        ),

        SizedBox(height: 20,),

        ElevatedButton(onPressed: ()async{

          String input = todoText.text.trim();
          

          if(input.trim().isEmpty){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Text cant be Empty!")));

            return;
          }

          bool added = widget.addTodo(todoText: input.trim());

          if(added){
            todoText.text = "";
            FocusScope.of(context).unfocus(); //hide keyboard
            Navigator.pop(context);
          }
        }, child: Text("Add"))
      ],
    );
  }
}