import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:todostuffs/mainScreen.dart';

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
                    //child: Text("|  SOCIAL LINKS : ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),)

                    child: Row(
                      children: [
                        Text("|",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 8,),
                        Icon(Icons.link,weight: 10,),
                        SizedBox(width: 10,),
                        Text("Social Links",style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    
                    ),
                  
                  
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

              SizedBox(height: 20,),

              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text("|",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 8,),
                        Icon(Icons.group,weight: 10,),
                        SizedBox(width: 10,),
                        Text("Join Our Community",style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  SizedBox(height: 7,),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(color: Colors.grey.withOpacity(.3),borderRadius: BorderRadius.circular(12)),
                  
                      child: Row(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                  
                        IconButton(
                           icon: Icon(FontAwesomeIcons.whatsapp),
                          onPressed: (){
                            launchUrl(Uri.parse("https://wa.me/9853485548"));
                          }),
                  
                          IconButton(
                          icon: Icon(FontAwesomeIcons.discord), 
                          onPressed: (){
                            launchUrl(Uri.parse("https://discord.gg/xFYNUgBBWX"));
                          }),
                  
                          // IconButton(
                          // icon: Icon(FontAwesomeIcon), 
                          // onPressed: (){
                          //   launchUrl(Uri.parse("https://github.com/Swayanshuu"));
                          // }),
                  
                          // IconButton(
                          // icon: Icon(FeatherIcons.mail), 
                          // onPressed: (){
                          //   launchUrl(Uri.parse("mailto:swayanshu119@gmail.com"));
                          // }),
                       ],
                      ),
                  
                  
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20,),

              Container(
                child: Column(
                  children: [
                    Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text("|",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 8,),
                        Icon(Icons.lightbulb,size: 18,),
                        SizedBox(width: 10,),
                        Text("About The App",style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  SizedBox(height: 7,),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 180,
                      width: 250,
                      decoration: BoxDecoration(color: Colors.grey.withOpacity(.3),borderRadius: BorderRadius.circular(12)),

                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("“This app helps you stay focused and organized by letting you create, manage, and complete your daily tasks. You can quickly add your goals, set reminders, and mark them as done once completed. It’s designed to keep your workflow simple and distraction-free.”",
                            style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold,fontSize: 14),),

                            SizedBox(height: 10,),

                            Text("“Whether it's for studies, work, or personal use, this app lets you track your progress and manage your time effectively. Stay motivated and move forward — one task at a time.”",
                        style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold),),
                          ],
                        ),

                        
                      ),
                  
                  
                    ),
                  ),
                  ],
                ),
              ),
      
              Spacer(), // pushes the folowing widget to the bottom
      
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text("© 2025 TODO Stuffs. All rights reserved.",style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold, fontSize: 10),),
              ),
            ],
          ),
    );
  }
}