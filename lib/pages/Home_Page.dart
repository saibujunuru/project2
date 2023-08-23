import 'package:flutter/material.dart';
import 'Todo_Page.dart';
import '/pages/Cryom_Page.dart';
import 'memPage.dart';
import 'MasterPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
int _selectedIndex = 0;
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Memdi',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body:pages(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
         const BottomNavigationBarItem(icon: Icon(Icons.camera),
          label: "CRYOME",
          backgroundColor: Colors.black,
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.list_alt),
          label: "TODO",
          backgroundColor: Colors.black,
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.home),
          label: "Home",
          backgroundColor: Colors.black,
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.school),
          label: "Mastery",
          backgroundColor: Colors.black,

        ),

      ],
      currentIndex: _selectedIndex,
      onTap: (value)
        {
          setState(() {
            _selectedIndex = value;

          });

        },
        fixedColor: Colors.white70,
      ),
    );
  }
   Widget pages()
   {switch(_selectedIndex)
   {
    case 0:
    return Center(child:cryome(),);
    case 1:
    return Center(child: TodoPage(),);
    case 2:
    return Center(child: MemdiPage(),);
    case 3:
    return Center(child: Connect_page(),);
     default :
       return Container();
   }

  }
}

