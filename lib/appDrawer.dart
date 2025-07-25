import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:todostuffs/mainScreen.dart';

class Appdrawer extends StatefulWidget {
  const Appdrawer({super.key});

  @override
  State<Appdrawer> createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                            launchUrl(Uri.parse("https://www.instagram.com/swayan.shuuu"));
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
    );
  }
}