import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Addfunction extends StatefulWidget {
  void Function({required String todoText}) addTodo;
 Addfunction({super.key, required this.addTodo});

  @override
  State<Addfunction> createState() => _AddfunctionState();
}

class _AddfunctionState extends State<Addfunction> {
  TextEditingController todoText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        
        Text("TASK",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),

        TextField(
          onSubmitted: (value) {
            if(todoText.text.isNotEmpty){
              widget.addTodo(todoText: todoText.text);
            }
            todoText.text = " ";
          },
          controller: todoText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            hintText: "Write your task",
          ),
        )
      ],
    );
  }
}