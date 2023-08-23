import 'package:flutter/material.dart';

class Connect_page extends StatefulWidget {
  const Connect_page({super.key});

  @override
  State<Connect_page> createState() => _Connect_pageState();
}

class _Connect_pageState extends State<Connect_page> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFF171717),
      body: Column(
        children: [
          Row(
            children: [
               IconButton(
                  onPressed:(){},
      icon:Icon(Icons.menu,
              color: Colors.white,)),
            IconButton(onPressed: (){}, icon: Icon(Icons.search))
            ],
          )
        ],
      ),
    );
  }
}

